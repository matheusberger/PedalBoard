var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var tuneSchema = new Schema({
	name: { 
		type: String,
		required: true
	},
	artist: {
		type: String,
		required: true
	},
	pedals: [Schema.ObjectId]
});

var Tune = mongoose.model('Tune', tuneSchema);

module.exports = Tune;