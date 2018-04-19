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

tuneSchema.methods.update = function(newName, newArtist, callback) {
	this.name = newName;
	this.artist = newArtist;
	return this.save(callback);
};

tuneSchema.statics.findWithIds = function(ids, callback) {
	return this.find({ _id: {$in: ids} }, callback);
};

tuneSchema.statics.findWithId = function(id, callback) {
	return this.findById(id, callback);
};

tuneSchema.statics.findUsingPedalId = function(id, callback) {
	return this.find({ pedals: id}, callback);
}

var Tune = mongoose.model('Tune', tuneSchema);

module.exports = Tune;