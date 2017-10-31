const connection = require('../config/db-connection');
const async = require('async');
const DynamicQueries = require('../services/dynamic-queries');

const Combo = {};

Combo.all = next => {
    if ( !connection )
        return next('Connection refused');
    connection.query('SELECT * FROM combo', (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
};

Combo.findById = (comboId, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query('SELECT * FROM combo WHERE idcombo = ?', 
        [comboId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

Combo.findByParam = (column, columnValue, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query(`SELECT * FROM combo WHERE ?? = ?`, [column, columnValue], (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result});
    })
};

Combo.findByIdWithPlatillos = (comboId, next) => {
    if ( !connection )
        return next('Connection refused');
    async.waterfall([
        next => {
            connection.query(`SELECT * FROM combo WHERE idcombo = ?`,
            [comboId], (error, result) => {
                error ? next(error) : next(null, result)
            })
        },
        (result, next) => {
            
            connection.query(`
            SELECT platillo.idplatillo, platillo.nombre, platillo.descripcion, comboRP.cantidad 
            FROM combo_has_restaurante_has_platillo AS comboRP
            INNER JOIN platillo ON platillo.idplatillo = res_has_pla_platillo_idplatillo
            WHERE combo_idcombo = ?`, [result[0].idcombo], (error, resultJoin) => {
                if ( error )
                    next(error)
                else {
                    result[0].platillos = resultJoin;
                    next(null, result[0]);
                }
            })
        }
    ],
    (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result});
    })
};

Combo.count = next => {
    if ( !connection )
        return next('Connection refused');
    connection.query(`SELECT COUNT(idcombo) AS count FROM combo`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

Combo.exist = (comboId, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query('SELECT EXISTS(SELECT 1 FROM combo WHERE idcombo = ?) AS exist', [comboId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });

    })
};

Combo.insert = (combo, platillos, restauranteId, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.beginTransaction( err => {
        async.waterfall([
            next => {
                connection.query(`INSERT INTO combo SET ?`, [combo], (error, result) => {
                    error ? next(error) : next(null, result)
                });
            },
            (result, next) => {
                const platilloInsert = { 
                    combo_idcombo: result.insertId,
                    res_has_platillo_res_idrestaurante: restauranteId,
                }
                async.each(platillos, (platillo, nextIteration) => {
                    platilloInsert.res_has_pla_platillo_idplatillo = platillo.platillo_idplatillo;
                    platilloInsert.cantidad = platillo.cantidad;
                    
                    connection.query(`INSERT INTO combo_has_restaurante_has_platillo SET ?`, [platilloInsert], (error, result) => {
                        error ? nextIteration(error) : nextIteration();
                    });
                }, (error) => error ? next(error) : next(null, result) )
            }
        ],
        (error, result) => {
            if ( error )
                connection.rollback( () => next({ success: false, error: error }) )
            else 
                connection.commit( err => {
                    err 
                    ? next({ success: false, error: error })
                    : next( null, { success: true, result: result })
                })
        })

    })
};

Combo.update = (combo, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query('UPDATE combo SET ? WHERE idcombo = ?', [combo, combo.idcombo], (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result});
    });
};

Combo.remove = (comboId, next) => {
    if( !connection )
        return next('Connection refused');
    connection.query('DELETE FROM combo WHERE idcombo = ?', [comboId], (error, result) => {
        if(error) return next({ success: false, error: error, message: 'An error has happened while deleting table' });
        return next(null, { success: true, result: result, message: '¡Combo eliminado!' });
    });
};

Combo.response = (res, error, data) => {
    if ( error )
        res.status(500).json(error);
    else 
        res.status(200).json(data);
};

module.exports = Combo;