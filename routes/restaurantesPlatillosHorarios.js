const router = require('express').Router();
const RestaurantePlatilloHorario = require('../models/restaurantePlatilloHorario');

router
    .get('/', (req, res, next) => {
        RestaurantePlatilloHorario.all( (error, data) => {
            return RestaurantePlatilloHorario.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        RestaurantePlatilloHorario.count( (error, data) => {
            return RestaurantePlatilloHorario.response(res, error, data);
        });
    })
    .get('/:idrestaurante/:idplatillo', (req, res, next) => {
        const idrestaurante = req.params.idrestaurante;
        const idplatillo = req.params.idplatillo;
        RestaurantePlatilloHorario.findById( idrestaurante, idplatillo, (error, data) => {
            return RestaurantePlatilloHorario.response(res, error, data);
        });
    })
    .post('/', (req, res, next) => {
        const restaurantePlatilloHorario = {
            res_has_pla_restaurante_idrestaurante: req.body.res_has_pla_restaurante_idrestaurante,
            res_has_pla_platillo_idplatillo: req.body.res_has_pla_platillo_idplatillo,
            horario_idhorario: req.body.horario_idhorario
        }
        console.log(restaurantePlatilloHorario);
        RestaurantePlatilloHorario.insert( restaurantePlatilloHorario, (error, data) => {
            return RestaurantePlatilloHorario.response(res, error, data);
        });
    })
    .delete('/:idrestaurante/:idplatillo/:idhorario', (req, res, next) => {
        const idrestaurante = req.params.idrestaurante;
        const idplatillo = req.params.idplatillo;
        const idhorario = req.params.idhorario;
        RestaurantePlatilloHorario.remove( idrestaurante, idplatillo, idhorario, (error, data) => {
            return RestaurantePlatilloHorario.response(res, error, data);
        });
    })
    

module.exports = router;