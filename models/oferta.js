const connection = require('../config/db-connection');
const { waterfall } = require('async');
const DynamicQueries = require('../services/dynamic-queries');

const Oferta = {};

Oferta.all = next => {
    if ( !connection )
        return next('Connection refused');
    connection.query('SELECT * FROM oferta', (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
};

Oferta.findById = (ofertaId, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query('SELECT * FROM oferta WHERE idoferta = ?', 
        [ofertaId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

Oferta.findByRestAndPlatId = (restauranteId, platilloId, next) => {
    if ( !connection )
        return next('Connection refused');
    waterfall([
        next => {
            connection.query(`
            SELECT * FROM oferta
            WHERE res_has_pla_restaurante_idrestaurante = ?
            AND res_has_pla_platillo_idplatillo = ?`, 
            [restauranteId, platilloId], (error, ofertaResult) => {
                error ? next(error) : next(null, ofertaResult)
            });
        },
        (ofertaResult, next) => {
            DynamicQueries.addRelation( ofertaResult, 'image', 'image_idimage', 'idimage', 'image', (error, result) => {
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

}

Oferta.removeByRestAndPlatId = (restauranteId, platilloId, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query(`
    DELETE FROM oferta 
    WHERE res_has_pla_restaurante_idrestaurante = ?
    AND res_has_pla_platillo_idplatillo = ?`, 
    [restauranteId, platilloId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
}

Oferta.count = next => {
    if ( !connection )
        return next('Connection refused');
    connection.query(`SELECT COUNT(idoferta) AS count FROM oferta`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

Oferta.exist = (ofertaId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT EXISTS(SELECT 1 FROM oferta WHERE idoferta = ?) AS exist', [ofertaId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });

    })
};

Oferta.insert = (oferta, next) => {
    if ( !connection )
        return next('Connection refused');
    connection.query(`INSERT INTO oferta SET ?`, [oferta], (error, result) => {
        if ( error ) 
            return next({ success: false, error: error })
        else 
            return next( null, { success: true, result: result });
    });
};

Oferta.update = (idoferta, oferta, next) => {
    if ( !connection )
        return next('Connection refused');
    const q = connection.query('UPDATE oferta SET ? WHERE idoferta = ?',
    [oferta, idoferta], (error, result) => {
        console.log(q.sql)
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result});
    });
};

Oferta.remove = (ofertaId, next) => {
    if( !connection )
        return next('Connection refused');
    connection.query('DELETE FROM oferta WHERE idoferta = ?', [ofertaId], (error, result) => {
        if(error) return next({ success: false, error: error, message: 'An error has happened while deleting table' });
        return next(null, { success: true, result: result, message: '¡Oferta eliminada!' });
    });
};

Oferta.response = (res, error, data) => {
    if ( error )
        res.status(500).json(error);
    else 
        res.status(200).json(data);
};

module.exports = Oferta;