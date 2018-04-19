var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var tuneSchema = new Schema({
	name: String,
	artist: String,
	pedals: [Schema.Type.ObjectId]
});

var Tune = mongoose.model('Tune', tuneSchema);

module.exports = Tune;