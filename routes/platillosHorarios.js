const router = require('express').Router();
const PlatilloHorario = require('../models/platilloHorario');

router
    .get('/', (req, res, next) => {
        PlatilloHorario.all( (error, data) => {
            return PlatilloHorario.response(res, error, data);
        });
    })
    .get('/count', (req, res, next) => {
        PlatilloHorario.count( (error, data) => {
            return PlatilloHorario.response(res, error, data);
        });
    })
    .get('/getByParam/:column/:columnValue', (req, res, next) => {
        const column = req.params.column;
        const columnValue = req.params.columnValue;
        PlatilloHorario.findByParam( column, columnValue, (error, data) => {
            return PlatilloHorario.response(res, error, data);
        });
    })
    .post('/', (req, res, next) => {
        const platilloHorario = {
            platillo_idplatillo: req.body.platillo_idplatillo,
            hora_ini: req.body.hora_ini,
            hora_fin: req.body.hora_fin,
            semana_idsemana: req.body.semana_idsemana
        }
        console.log(platilloHorario);
        PlatilloHorario.insert( platilloHorario, (error, data) => {
            return PlatilloHorario.response(res, error, data);
        });
    })
    .delete('/:platillo_idplatillo/:hora_ini/:hora_fin/:semana_idsemana', (req, res, next) => {
        const platilloHorarioDelete = {
            platillo_idplatillo: req.params.platillo_idplatillo,
            hora_ini: req.params.hora_ini,
            hora_fin: req.params.hora_fin,
            semana_idsemana: req.params.semana_idsemana
        }
        console.log(platilloHorarioDelete);
        PlatilloHorario.remove( platilloHorarioDelete, (error, data) => {
            console.log(error);
            return PlatilloHorario.response(res, error, data);
        });
    })
    
module.exports = router;