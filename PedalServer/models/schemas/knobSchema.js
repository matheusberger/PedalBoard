var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var knobSchema = new Schema({
	name: {
		type: String,
		required: true
	}
});

module.exports = knobSchema;