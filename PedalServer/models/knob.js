var mongoose = require('mongoose');

var knobSchema = require('./schemas/knobSchema');

var Knob = mongoose.model('Knob', knobSchema);

module.exports = Knob;