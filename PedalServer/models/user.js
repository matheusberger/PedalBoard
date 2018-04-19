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

userSchema.methods.updateName = function(newName, callback) {
	this.name = newName;
	return this.save(callback);
};

userSchema.statics.removeTune = function(id, tuneId) {
 	return this.update({ _id: id }, { '$pull': { 'tunes': tuneId }});
}

userSchema.statics.removePedal = function(id, pedalId) {
 	return this.update({ _id: id }, { '$pull': { 'pedals': pedalId }});
}

userSchema.statics.addPedal = function(id, pedalId, callback) {
	User.findWithId(id).then(user => {
		user.pedals.push(pedalId);

		user.save().then(() => {
			return callback();
		}).catch(() => {
			let errorUpdate = new Error('There was a problem while updating the user.');
			return callback(errorUpdate);
		});

	}).catch(() => {
		let errorFind = new Error('There was a problem while getting the user from the database.');
		return callback(errorFind);
	})
}

userSchema.statics.addTune = function(id, tuneId, callback) {
	User.findWithId(id).then(user => {
		user.tunes.push(tuneId);

		user.save().then(() => {
			return callback();
		}).catch(() => {
			let errorUpdate = new Error('There was a problem while updating the user.');
			return callback(errorUpdate);
		});

	}).catch(() => {
		let errorFind = new Error('There was a problem while getting the user from the database.');
		return callback(errorFind);
	});
};

userSchema.statics.findWithEmail = function(email, callback) {
	return this.find({ 
		email: new RegExp(email, 'i') 
	}, callback);
};

userSchema.statics.findWithId = function(id, callback) {
	return this.findById(id, callback);
};

userSchema.statics.authenticate = function(email, password, callback) {
	User.findOne({ email: email }, function(findError, user) {
		if (findError) 
			return callback(findError, null);
		else if (!user) {
			let error = new Error('No user found with the provided email.');
			return callback(error, null);
		}

		bcrypt.compare(password, user.password, function(error, result) {
			if (error)
				return callback(error, null);
			else if (result == false) {
				let error = new Error('The password is incorrect.');
				return callback(error, null);
			} else
				return callback(null, user);
		});
	});
};

var User = mongoose.model('User', userSchema);

module.exports = User;