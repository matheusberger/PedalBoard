var mongoose = require('mongoose');
var express = require('express');
var router = express.Router();

var Knob = require('../models/knob');

const { check, validationResult } = require('express-validator/check');

router.post('/', [

	check('name')
		.exists().withMessage('The knob name was not informed.')
		.isString().withMessage('The knob name must be a string'),

], (req, res, next) => {

	if (!req.session.userId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	try {

		validationResult(req).throw();

		Knob.create({
			name: req.body.name
		}).then((knob) => {
			return res.status(200).send(knob);
		}).catch((createError) => {
			return res.status(500).json({ errors: { msg: createError.message }}); 
		});		

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.get('/:id', (req, res, next) => {

	if (!req.session.userId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	try {

		validationResult(req).throw();

		Knob.findOne({ _id: req.params.id }, function(findError, knob) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }}); 
			else if (!knob)
				return res.status(404).json({ errors: { msg: 'Knob not found.' }});

			return res.status(200).send(knob);
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


module.exports = router;