var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var pedalSetupSchema = require('./pedalSetupSchema');

var tuneSchema = new Schema({
	owner: {
		type: Schema.ObjectId,
		required: true
	},
	name: { 
		type: String,
		required: true
	},
	artist: {
		type: String,
		required: true
	},
	pedalSetups: [pedalSetupSchema]
});

module.exports = tuneSchema;