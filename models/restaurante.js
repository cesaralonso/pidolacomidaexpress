const connection = require('../config/db-connection');
const async = require('async');

const Restaurante = {};

Restaurante.all = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM restaurante', (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
};

Restaurante.findById = (restauranteId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM restaurante WHERE idrestaurante = ?', 
        [restauranteId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else {
            connection.query(`SELECT * FROM direccion WHERE iddireccion = ?`, [result[0].direccion_iddireccion], (error, resultD) => {
                if ( error ) return next({ success: false, error: error })
                else {
                    console.log('ResultD: ', resultD[0]);
                    result[0].direccion = resultD[0];
                    console.log(result);
                    return next( null, { success: true, result: result });
                }
            })
        }
    });
};

Restaurante.count = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`SELECT COUNT(idrestaurante) AS count FROM restaurante`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

Restaurante.exist = (restauranteId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT EXISTS(SELECT 1 FROM restaurante WHERE idrestaurante = ?) AS exist', [restauranteId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });

    })
};

Restaurante.insert = (restaurante, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`INSERT INTO restaurante SET ?`, [restaurante], (error, result) => {
        if ( error ) {
            console.log(error);
            return next({ success: false, error: error })
        }
        else 
            return next( null, { success: true, result: result });
    });
};

Restaurante.findByParam = (column, param, next) => {
    if ( connection ) {
        connection.query(`SELECT * FROM restaurante WHERE ?? = ?`, [column, param], (error, result) => {
        if ( error ) 
            return next({ success: false, error: error })
        else {
            connection.query(`SELECT * FROM direccion WHERE iddireccion = ?`, [result[0].direccion_iddireccion], (error, resultD) => {
                if ( error ) return next({ success: false, error: error })
                else {
                    result.direccion = resultD;
                    console.log(result);
                    return next( null, { success: true, result: result });
                }
            })
            // return next( null, { success: true, result: result });
        }
        })
    }
}

Restaurante.update = (restaurante, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('UPDATE restaurante SET ? WHERE idrestaurante = ?', [restaurante, restaurante.idrestaurante], (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result});
    });
};

Restaurante.remove = (restauranteId, cb) => {
    if( connection ) {
        connection.query('DELETE FROM restaurante WHERE idrestaurante = ?', [restauranteId], (error, result) => {
            if(error) return next({ success: false, error: error, message: 'An error has happened while deleting table' });
            return next(null, { success: true, result: result, message: 'Restaurante eliminado!' });
        });
    }
};

Restaurante.response = (res, error, data) => {
    if ( error )
        res.status(500).json(error);
    else 
        res.status(200).json(data);
};

module.exports = Restaurante;