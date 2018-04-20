var mongoose = require('mongoose');

var tuneSchema = require('./schemas/tuneSchema');

var Tune = mongoose.model('Tune', tuneSchema);

module.exports = Tune;