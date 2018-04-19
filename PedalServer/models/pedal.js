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

pedalSchema.statics.findWithIds = function(ids, callback) {
	return this.find({ _id: {$in: ids} }, callback);
};

pedalSchema.statics.findWithId = function(id, callback) {
	return this.findById(id, callback);
};

var Pedal = mongoose.model('Pedal', pedalSchema);

module.exports = Pedal;