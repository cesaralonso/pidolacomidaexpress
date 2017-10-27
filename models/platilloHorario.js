const connection = require('../config/db-connection');
const async = require('async');
const DynamicQueries = require('../services/dynamic-queries');

const PlatilloHorario = {};

PlatilloHorario.all = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM platilloHorario', (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
};
// Unused
// PlatilloHorario.findById = (res_has_pla_restaurante_idrestaurante, res_has_pla_platillo_idplatillo, next) => {
//     if ( !connection )
//         return next('Connection refused');
//     async.waterfall([
//         next => {
//             connection.query('SELECT * FROM platilloHorario WHERE res_has_pla_restaurante_idrestaurante = ? AND res_has_pla_platillo_idplatillo = ?', 
//             [res_has_pla_restaurante_idrestaurante, res_has_pla_platillo_idplatillo], (error, result) => {
//                 return error ? next(error) : next(null, result)
                
//             });
//         },
//         (result, next) => {
//             DynamicQueries.addRelation(result, 'restaurante_has_platillo', 'res_has_pla_restaurante_idrestaurante', 'restaurante_idrestaurante', 'restaurante_has_platillo',(error, result) => {
//                 return error ? next(error) : next(null, result)
//             });
//         },
//         (result, next) => {
//             DynamicQueries.addRelation(result, 'horario', 'horario_idhorario', 'idhorario', 'horario',(error, result) => {
//                 return error ? next(error) : next(null, result)
//             });
//         }
//     ],
//     (error, result) => {
//         if ( error )
//             return next({ success: false, error: error })
//         else 
//             return next( null, { success: true, result: result });
//     })

// };

PlatilloHorario.findByParam = (column, columnValue, next) => {
    if ( !connection )
        return next('Connection refused');
    async.waterfall([
        next => {
            connection.query(`SELECT * FROM platilloHorario WHERE ?? = ?`, [column, columnValue], (error, result) => {
                return error ? next(error) : next(null, result)
            })
        }
    ],
    (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
}

PlatilloHorario.count = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`SELECT COUNT(*) AS count FROM platilloHorario`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

PlatilloHorario.insert = (restaurantePlatilloHorario, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`INSERT INTO platilloHorario SET ?`, [restaurantePlatilloHorario], (error, result) => {
        if ( error ) 
            return next({ success: false, error: error })
        else 
            return next( null, { success: true, result: result });
    });
};

PlatilloHorario.remove = (platilloHorarioDelete, next) => {
    if( connection ) {
        console.log(platilloHorarioDelete)
        connection.query(`
            DELETE FROM platilloHorario 
            WHERE platillo_idplatillo = ? 
            AND hora_ini = ?
            AND hora_fin = ?
            AND semana_idsemana = ?`, 
            [platilloHorarioDelete.platillo_idplatillo, 
             platilloHorarioDelete.horario_ini, 
             platilloHorarioDelete.horario_fin, 
             platilloHorarioDelete.semana_idsemana], (error, result) => {
            if(error) return next({ success: false, error: error, message: 'An error has happened while deleting table' });
            console.log(result)
            return next(null, { success: true, result: result, message: 'Horario eliminado!' });
        });
    }
};

PlatilloHorario.response = (res, error, data) => {
    if ( error )
        res.status(500).json(error);
    else 
        res.status(200).json(data);
};

module.exports = PlatilloHorario;