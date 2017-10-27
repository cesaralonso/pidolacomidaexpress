const connection = require('../config/db-connection');
const async = require('async');
const DynamicQueries = require('../services/dynamic-queries');

const RestaurantePlatilloHorario = {};

RestaurantePlatilloHorario.all = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM restaurante_has_platillo_has_horario', (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
};

RestaurantePlatilloHorario.findById = (res_has_pla_restaurante_idrestaurante, res_has_pla_platillo_idplatillo, next) => {
    if ( !connection )
        return next('Connection refused');
    async.waterfall([
        next => {
            connection.query('SELECT * FROM restaurante_has_platillo_has_horario WHERE res_has_pla_restaurante_idrestaurante = ? AND res_has_pla_platillo_idplatillo = ?', 
            [res_has_pla_restaurante_idrestaurante, res_has_pla_platillo_idplatillo], (error, result) => {
                return error ? next(error) : next(null, result)
                
            });
        },
        (result, next) => {
            DynamicQueries.addRelation(result, 'restaurante_has_platillo', 'res_has_pla_restaurante_idrestaurante', 'restaurante_idrestaurante', 'restaurante_has_platillo',(error, result) => {
                return error ? next(error) : next(null, result)
            });
        },
        (result, next) => {
            DynamicQueries.addRelation(result, 'horario', 'horario_idhorario', 'idhorario', 'horario',(error, result) => {
                return error ? next(error) : next(null, result)
            });
        }
    ],
    (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else 
            return next( null, { success: true, result: result });
    })

};

RestaurantePlatilloHorario.count = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`SELECT COUNT(*) AS count FROM restaurante_has_platillo_has_horario`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

RestaurantePlatilloHorario.insert = (restaurantePlatilloHorario, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`INSERT INTO restaurante_has_platillo_has_horario SET ?`, [restaurantePlatilloHorario], (error, result) => {
        if ( error ) 
            return next({ success: false, error: error })
        else 
            return next( null, { success: true, result: result });
    });
};

RestaurantePlatilloHorario.remove = (res_has_pla_restaurante_idrestaurante, res_has_pla_platillo_idplatillo, horario_idhorario, next) => {
    if( connection ) {
        connection.query(`
            DELETE FROM restaurante_has_platillo_has_horario 
            WHERE res_has_pla_restaurante_idrestaurante = ? 
            AND res_has_pla_platillo_idplatillo = ?
            AND horario_idhorario = ?`, 
            [res_has_pla_restaurante_idrestaurante, res_has_pla_platillo_idplatillo, horario_idhorario], (error, result) => {
            if(error) return next({ success: false, error: error, message: 'An error has happened while deleting table' });
            return next(null, { success: true, result: result, message: 'Horario eliminado!' });
        });
    }
};

RestaurantePlatilloHorario.response = (res, error, data) => {
    if ( error )
        res.status(500).json(error);
    else 
        res.status(200).json(data);
};

module.exports = RestaurantePlatilloHorario;