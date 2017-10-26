const async = require('async');
const connection = require('../config/db-connection');

const DynamicQuery = { };

DynamicQuery.getElementsByColumn = (table, column, value, pivotTable, next) => {
    if ( !connection )
        return next('Connection refused');
    async.waterfall([
        next => {
            connection.query(`SELECT * FROM ?? WHERE ?? = ?`, 
            [table, column, value], (error, result) => {
                if ( error )
                    return next(error)
                else
                    return next(null, result)
            })
        },
        (items, next) => {
            async.each(items, (item, nextIteration) => {
                console.log(item);
                nextIteration();
            })
        }
    ])
}

module.exports = DynamicQuery;