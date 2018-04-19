var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var pedalSchema = new Schema({
	name: { 
		type: String, 
		required: true
	},
	knobs: [{
		name: {
			type: String, 
			required: true
		},
		value: { 
			type: Number, 
			default: 0, 
			min: 0, 
			max: 100
		}
	}]
});

var Pedal = mongoose.model('Pedal', pedalSchema);

module.exports = Pedal;