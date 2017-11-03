const connection = require('../config/db-connection');
const async = require('async');
const DynamicQueries = require('../services/dynamic-queries');

const PlatilloIngrediente = { };
// Modificar este metodo, ya que se necesita el res_has_pla_restaurante_idrestaurante y res_has_pla_platillo_idplatillo
PlatilloIngrediente.all = (next) => {
    if ( !connection )
        return next('Connection refused');
    async.waterfall([
        next => {
            connection.query(`
            SELECT * FROM restaurante_platillo_ingrediente WHERE res_has_pla_restaurante_idrestaurante = ? AND res_has_pla_platillo_idplatillo = ?`,
            (error, result) => {
                error ? next(error) : next(null, result)
            });
        },
        (result, next) => {
            DynamicQueries.addRelation(result, 'ingrediente', 'ingrediente_idingrediente', 'idingrediente', 'info', (error, result) => {
                error ? next(error) : next(null, result)
            })
        }
    ],
    (error, result) => {
        if ( error ) 
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    })
};

PlatilloIngrediente.findById = (platilloIngredienteId, next) => {
    if ( !connection )
        return next('Connection refused');
    async.waterfall([
        next => {
            connection.query(`
            SELECT * FROM restaurante_platillo_ingrediente WHERE idrest_plat_ing = ?`, 
            [platilloIngredienteId], (error, result) => {
                error ? next(error) : next(null, result)
            });
        },
        (result, next) => {
            DynamicQueries.addRelation(result, 'ingrediente', 'ingrediente_idingrediente', 'idingrediente', 'info', (error, result) => {
                error ? next(error) : next(null, result)
            })
        }
    ],
    (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    })
};

PlatilloIngrediente.count = next => {
    if ( !connection )
        return next('Connection refused');
    connection.query(`SELECT COUNT(idrest_plat_ing) AS count FROM restaurante_platillo_ingrediente`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

// PlatilloIngrediente.exist = (platilloIngredienteId, next) => {
//     if ( !connection )
//         return next('Connection refused');
//         connection.query('SELECT EXISTS(SELECT 1 FROM restaurante_platillo_ingrediente WHERE idrol = ?) AS exist', [platilloIngredienteId], (error, result) => {
//         if ( error )
//             return next({ success: false, error: error })
//         else
//             return next( null, { success: true, result: result[0] });

//     })
// };

PlatilloIngrediente.insert = (platilloIngrediente, next) => {
    if ( !connection )
        return next('Connection refused');
    
    connection.query(`INSERT INTO restaurante_platillo_ingrediente SET ?`, [platilloIngrediente], (error, result) => {
        if ( error ) 
            return next({ success: false, error: error })
        else 
            return next( null, { success: true, result: result });
    });
};

// PlatilloIngrediente.update = (platilloIngrediente, next) => {
//     if ( !connection )
//         return next('Connection refused');
//         connection.query('UPDATE restaurante_platillo_ingrediente SET ? WHERE idrol = ?', [platilloIngrediente, platilloIngrediente.idrol], (error, result) => {
//         if ( error )
//             return next({ success: false, error: error });
//         else
//             return next( null, { success: true, result: result});
//     });
// };

PlatilloIngrediente.remove = (id,  next) => {
    if( connection ) {
        connection.query(`
        DELETE FROM restaurante_platillo_ingrediente WHERE idrest_plat_ing = ?`,
        [id], (error, result) => {
            if ( error )
                return next({ success: false, error: error, message: 'An error has happened while deleting table' });
            return next(null, { success: true, result: result, message: 'Ingrediente eliminado!' });
        });
    }
};

PlatilloIngrediente.response = (res, error, data) => {
    if ( error )
        res.status(500).json(error);
    else 
        res.status(200).json(data);
};

module.exports = PlatilloIngrediente;