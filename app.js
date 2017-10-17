const express = require('express');
const connection = require('./config/db-connection');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
var passport = require('passport');

//Route importation.
const platillo = require('./routes/platillos');
const ciudad = require('./routes/ciudades');
const user = require('./routes/users');

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


// Routes
app.use('/platillo', platillo);
app.use('/ciudad', ciudad);
app.use('/user', user);

// Set port
app.listen(3000);



