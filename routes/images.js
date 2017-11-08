const router = require('express').Router();
const Image = require('../models/image');

router
    .get('/', (req, res, next) => {
        Image.all( (error, data) => {
            return Image.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        Image.count( (error, data) => {
            return Image.response(res, error, data);
        });
    })
    .get('/exist/:id', (req, res, next) => {
        Image.exist( req.params.id, (error, data) => {
            return Image.response(res, error, data);
        });
    })
    .get('/:id', (req, res, next) => {
        const imageId = req.params.id;
        Image.findById( imageId, (error, data) => {
            return Image.response(res, error, data);
        });
    })
    .delete('/:id', (req, res, next) => {
        const imageId = req.params.id;
        Image.remove( imageId, (error, data) => {
            return Image.response(res, error, data);
        });
    })
    .patch('/', (req, res, next) => {
        const image = {
            idimage: req.body.idimage,
            descripcion: req.body.descripcion
        };
        Image.update( image, (error, data) => {
            return Image.response(res, error, data);
        })
    })
    .post('/', (req, res, next) => {
        const image = {
            idimage: null,
            descripcion: req.body.descripcion
        }
        console.log(image);
        Image.insert( image, (error, data) => {
            return Image.response(res, error, data);
        });
    })
    

module.exports = router;