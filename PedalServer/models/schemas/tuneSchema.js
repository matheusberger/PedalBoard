var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var pedalSetupSchema = require('./pedalSetupSchema');

var tuneSchema = new Schema({
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

exports.module = tuneSchema;