const router = require('express').Router();
const Oferta = require('../models/oferta');
const multer  = require('multer');
const upload = multer({ dest: './uploads/' }).any();

router
    .get('/', (req, res, next) => {
        Oferta.all( (error, data) => {
            return Oferta.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        Oferta.count( (error, data) => {
            return Oferta.response(res, error, data);
        });
    })
    .get('/exist/:id', (req, res, next) => {
        Oferta.exist( req.params.id, (error, data) => {
            return Oferta.response(res, error, data);
        });
    })
    .get('/findByIdRestAndPlat/:restauranteId/:platilloId', (req, res, next) => {
        const restauranteId = req.params.restauranteId;
        const platilloId = req.params.platilloId;
        Oferta.findByRestAndPlatId( restauranteId, platilloId, (error, data) => {
            return Oferta.response(res, error, data);
        });
    })
    .get('/:id', (req, res, next) => {
        const ofertaId = req.params.id;
        Oferta.findById( ofertaId, (error, data) => {
            return Oferta.response(res, error, data);
        });
    })
    .delete('/:id', (req, res, next) => {
        const ofertaId = req.params.id;
        Oferta.remove( ofertaId, (error, data) => {
            return Oferta.response(res, error, data);
        });
    })
    .delete('/:restauranteId/:platilloId', (req, res, next) => {
        const restauranteId = req.params.restauranteId;
        const platilloId = req.params.platilloId;
        Oferta.removeByRestAndPlatId( restauranteId, platilloId, (error, data) => {
            return Oferta.response(res, error, data);
        });
    })
    .patch('/', (req, res, next) => {
        const oferta = {
            idoferta: req.body.idoferta,
            nombre: req.body.nombre,
            descripcion: req.body.descripcion,
            tipo: req.body.tipo,
            fecha_ini: req.body.fecha_ini,
            fecha_fin: req.body.fecha_fin,
            precio: req.body.precio,
            res_has_pla_restaurante_idrestaurante: req.body.res_has_pla_restaurante_idrestaurante,
            res_has_pla_platillo_idplatillo: req.body.res_has_pla_platillo_idplatillo,
        };
        Oferta.update( oferta, (error, data) => {
            return Oferta.response(res, error, data);
        })
    })
    .post('/', (req, res, next) => {
        const oferta = {
            idoferta: null,
            nombre: req.body.nombre,
            descripcion: req.body.descripcion,
            tipo: req.body.tipo,
            fecha_ini: req.body.fecha_ini,
            fecha_fin: req.body.fecha_fin,
            precio: req.body.precio,
            res_has_pla_restaurante_idrestaurante: req.body.res_has_pla_restaurante_idrestaurante,
            res_has_pla_platillo_idplatillo: req.body.res_has_pla_platillo_idplatillo,
        };
        console.log(oferta);
        Oferta.insert( oferta, (error, data) => {
            return Oferta.response(res, error, data);
        });
    })
    .post('/image', (req, res) => {
        upload(req, res, function (err) {
            if (err) {
                // Handle error
                return res.end(err.toString());
            }
            // Everything went fine
            res.end('File is uploaded');
        });
    })

module.exports = router;