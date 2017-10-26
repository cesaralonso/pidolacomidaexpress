const async = require('async');
const connection = require('../config/db-connection');

const DynamicQuery = { };
/**
 * @param items => The collection that it will have a new relation included for each of its elements
 * @param tableToRelate => Table to get the relation
 * @param itemColumnToRelate => Column of @items to relate
 * @param tableToRelateColumn => Column of @tableToRelate to relate
 * @param next => Callback
 * 
 * Given a table set a relation to a collection
 */
DynamicQuery.addRelation = (items, tableToRelate, itemColumnToRelate, tableToRelateColumn, next) => {
    if ( !connection )
        return next('Connection refused');
    async.each( items, (item, nextIteration) => {
        connection.query(`SELECT * FROM ?? WHERE ?? = ?`,
        [tableToRelate, tableToRelateColumn, item[itemColumnToRelate]], (error, result) => {
            if ( error )
                return next(error);
            else {
                item[tableToRelate] = result[0];
                return nextIteration();
            }
        })
    },
    err => {
        if (err)
            return next(err);
        else
            return next(null, items)
    })
}

module.exports = DynamicQuery;