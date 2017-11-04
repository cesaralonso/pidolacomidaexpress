const express = require('express');
const connection = require('./config/db-connection');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const passport = require('passport');
const multer = require('multer');
const dir = './uploads/';
const fs = require('fs');

//Route importation.
const rol = require('./routes/roles');
const user = require('./routes/users');
const pago = require('./routes/pagos');
const combo = require('./routes/combos');
const orden = require('./routes/ordenes');
const oferta = require('./routes/ofertas');
const estado = require('./routes/estados');
const ciudad = require('./routes/ciudades');
const horario = require('./routes/horarios');
const factura = require('./routes/facturas');
const telefono = require('./routes/telefonos');
const platillo = require('./routes/platillos');
const direccion = require('./routes/direcciones');
const tipoComida = require('./routes/tipoComidas');
const enfermedad = require('./routes/enfermedades');
const ingrediente = require('./routes/ingredientes');
const restaurante = require('./routes/restaurantes');
const platilloOrdenado = require('./routes/platillosOrdenados');
const restaurantePlatillo = require('./routes/restaurantesPlatillos');
const platilloHorario = require('./routes/platillosHorarios');
const platilloIngrediente = require('./routes/platillosIngredientes');

// Express Instance
const app = express();

// Middleware
app.use(cors({
    origin: true,
    credentials: true,
    allowedHeaders: ['Authorization', 'Origin', 'X-Requested-With', 'Content-Type', 'Accept', 'X-CSRF-TOKEN', 'XMLHttpRequest'],
    methods: ['GET','POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS']
}));
app.use(multer({
    dest: dir,
    rename: (fieldname, filename) => {
      return filename + 'anuma';
    },
    onFileUploadStart: function (file) {
      console.log(file.originalname + ' is starting ...');
    },
    onFileUploadComplete: function (file) {
      console.log(file.fieldname + ' uploaded to  ' + file.path);
    }
}).any());
app.use(morgan('dev'));
app.use(bodyParser.json());

// Initialize passport
app.use(passport.initialize());

// Call passport Strategy
require('./config/passport')(passport);

// Warehouses
app.use('/rol', rol);
app.use('/user', user);
app.use('/pago', pago);
app.use('/orden', orden);
app.use('/combo', combo);
app.use('/oferta', oferta);
app.use('/estado', estado);
app.use('/ciudad', ciudad);
app.use('/horario', horario);
app.use('/factura', factura);
app.use('/telefono', telefono);
app.use('/platillo', platillo);
app.use('/direccion', direccion);
app.use('/enfermedad', enfermedad);
app.use('/tipoComida', tipoComida);
app.use('/ingrediente', ingrediente);
app.use('/restaurante', restaurante);
app.use('/platilloOrdenado', platilloOrdenado);
app.use('/restaurantePlatillo', restaurantePlatillo);
app.use('/platilloHorario', platilloHorario);
app.use('/platilloIngrediente', platilloIngrediente);

// Set port
app.listen(3000);
