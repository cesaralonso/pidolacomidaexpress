const router = require('express').Router();
const User = require('../models/user');
const passport = require('passport');

router
    .post('/register', (req, res, next) => {
        const user = {
            nombres: req.body.nombres,
            apellidos: req.body.apellidos,
            email: req.body.email,
            password: req.body.password,
            telefono_idtelefono: req.body.telefono_idtelefono,
            rol_idrol: req.body.rol_idrol,
            baja: false,
        }
        User.register( user, (error, data) =>{
            User.response(res, error, data);
        });
    })
    .post('/login', (req, res, next) => {
        const email = req.body.email;
        const password = req.body.password;
        console.log(email)
        console.log(password)
        User.login( email, password, ( error, data ) => {
            return User.response( res, error, data );
        });
    })
    // Route with authentication
    .post('/profile', passport.authenticate('jwt', { session: false }), (req, res, next) => {
        res.send('Route Authentication Works!');
    })
    // .post('/profile', (req, res, next) => { // http://passportjs.org/docs -> Custom Callback
    //     passport.authenticate('jwt', { session: false}, (err, user, info) => {
    //         console.log(user.iduser);
    //         // 
    //     })(req, res, next);
    // })

module.exports = router;