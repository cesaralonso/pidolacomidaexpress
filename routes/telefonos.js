const router = require('express').Router();
const Telefono = require('../models/telefono');

router
    .get('/', (req, res, next) => {
        Telefono.all( (error, data) => {
            return Telefono.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        Telefono.count( (error, data) => {
            return Telefono.response(res, error, data);
        });
    })
    .get('/exist/:id', (req, res, next) => {
        Telefono.exist( req.params.id, (error, data) => {
            return Telefono.response(res, error, data);
        });
    })
    .get('/:id', (req, res, next) => {
        const telefonoId = req.params.id;
        Telefono.findById( telefonoId, (error, data) => {
            return Telefono.response(res, error, data);
        });
    })
    .delete('/:id', (req, res, next) => {
        const telefonoId = req.params.id;
        Telefono.remove( telefonoId, (error, data) => {
            return Telefono.response(res, error, data);
        });
    })
    .patch('/', (req, res, next) => {
        const telefono = {
            idtelefono: req.body.email,
            created_by: req.body.email,
            numero: req.body.email,
            lada: req.body.email,
            compania: req.body.email,
        };
        Telefono.update( telefono, (error, data) => {
            return Telefono.response(res, error, data);
        })
    })
    .post('/', (req, res, next) => {
        const telefono = {
            idtelefono: null,
            created_by: req.body.email,
            numero: req.body.email,
            lada: req.body.email,
            compania: req.body.email,
        }
        console.log(telefono);
        Telefono.insert( telefono, (error, data) => {
            return Telefono.response(res, error, data);
        });
    })
    

module.exports = router;