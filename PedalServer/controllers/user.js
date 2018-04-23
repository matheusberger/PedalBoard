var mongoose = require('mongoose');
var express = require('express');
var router = express.Router();

var User = require('../models/user');
var Pedal = require('../models/pedal');
var Tune = require('../models/tune');

const { check, validationResult } = require('express-validator/check');
const { matchedData, sanitize } = require('express-validator/filter');

router.post('/', [

	check('email')
		.exists().withMessage('The email was not informed.')
		.isString().withMessage('The email must be a string.')
		.isEmail().withMessage('The email is not valid.')
		.trim()
		.normalizeEmail(),

	check('password')
		.exists().withMessage('The password was not informed.')
		.isString().withMessage('The password must be a string.')
		.isLength({ 
			min: 6
		}).withMessage('The password must be at least 6 chars long.'),

	check('name')
		.exists().withMessage('The user name was not informed.')
		.isString().withMessage('The password must be a string.')

], (req, res, next) => {

	try {
		
		validationResult(req).throw();

		const requestParams = matchedData(req);

		User.findOne({ email: requestParams.email }, function(findError, user) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (user)
				return res.status(403).json({ errors: { msg: 'Email already registered.' }});

			User.create({
				email: requestParams.email,
				password: requestParams.password,
				name: requestParams.name
			}).then((user) => {
				return res.sendStatus(200);
			}).catch((createError) => {
				return res.status(500).json({ errors: { msg: createError.message }});
			});
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.get('/:id', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);
	let requestUserId = mongoose.Types.ObjectId(req.params.id);

	if (!currentAuthUserId)
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	User.findOne({ _id: requestUserId }, function(findError, user) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!user)
			return res.status(404).json({ errors: { msg: 'User not found.' }});

		let publicUser = new User({
			_id: user._id,
			email: user.email,
			name: user.name,
			pedals: user.pedals,
			tunes: user.tunes
		});

		return res.status(200).send(publicUser); 
	});
		
});


router.patch('/:id/name', [

	check('name')
		.exists().withMessage('The name was not informed.')
		.isString().withMessage('The name must be a string.')

],(req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);
	let requestUserId = mongoose.Types.ObjectId(req.params.id);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});
	else if (!currentAuthUserId.equals(requestUserId))
		return res.status(409).json({ errors: { msg: 'User not allowed.' }});

	try {

		validationResult(req).throw();

		User.findOne({ _id: currentAuthUserId }, function(findError, user) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (!user)
				return res.status(500).json({ errors: { msg: 'User not found.' }});

			user.name = req.body.name;

			user.save(function(saveError, updatedUser) {
				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message }});
		
				return res.sendStatus(200);
			});
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.put('/:id/pedal/:pid', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);
	let requestUserId = mongoose.Types.ObjectId(req.params.id);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});
	else if (!currentAuthUserId.equals(requestUserId))
		return res.status(409).json({ errors: { msg: 'User not allowed.' }});

	Pedal.findOne({ _id: req.params.pid }, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'Pedal not found.' }});
		else if (!pedal.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		User.findOne({ _id: req.session.userId}, function(findUserError, user) {

			if (findUserError)
				return res.status(500).json({ errors: { msg: findUserError.message }});
			else if (!user)
				return res.status(500).json({ errors: { msg: 'User not found.' }});

			let userHasPedal = false;

			for (i = 0; i < user.pedals.length; i++) {
				if (user.pedals[i].equals(pedal._id)) {
					userHasPedal = true;
					break;
				}
			}

			if (userHasPedal)
				return res.status(403).json({ errors: { msg: 'This pedal is already linked to the user.' }});

			user.pedals.push({ _id: pedal._id });

			user.save(function(saveError,) {
				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message }});

				return res.sendStatus(200);
			});
		});
	});
});


router.delete('/:id/pedal/:pid', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);
	let requestUserId = mongoose.Types.ObjectId(req.params.id);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});
	else if (!currentAuthUserId.equals(requestUserId))
		return res.status(409).json({ errors: { msg: 'User not allowed.' }});

	Pedal.findOne({ _id: req.params.pid}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'Pedal not found.' }});
		else if (!pedal.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		User.findOne({ _id: req.session.userId}, function(findUserError, user) {

			if (findUserError)
				return res.status(500).json({ errors: { msg: findUserError.message }});
			else if (!user)
				return res.status(500).json({ errors: { msg: 'User not found.' }});

			let userHasPedal = false;

			for (i = 0; i < user.pedals.length; i++) {
				if (user.pedals[i].equals(pedal._id)) {
					userHasPedal = true;
					break;
				}
			}

			if (!userHasPedal)
				return res.status(403).json({ errors: { msg: 'This pedal is not linked to the user.' }});

			user.pedals.pull({ _id:  pedal._id});

			user.save(function(saveError) {

				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message }});

				return res.sendStatus(200);
			});
		});
	});
});


router.put('/:id/tune/:tid', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);
	let requestUserId = mongoose.Types.ObjectId(req.params.id);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});
	else if (!currentAuthUserId.equals(requestUserId))
		return res.status(409).json({ errors: { msg: 'User not allowed.' }});

	Tune.findOne({ _id: req.params.tid }, function(findError, tune) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!tune)
			return res.status(404).json({ errors: { msg: 'Tune not found.' }});
		else if (!tune.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		User.findOne({ _id: req.session.userId}, function(findUserError, user) {

			if (findUserError)
				return res.status(500).json({ errors: { msg: findUserError.message }});
			else if (!user)
				return res.status(500).json({ errors: { msg: 'User not found.' }});

			let userHasTune = false;

			for (i = 0; i < user.tunes.length; i++) {
				if (user.tunes[i].equals(tune._id)) {
					userHasTune = true;
					break;
				}
			}

			if (userHasTune)
				return res.status(403).json({ errors: { msg: 'This tune is already linked to the user.' }});

			user.tunes.push({ _id: tune._id });

			user.save(function(saveError,) {
				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message }});

				return res.sendStatus(200);
			});
		});
	});
});


router.delete('/:id/tune/:tid', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);
	let requestUserId = mongoose.Types.ObjectId(req.params.id);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});
	else if (!currentAuthUserId.equals(requestUserId))
		return res.status(409).json({ errors: { msg: 'User not allowed.' }});

	Tune.findOne({ _id: req.params.tid}, function(findError, tune) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!tune)
			return res.status(404).json({ errors: { msg: 'Tune not found.' }});
		else if (!tune.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		User.findOne({ _id: req.session.userId}, function(findUserError, user) {

			if (findUserError)
				return res.status(500).json({ errors: { msg: findUserError.message }});
			else if (!user)
				return res.status(500).json({ errors: { msg: 'User not found.' }});

			let userHasTune = false;

			for (i = 0; i < user.tunes.length; i++) {
				if (user.tunes[i].equals(tune._id)) {
					userHasTune = true;
					break;
				}
			}

			if (!userHasTune)
				return res.status(403).json({ errors: { msg: 'This tune is not linked to the user.' }});

			user.tunes.pull({ _id: tune._id});

			user.save(function(saveError) {

				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message }});

				return res.sendStatus(200);
			});
		});
	});
});


module.exports = router;