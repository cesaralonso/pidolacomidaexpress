const router = require('express').Router();
const User = require('../models/user');

router
    .get('/', (req, res, next) => {
        User.all( (error, data) => {
            return User.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        User.count( (error, data) => {
            return User.response(res, error, data);
        });
    })
    .get('/exist/:id', (req, res, next) => {
        User.exist( req.params.id, (error, data) => {
            return User.response(res, error, data);
        });
    })
    .get('/:id', (req, res, next) => {
        const userId = req.params.id;
        User.findById( userId, (error, data) => {
            return User.response(res, error, data);
        });
    })
    .delete('/:id', (req, res, next) => {
        const userId = req.params.id;
        User.remove( userId, (error, data) => {
            return User.response(res, error, data);
        });
    })
    .patch('/', (req, res, next) => {
        const user = {
            iduser: req.body.iduser,
            apellidos: req.body.apellidos,
            email: req.body.email,
            password: req.body.password,
            telefono_idtelefono: req.body.telefono_idtelefono,
            rol_idrol: req.body.rol_idrol
        };
        User.update( user, (error, data) => {
            return User.response(res, error, data);
        })
    })
    .post('/', (req, res, next) => {
        const user = {
            iduser: null,
            nombres: req.body.nombres,
            apellidos: req.body.apellidos,
            email: req.body.email,
            password: req.body.password,
            telefono_idtelefono: req.body.telefono_idtelefono,
            rol_idrol: req.body.rol_idrol
        }
        console.log(user);
        User.insert( user, (error, data) => {
            return User.response(res, error, data);
        });
    })
    

module.exports = router;