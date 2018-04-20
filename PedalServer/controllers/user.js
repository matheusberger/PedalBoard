var express = require('express');
var router = express.Router();

var User = require('../models/user');

const { check, validationResult } = require('express-validator/check');
const { matchedData, sanitize } = require('express-validator/filter');

router.post('/', [

	check('email')
		.exists().withMessage('The user email was not informed.')
		.isEmail().withMessage('The email is not valid.')
		.trim()
		.normalizeEmail(),

	check('password')
		.exists().withMessage('The user password was not informed.')
		.isLength({ 
			min: 6
		}).withMessage('The password must be at least 6 chars long.'),

	check('name', 'The user name was not informed.').exists()

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
					req.session.userId = user._id;
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


router.put('/', [

	check('name', 'The new user name was not informed.').exists()

], (req, res, next) => {

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

					let publicUser = new User({
						_id: updatedUser._id,
						name: updatedUser.name,
						pedals: updatedUser.pedals,
						tunes: updatedUser.tunes
					});

					return res.status(200).send(publicUser);
				});
			}
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});

module.exports = router;