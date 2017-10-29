const router = require('express').Router();
const passport = require('passport');
const Combo = require('../models/combo');

router
    .get('/', (req, res, next) => {
        Combo.all( (error, data) => {
            return Combo.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        Combo.count( (error, data) => {
            return Combo.response(res, error, data);
        });
    })
    .get('/exist/:id', (req, res, next) => {
        Combo.exist( req.params.id, (error, data) => {
            return Combo.response(res, error, data);
        });
    })
    .get('/:id', (req, res, next) => {
        const comboId = req.params.id;
        Combo.findById( comboId, (error, data) => {
            return Combo.response(res, error, data);
        });
    })
    .delete('/:id', (req, res, next) => {
        const comboId = req.params.id;
        Combo.remove( comboId, (error, data) => {
            return Combo.response(res, error, data);
        });
    })
    .patch('/', (req, res, next) => {
        passport.authenticate('jwt', { session: false }, (err, user, info) => {
            
            const combo = {
                idcombo: req.body.idcombo,
                restaurante_idrestaurante: req.body.restaurante_idrestaurante,
                nombre: req.body.nombre,
                descripcion: req.body.descripcion,
                precio: req.body.precio,
                fecha_ini: req.body.fecha_ini,
                fecha_fin: req.body.fecha_fin,
            };            
            Combo.update( combo, (error, data) => {
                return Combo.response(res, error, data);
            })
        })(req, res, next);        
    })
    .post('/', (req, res, next) => {
        passport.authenticate('jwt', { session: false }, (err, user, info) => {
            
            const combo = {
                idcombo: null,
                restaurante_idrestaurante: req.body.restaurante_idrestaurante,
                nombre: req.body.nombre,
                descripcion: req.body.descripcion,
                precio: req.body.precio,
                fecha_ini: req.body.fecha_ini,
                fecha_fin: req.body.fecha_fin,
                created_by: user.iduser,
            };
            const platillos = req.body.platillos;
            
            console.log(combo);
            Combo.insert( combo, platillos, (error, data) => {
                return Combo.response(res, error, data);
            });
        })(req, res, next);
    })

module.exports = router;