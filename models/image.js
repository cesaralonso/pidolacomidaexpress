const connection = require('../config/db-connection');

const Image = {};

Image.all = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM image', (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result });
    });
};

Image.findById = (imageId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT * FROM image WHERE idimage = ?', 
        [imageId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

Image.count = next => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`SELECT COUNT(idimage) AS count FROM image`, (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });
    });
};

Image.exist = (imageId, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('SELECT EXISTS(SELECT 1 FROM image WHERE idimage = ?) AS exist', [imageId], (error, result) => {
        if ( error )
            return next({ success: false, error: error })
        else
            return next( null, { success: true, result: result[0] });

    })
};

Image.insert = (image, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query(`INSERT INTO image SET ?`, [image], (error, result) => {
        if ( error ) 
            return next({ success: false, error: error })
        else 
            return next( null, { success: true, result: result });
    });
};

Image.update = (image, next) => {
    if ( !connection )
        return next('Connection refused');
        connection.query('UPDATE image SET ? WHERE idimage = ?', [image, image.idimage], (error, result) => {
        if ( error )
            return next({ success: false, error: error });
        else
            return next( null, { success: true, result: result});
    });
};

Image.remove = (imageId, cb) => {
    if( connection ) {
        connection.query('DELETE FROM image WHERE idimage = ?', [imageId], (error, result) => {
            if(error) return next({ success: false, error: error, message: 'An error has happened while deleting table' });
            return next(null, { success: true, result: result, message: 'Imagen eliminada!' });
        });
    }
};

Image.response = (res, error, data) => {
    if ( error )
        res.status(500).json(error);
    else 
        res.status(200).json(data);
};

module.exports = Image;