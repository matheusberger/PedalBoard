var express = require('express');
var morgan = require('morgan');
var bodyParser = require('body-parser');
var session = require('express-session');
var MongoStore = require('connect-mongo')(session);

var db = require('./db');

var app = express();

app.use(session({
	secret: 'PedalBoard',
	resave: true,
	saveUninitialized: false,
	store: new MongoStore({
		mongooseConnection: db
	}),
	maxAge: 24 * 60 * 60 * 1000 // 24 hours
}));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

//app.use(morgan('dev'));

var AuthController = require('./controllers/auth');
var UserController = require('./controllers/user');
var PedalController = require('./controllers/pedal');
var KnobController = require('./controllers/knob');
var TuneController = require('./controllers/tune');

app.use('/auth', AuthController);
app.use('/user', UserController);
app.use('/pedal', PedalController);
app.use('/knob', KnobController);
app.use('/tune', TuneController);

module.exports = app;