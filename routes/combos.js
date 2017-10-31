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
    .get('/getByParam/:column/:param', (req, res, next) => {
        const column = req.params.column;
        const param = req.params.param;
        Combo.findByParam( column, param, (error, data) => {
            return Combo.response(res, error, data);
        });
    })
    .get('/idWithPlatillos/:idcombo', (req, res, next) => {
        const comboId = req.params.idcombo;
        Combo.findByIdWithPlatillos( comboId, (error, data) => {
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
                nombre: req.body.nombre,
                descripcion: req.body.descripcion,
                precio: req.body.precio,
                fecha_ini: req.body.fechaIni,
                fecha_fin: req.body.fechaFin,
                created_by: user.iduser,
            };
            // Contains an object array with all platillos and its quantity
            const platillos = req.body.platillos;

            const restauranteId = req.body.restaurante_idrestaurante;
            console.log(combo);
            Combo.insert( combo, platillos, restauranteId, (error, data) => {
                console.log(error);
                return Combo.response(res, error, data);
            });
        })(req, res, next);
    })

module.exports = router;