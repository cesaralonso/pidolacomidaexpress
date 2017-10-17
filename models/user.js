const connection = require('../config/db-connection');

const User = {};

User.all = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM user', (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
};

User.findById = (userId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM user WHERE iduser = ?', 
        [userId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

User.count = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`SELECT COUNT(iduser) AS count FROM user`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

User.exist = (userId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT EXISTS(SELECT 1 FROM user WHERE iduser = ?) AS exist', [userId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });

    })
};

User.insert = (user, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`INSERT INTO user SET ?`, [user], (error, result) => {
        if ( error ) 
            return next({ success: false, error: error })
        else 
            return next( null, { success: true, result: result });
    });
};

User.update = (user, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('UPDATE user SET ? WHERE iduser = ?', [user, user.iduser], (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result});
    });
};

User.remove = (userId, cb) => {
    if(conn) {
        conn.query('DELETE FROM user WHERE iduser = ?', [userId], (error, result) => {
            if(error) return cb('An error has happened while deleting table');
            return cb(null, "¡User eliminado!");
        });
    }
};

User.response = (res, error, data) => {
    if ( error )
        res.status(500).json(error);
    else 
        res.status(200).json(data);
};

module.exports = User;