const connection = require('../config/db-connection');
const async = require('async');
const DynamicQueries = require('../services/dynamic-queries');

const RestaurantePlatillo = {};

RestaurantePlatillo.all = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM restaurante_has_platillo', (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
};

RestaurantePlatillo.findById = (restaurantePlatilloId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM restaurante_has_platillo WHERE restaurante_idrestaurante = ?', 
        [restaurantePlatilloId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

RestaurantePlatillo.findByParam = (column, param, next) => {
    if ( connection ) {
        async.waterfall([
            next => {
                const query = connection.query(`
                SELECT * FROM restaurante_has_platillo WHERE ?? = ?
                `, [column, param], (error, result) => {
                    error ? next(error) : next(null, result)
                })
            },
            (result, next) => {
                DynamicQueries.addRelation(result, 'platillo', 'platillo_idplatillo', 'idplatillo', 'platilloInfo', (error, result) => {
                    error ? next(error) : next(null, result);
                })
            }

        ],
        (error, result) => {
            if ( error ) {
                console.log(error)
                return next({ success: false, error: error })
            }
            else
                return next( null, { success: true, result: result });
        })
    }
}

RestaurantePlatillo.count = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`SELECT COUNT(idplatillo) AS count FROM restaurante_has_platillo`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

RestaurantePlatillo.exist = (restaurantePlatilloId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT EXISTS(SELECT 1 FROM restaurante_has_platillo WHERE restaurante_idrestaurante = ?) AS exist', [restaurantePlatilloId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });

    })
};

RestaurantePlatillo.insert = (restaurantePlatillo, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`INSERT INTO restaurante_has_platillo SET ?`, [restaurantePlatillo], (error, result) => {
        if ( error ) 
            return next({ success: false, error: error })
        else 
            return next( null, { success: true, result: result });
    });
};

RestaurantePlatillo.update = (restaurantePlatillo, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query(`
    UPDATE restaurante_has_platillo SET ? WHERE restaurante_idrestaurante = ? AND platillo_idplatillo = ?`, 
    [restaurantePlatillo, restaurantePlatillo.restaurante_idrestaurante, restaurantePlatillo.platillo_idplatillo], (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else 
            return next( null, { success: true, result: result});
    });
};

RestaurantePlatillo.remove = (restaurantePlatilloId, next) => {
    if( !connection )
        return next('Connection refused');
    connection.query('DELETE FROM restaurante_has_platillo WHERE restaurante_idrestaurante = ?', [restaurantePlatilloId], (error, result) => {
        if(error) return next({ success: false, error: error, message: 'An error has happened while deleting table' });
        return next(null, { success: true, result: result, message: '¡RestaurantePlatillo eliminado!' });
    });
};

RestaurantePlatillo.response = (res, error, data) => {
    if ( error )
        res.status(500).json(error);
    else 
        res.status(200).json(data);
};

module.exports = RestaurantePlatillo;