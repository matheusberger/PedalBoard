var mongoose = require('mongoose');

var pedalSetupSchema = require('./schemas/pedalSetupSchema');

var PedalSetup = mongoose.model('PedalSetup', pedalSetupSchema);

module.exports = PedalSetup;