var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var pedalSchema = new Schema({
	owner: {
		type: Schema.ObjectId,
		required: true
	},
	name: { 
		type: String, 
		required: true
	},
	knobs: [Schema.ObjectId]
});

module.exports = pedalSchema;