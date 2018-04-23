var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var knobSchema = new Schema({
	owner: {
		type: Schema.ObjectId,
		required: true
	},
	name: {
		type: String,
		required: true
	}
});

module.exports = knobSchema;