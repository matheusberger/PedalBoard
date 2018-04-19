var express = require('express');
var bcrypt = require('bcrypt');

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
		
], (req, res, next) => {
	
	try {
		validationResult(req).throw();

		const requestParams = matchedData(req);

		User.findOne({ email: requestParams.email }, function(findError, user) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (!user)
				return res.status(404).json({ errors: { msg: 'No user with the provided email.' }});

			bcrypt.compare(requestParams.password, user.password, function(compareError, result) {
				if (compareError)
					return res.status(500).json({ errors: { msg: compareError.message }});
				else if (result == false)
					return res.status(403).json({ errors: { msg: 'The provided password is incorrect.' }});
				else {
					req.session.userId = user._id;
					return res.sendStatus(200);
				}
			});

		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});

router.delete('/', (req, res, next) => {

	if (!req.session.userId)
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	req.session.destroy(function(destroyError) {
		if (destroyError)
			return res.status(500).json({ errors: { msg: 'There was a problem when logging-out the user.' }});
		else {
			req.session = null;
			return res.sendStatus(200);
		}
	});
		
});

module.exports = router;