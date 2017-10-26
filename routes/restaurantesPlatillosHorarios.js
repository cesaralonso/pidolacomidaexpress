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
        const res_has_pla_restaurante_idrestaurante = req.params.idrestaurante;
        const res_has_pla_platillo_idplatillo = req.params.idplatillo;
        RestaurantePlatilloHorario.findById( res_has_pla_restaurante_idrestaurante, res_has_pla_platillo_idplatillo, (error, data) => {
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
    

module.exports = router;