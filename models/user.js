const connection = require('../config/db-connection');
const bcrypt = require('bcrypt');
const saltRounds = 10;
const jwt = require('jsonwebtoken');
const mySecretPass = process.env.SECRET_PASSWORD;


const User = {};

User.register = (user, next) => {
    if ( !connection )
        return next('Connection refused');
    // Hash password
    bcrypt.hash(user.password, saltRounds)
    .then( hash => {
        user.password = hash;
        // Insert into table
        connection.query('INSERT INTO user SET ?', [user], ( error, result ) => {
            if ( error ) {
                // WARNING: To take effect, user table must have the email field as unique column
                if (error.code === 'ER_DUP_ENTRY') {
                    return next( null, { 
                        success: false,
                        error: error,
                        message: 'Este email ya esta en uso'
                    });
                } else
                    return next({ success: false, error: error });
            }
                
            return next( null, { 
                success: true,
                result: result,
                message: '¡Registro exitoso!'
            });
        })
    })
    .catch( error => next({ success: false, error: error }) );
}

User.login = ( email, password, next ) => {
    if ( !connection )
        return next('Connection refused');

    connection.query(`
        SELECT iduser, email, password FROM user WHERE email = ?`, [email], (error, result) => {
        if ( error )
            return next( error );
        if ( result[0] ) {
            const hash = result[0].password.toString();
            console.log(hash);
            console.log(password);
            bcrypt.compare(password, hash, ( error, res ) => {
                console.log('error: ', error)
                console.log('res: ', res)
                if ( res ) {
                    const user = {
                        id_user: result[0].iduser,
                        email: result[0].email,
                        password: hash
                    }
                    // Generate token
                    const token = jwt.sign(user, mySecretPass, {
                        expiresIn: 6000
                    });
                    return next( null, { 
                        success: true,
                        message: 'Has iniciado sessión correctamente',
                        token: 'JWT ' + token 
                    });
                } else 
                    return next(null, {
                        success: false,
                        message: 'Password incorrecto'
                    });
            });
        } else {
            return next(null, {
                success: false,
                message: 'El email y password no coinciden'
            })
        }
    });
}

User.response = (res, error, data) => {
    if (error)
        res.status(500).json(error);
    else
        res.status(200).json(data);
}
  
module.exports = User;