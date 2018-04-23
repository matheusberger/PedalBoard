var express = require('express');
var bcrypt = require('bcrypt');

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
		
], (req, res, next) => {
	
	if (req.session.userId)
		return res.status(401).json({ errors: { msg: 'User already logged.' }});

	try {
		validationResult(req).throw();

		const requestParams = matchedData(req);

		User.findOne({ email: requestParams.email }, function(findError, user) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (!user)
				return res.status(404).json({ errors: { msg: 'User not found.' }});

			bcrypt.compare(requestParams.password, user.password, function(compareError, result) {
				if (compareError)
					return res.status(500).json({ errors: { msg: compareError.message }});
				else if (result == false)
					return res.status(403).json({ errors: { msg: 'The password is incorrect.' }});

				req.session.userId = user._id;
				return res.status(200).json(user._id);
			});

		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});

router.delete('/', (req, res, next) => {

	if (!req.session.userId)
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	req.session.destroy(function(destroyError) {
		if (destroyError)
			return res.status(500).json({ errors: { msg: 'There was a problem when logging-out the user.' }});

		req.session = null;
		return res.sendStatus(200);
	});
		
});

module.exports = router;