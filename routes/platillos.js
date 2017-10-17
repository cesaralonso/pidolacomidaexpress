const router = require('express').Router();
const Platillo = require('../models/platillo');

router
    .get('/', (req, res, next) => {
        Platillo.all( (error, data) => {
            return Platillo.response(res, error, data);
        });
    })

    .get('/:id', (req, res, next) => {
        const platilloId = req.params.id;
        Platillo.findById( platilloId, (error, data) => {
            return Platillo.response(res, error, data);
        });
    })

    .post('/', (req, res, next) => {
        const platillo = {
            idplatillo: req.body.idplatillo,
            nombre: req.body.nombre,
            descripcion: req.body.descripcion
        };
        Platillo.insert( platillo, (error, data) => {
            return Platillo.response(res, error, data);
        });
    })

module.exports = router;