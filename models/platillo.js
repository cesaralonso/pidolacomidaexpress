const connection = require('../config/db-connection');

const Platillo = {};

Platillo.all = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM platillo', (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result });
    });
};

Platillo.findById = (platilloId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM platillo WHERE idplatillo = ?', [platilloId], (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result });
    });
};

Platillo.insert = (platillo, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`INSERT INTO platillo SET ?`, [platillo], (error, result, fileds) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result });
    });
};

Platillo.response = (res, data, error) => {
    if ( error )
        res.status(500).json(error);
    else
        res.status(200).json(data);
};

module.exports = Platillo;