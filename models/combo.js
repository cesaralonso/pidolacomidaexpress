const connection = require('../config/db-connection');
const async = require('async');

const Combo = {};

Combo.all = next => {
    if ( !connection )
        return next('Connection refused');
    connection.query('SELECT * FROM comboNew', (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
};

Combo.findById = (comboId, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query('SELECT * FROM comboNew WHERE idcombo = ?', 
        [comboId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

Combo.count = next => {
    if ( !connection )
        return next('Connection refused');
    connection.query(`SELECT COUNT(idcombo) AS count FROM comboNew`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

Combo.exist = (comboId, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query('SELECT EXISTS(SELECT 1 FROM comboNew WHERE idcombo = ?) AS exist', [comboId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });

    })
};

Combo.insert = (combo, platillos, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.beginTransaction( err => {
        async.waterfall([
            next => {
                connection.query(`INSERT INTO comboNew SET ?`, [combo], (error, result) => {
                    error ? next(error) : next(null, result)
                });
            },
            (result, next) => {
                async.each(platillos, (platillo, nextIteration) => {
                    let platilloInsert = { combo_idcombo: result.insertId, platillo_idplatillo: platillo}
                    connection.query(`INSERT INTO comboNew_has_platillo SET ?`, [platilloInsert], (error, result) => {
                        error ? nextIteration(error) : nextIteration();
                    });
                },
                (error, result) => error ? next(error) : next(null, result) ) 
            }
        ],
        (error, result) => {
            if ( error )
                connection.rollback( () => next({ success: false, error: error }) )
            else 
                connection.commit( err => err ? next({ success: false, error: error }) : next( null, { success: true, result: result }))
        })

    })
};

Combo.update = (combo, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query('UPDATE comboNew SET ? WHERE idcombo = ?', [combo, combo.idcombo], (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result});
    });
};

Combo.remove = (comboId, next) => {
    if( !connection )
        return next('Connection refused');
    connection.query('DELETE FROM comboNew WHERE idcombo = ?', [comboId], (error, result) => {
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