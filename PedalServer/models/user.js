var mongoose = require('mongoose');
var bcrypt = require('bcrypt');

var Schema = mongoose.Schema;

var userSchema = new Schema({
	email: {
		type: String,
		required: true,
		unique: true,
		index: true
	},
	password: {
		type: String,
		required: true
	},
	name: {
		type: String, 
		required: true
	},
	pedals: [Schema.ObjectId],
	tunes: [Schema.ObjectId]
});

userSchema.pre('save', function(next) {

	if (this.isNew) {
		var user = this;

		bcrypt.hash(user.password, 10, function(hashError, hash) {
			if (hashError) {
				return next(hashError);
			}

			user.password = hash;
			next();
		});
	} else 
		next();
});

var User = mongoose.model('User', userSchema);

module.exports = User;