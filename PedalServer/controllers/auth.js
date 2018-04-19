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
		
], (req, res, next) => {
	
	try {
		validationResult(req).throw();

		User.authenticate(req.body.email, req.body.password, function(authError, user) {
			if (authError) {
				return res.status(403).json({ errors: { msg: authError.message }});
			}

			req.session.userId = user._id;
			return res.sendStatus(200);
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});

router.delete('/', function (req, res) {
	if (req.session.userId) {
		req.session.destroy(function(destroyError) {
			if (destroyError)
				return res.status(500).json({ errors: { msg: 'There was a problem when logging-out the user.' }});
			else {
				req.session = null;
				return res.sendStatus(200);
			}
		});
	} else
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});
});

module.exports = router;