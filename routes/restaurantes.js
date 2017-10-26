const router = require('express').Router();
const passport = require('passport');
const Restaurante = require('../models/restaurante');

router
    .get('/', (req, res, next) => {
        Restaurante.all( (error, data) => {
            return Restaurante.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        Restaurante.count( (error, data) => {
            return Restaurante.response(res, error, data);
        });
    })
    .get('/exist/:id', (req, res, next) => {
        Restaurante.exist( req.params.id, (error, data) => {
            return Restaurante.response(res, error, data);
        });
    })
    .get('/getByParam/:column/:param', (req, res, next) => {
        const column = req.params.column;
        const param = req.params.param;
        Restaurante.findByParam( column, param, (error, data) => {
            return Restaurante.response(res, error, data);
        });
    })
    .get('/:id', (req, res, next) => {
        const restauranteId = req.params.id;
        Restaurante.findById( restauranteId, (error, data) => {
            return Restaurante.response(res, error, data);
        });
    })
    .delete('/:id', (req, res, next) => {
        const restauranteId = req.params.id;
        Restaurante.remove( restauranteId, (error, data) => {
            return Restaurante.response(res, error, data);
        });
    })
    .patch('/', (req, res, next) => {
        const restaurante = {
            idrestaurante: req.body.idrestaurante,
            descripcion: req.body.descripcion,
            direccion_iddireccion: req.body.direccion_iddireccion,
            razon: req.body.razon,
            nombre: req.body.nombre,
        }
        Restaurante.update( restaurante, (error, data) => {
            return Restaurante.response(res, error, data);
        })
    })
    .post('/', (req, res, next) => {
        passport.authenticate('jwt', { session: false }, (err, user, info) => {

            const restaurante = {
                idrestaurante: null,
                descripcion: req.body.descripcion,
                direccion_iddireccion: req.body.direccion_iddireccion,
                user_iduser: user.iduser,
                razon: req.body.razon,
                nombre: req.body.nombre,
                created_by: user.iduser
            }
            console.log(restaurante);
            Restaurante.insert( restaurante, (error, data) => {
                return Restaurante.response(res, error, data);
            });
        })(req, res, next);
    
    })
    

module.exports = router;