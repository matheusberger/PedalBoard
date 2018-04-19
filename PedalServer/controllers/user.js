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

		const reqFields = matchedData(req);
		
		User.findWithEmail(reqFields.email).then(users => {
			if (users.length > 0) {
				return res.status(403).json({ errors: { msg: 'The email is already registered in the database.' }});
			}

			User.create({
				email: reqFields.email,
				password: reqFields.password,
				name: reqFields.name
			}).then(user => {
				req.session.userId = user._id;
				return res.sendStatus(200);
			}).catch(() => {
				return res.status(500).json({ errors: { msg: 'There was a problem adding the user to the database.' }});
			});
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.get('/', function (req, res) {

	if (req.session.userId) {

		User.findWithId(req.session.userId).then(user => {

			let userPublicInformations = new User({
				_id: user._id,
				name: user.name
			});

			return res.status(200).send(userPublicInformations);
		}).catch(() => {
			return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
		});

	} else
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});
});


router.put('/', [

	check('name', 'The new user name was not informed.').exists()

], (req, res, next) => {

	try {
		validationResult(req).throw();

	if (req.session.userId) {

		User.findWithId(req.session.userId).then(user => {

			user.updateName(req.body.name).then((updatedUser) => {

				let userPublicInformations = new User({
					_id: updatedUser._id,
					name: updatedUser.name
				});

				return res.status(200).send(userPublicInformations);

			}).catch(() => {
				return res.status(500).json({ errors: { msg: 'There was a problem while updating the user.' }});
			});

		}).catch(() => {
			return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
		});

	} else
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});

module.exports = router;