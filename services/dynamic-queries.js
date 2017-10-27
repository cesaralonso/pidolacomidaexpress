const async = require('async');
const connection = require('../config/db-connection');

const DynamicQuery = { };
/**
 * @param collection => The collection that it will have a new relation included for each of its elements
 * @param tableToRelate => Table to get the relation
 * @param collectionColumnToRelate => Column of @collections to relate
 * @param tableToRelateColumn => Column of @tableToRelate to relate
 * @param next => Callback
 * 
 * Given a table, set a relation to a collection
 */
DynamicQuery.addRelation = (collection, tableToRelate, collectionColumnToRelate, tableToRelateColumn, newRelationName, next) => {
    if ( !connection )
        return next('Connection refused');
    async.each( collection, (item, nextIteration) => {
        connection.query(`SELECT * FROM ?? WHERE ?? = ?`,
        [tableToRelate, tableToRelateColumn, item[collectionColumnToRelate]], (error, result) => {
            if ( error )
                return next(error);
            else {
                item[newRelationName] = result[0];
                return nextIteration();
            }
        })
    },
    err => {
        if (err)
            return next(err);
        else
            return next(null, collection)
    })
}

module.exports = DynamicQuery;