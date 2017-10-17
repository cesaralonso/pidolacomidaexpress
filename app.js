const express = require('express');
const connection = require('./config/db-connection');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const passport = require('passport');

//Route importation.
const rol = require('./routes/roles');
const user = require('./routes/users');
const ciudad = require('./routes/ciudades');
const telefono = require('./routes/telefonos');
const platillo = require('./routes/platillos');
const restaurante = require('./routes/restaurantes');

// Express Instance
const app = express();

// Middleware
app.use(cors());
app.use(morgan('dev'));
app.use(bodyParser.json());

// Initialize passport
app.use(passport.initialize());

// Call passport Strategy
require('./config/passport')(passport);

// Warehouses
app.use('/rol', rol);
app.use('/user', user);
app.use('/ciudad', ciudad);
app.use('/telefono', telefono);
app.use('/platillo', platillo);
app.use('/restaurante', restaurante);

// Set port
app.listen(3000);



