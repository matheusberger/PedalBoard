var mongoose = require('mongoose');

var pedalSchema = require('./schemas/pedalSchema');

var Pedal = mongoose.model('Pedal', pedalSchema);

module.exports = Pedal;