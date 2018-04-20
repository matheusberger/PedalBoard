var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var pedalSchema = new Schema({
	name: { 
		type: String, 
		required: true
	},
	knobs: [Schema.ObjectId]
});

module.exports = pedalSchema;