const connection = require('../config/db-connection');
const async = require('async');
const DynamicQueries = require('../services/dynamic-queries');

const Restaurante = { };

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
        async.waterfall([
            next => {
                connection.query(`SELECT * FROM restaurante WHERE idrestaurante = ?`,
                [restauranteId], (error, restaurantResult) => {
                    if ( error )
                        return next(error);
                    else 
                        return next(null, restaurantResult);
                })
            },
            (restaurantResult, next) => {
                // Add direccion relation to each restaurante                
                DynamicQueries.addRelation(restaurantResult, 'direccion', 'direccion_iddireccion', 'iddireccion', 'direccion', (error, result) => {
                    return error ? next(error) : next(null, result)
                })
            }
        ],
        (error, result) =>{
            if ( error )
                return next({ success: false, error: error })
            else
                return next( null, { success: true, result: result[0] });
        })
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

Restaurante.findByParam = (column, columnValue, next) => {
    if ( !connection )
        return next('Connection refused');
    async.waterfall([
        next => {
            connection.query(`SELECT * FROM restaurante WHERE ?? = ?`, 
            [column, columnValue], (error, restaurantes) => {
                if ( error )
                    return next(error)
                else
                    return next(null, restaurantes)
            })
        },
        (restaurantes, next) => {
            // Add direccion relation to each restaurante
            DynamicQueries.addRelation(restaurantes, 'direccion', 'direccion_iddireccion', 'iddireccion', 'direccion', (error, result) => {
                return error ? next(error) : next(null, result)
            })
        }
    ],
    (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result});
    })

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

Restaurante.remove = (restauranteId, next) => {
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