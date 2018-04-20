var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var pedalSetupSchema = new Schema({
	pedal: Schema.ObjectId,
	knobsValue: [{
		knob: Schema.ObjectId,
		value: {
			type: Number,
			default: 0,
			min: 0,
			max: 100,
		}
	}]
});

module.exports = pedalSetupSchema;