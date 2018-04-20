var mongoose = require('mongoose');
var express = require('express');
var router = express.Router();

var User = require('../models/user');

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
				return res.status(403).json({ errors: { msg: 'The email is already registered in the database.' }});
			else {
				User.create({
					email: requestParams.email,
					password: requestParams.password,
					name: requestParams.name
				}).then((user) => {
					return res.sendStatus(200);
				}).catch((createError) => {
					return res.status(500).json({ errors: { msg: createError.message }});
				});
			}
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.get('/', (req, res, next) => {

	if (!req.session.userId)
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	User.findOne({ _id: req.session.userId }, function(findError, user) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!user)
			return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
		else {

			let publicUser = new User({
				_id: user._id,
				name: user.name,
				pedals: user.pedals,
				tunes: user.tunes
			});

			return res.status(200).send(publicUser);
		} 
	});
		
});


router.put('/name', [

	check('name')
		.exists().withMessage('The user name was not informed.')
		.isString().withMessage('The password must be a string.')

],(req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	try {

		validationResult(req).throw();

		User.findOne({ _id: req.session.userId}, function(findError, user) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (!user)
				return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
			else {

				user.name = req.body.name;
				user.save(function(saveError, updatedUser) {

					if (saveError)
						return res.status(500).json({ errors: { msg: saveError.message }});
					else
						return res.sendStatus(200);
				});
			}
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.put('/pedal/:id', (req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'This pedal not exist in the database.' }});
		else {

			User.findOne({ _id: req.session.userId}, function(findUserError, user) {

				if (findUserError)
					return res.status(500).json({ errors: { msg: findUserError.message }});
				else if (!user)
					return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
				else {

					var userHasPedal = false;

					for (i = 0; i < user.pedals.length; i++) {
						if (user.pedals[i].equals(pedal._id)) {
							userHasPedal = true;
							break;
						}
					}

					if (userHasPedal)
						return res.status(401).json({ errors: { msg: 'This pedal is already linked to the user.' }});
					else {

						user.update({ 'pedals': { $push: pedal._id }}, function(updateError, user) {

							if (updateError)
								return res.status(500).json({ errors: { msg: updateError.message }});
							else
								return res.sendStatus(200);
						});
					}

				}
			});
		}
	});
});


router.delete('/pedal/:id', (req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'This pedal not exist in the database.' }});
		else {

			User.findOne({ _id: req.session.userId}, function(findUserError, user) {

				if (findUserError)
					return res.status(500).json({ errors: { msg: findUserError.message }});
				else if (!user)
					return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
				else {

					var userHasPedal = false;

					for (i = 0; i < user.pedals.length; i++) {
						if (user.pedals[i].equals(pedal._id)) {
							userHasPedal = true;
							break;
						}
					}

					if (!userHasPedal)
						return res.status(401).json({ errors: { msg: 'This pedal is not linked to the user.' }});
					else {

						user.update({ 'pedals': { $pull: pedal._id }}, function(updateError, user) {

							if (updateError)
								return res.status(500).json({ errors: { msg: updateError.message }});
							else
								return res.sendStatus(200);
						});
					}

				}
			});
		}
	});
});

module.exports = router;