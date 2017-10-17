const express = require('express');
const connection = require('./config/db-connection');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');


//Route importation.
const platillo = require('./routes/platillos');

// Express Instance
const app = express();

// Middleware
app.use(cors());
app.use(morgan('dev'));
app.use(bodyParser.json());

// Route use
app.use('/platillo', platillo);

// Set port
app.listen(3000);



