var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/pedalboard');

module.exports = mongoose.connection;