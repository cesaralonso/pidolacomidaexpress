const router = require('express').Router();
const Platillo = require('../models/platillo');

router
    .get('/', (req, res, next) => {
        Platillo.all( (error, data) => {
            return Platillo.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        Platillo.count( (error, data) => {
            return Platillo.response(res, error, data);
        });
    })
    .get('/exist/:id', (req, res, next) => {
        Platillo.exist( req.params.id, (error, data) => {
            return Platillo.response(res, error, data);
        });
    })
    .get('/:id', (req, res, next) => {
        const platilloId = req.params.id;
        Platillo.findById( platilloId, (error, data) => {
            return Platillo.response(res, error, data);
        });
    })
    .patch('/', (req, res, next) => {
        const platillo = {
            idplatillo: req.body.idplatillo,
            nombre: req.body.nombre,
            descripcion: req.body.descripcion,
            tipoComida_idtipoComida: req.body.tipoComida_idtipoComida,
            baja: false
        };
        Platillo.update( platillo, (error, data) => {
            return Platillo.response(res, error, data);
        })
    })
    .post('/', (req, res, next) => {
        const platillo = {
            idplatillo: null,
            nombre: req.body.nombre,
            descripcion: req.body.descripcion,
            tipoComida_idtipoComida: req.body.tipoComida_idtipoComida,
            baja: false
        }
        console.log(platillo);
        Platillo.insert( platillo, (error, data) => {
            return Platillo.response(res, error, data);
        });
    })

module.exports = router;