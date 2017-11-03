const router = require('express').Router();
const PlatilloIngrediente = require('../models/platilloIngrediente');

router
    .get('/', (req, res, next) => {
        PlatilloIngrediente.all( (error, data) => {
            return PlatilloIngrediente.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        PlatilloIngrediente.count( (error, data) => {
            return PlatilloIngrediente.response(res, error, data);
        });
    })
    .get('/:id', (req, res) => {
        const platilloIngredienteId = req.params.id;
        PlatilloIngrediente.findById( platilloIngredienteId, (error, data) => {
            return PlatilloIngrediente.response(res, error, data);
        });
    })
    .delete('/:id', (req, res, next) => {
        const platilloIngredienteId = req.params.id;
        PlatilloIngrediente.remove( platilloIngredienteId, (error, data) => {
            return PlatilloIngrediente.response(res, error, data);
        });
    })
    .post('/', (req, res, next) => {
        const platilloIngrediente = {
            idrest_plat_ing: null,
            res_has_pla_restaurante_idrestaurante: req.body.restauranteId,
            res_has_pla_platillo_idplatillo: req.body.platilloId,
            ingrediente_idingrediente: req.body.ingredienteId,
            precio: req.body.precio,
            medida: req.body.medida,
            default: req.body.default
        }
        console.log(platilloIngrediente);
        PlatilloIngrediente.insert( platilloIngrediente, (error, data) => {
            console.log(error)
            return PlatilloIngrediente.response(res, error, data);
        });
    })
    

module.exports = router;