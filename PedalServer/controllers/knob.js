var mongoose = require('mongoose');
var express = require('express');
var router = express.Router();

var Pedal = require('../models/pedal');
var Knob = require('../models/knob');

const { check, validationResult } = require('express-validator/check');

router.post('/', [

	check('name')
		.exists().withMessage('The knob name was not informed.')
		.isString().withMessage('The knob name must be a string'),

], (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	try {

		validationResult(req).throw();

		Knob.create({
			owner: currentAuthUserId,
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

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
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


router.patch('/:id/name', [

	check('name')
		.exists().withMessage('The name was not informed.')
		.isString().withMessage('The name must be a string.')

],(req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	try {

		validationResult(req).throw();

		Knob.findOne({ _id: req.params.id }, function(findError, knob) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (!knob)
				return res.status(404).json({ errors: { msg: 'Knob not found.' }});
			else if (!knob.owner.equals(currentAuthUserId))
				return res.status(409).json({ errors: { msg: 'User not allowed.' }});

			knob.name = req.body.name;

			knob.save(function(saveError, updatedKnob) {
				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message }});
		
				return res.sendStatus(200);
			});
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.delete('/:id', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	Knob.findOne({ _id: req.params.id }, function(findError, knob) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!knob)
			return res.status(404).json({ errors: { msg: 'Knob not found.' }});
		else if (!knob.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		Pedal.findOne({ 'knobs': { $in: [knob._id] }}, function(findUserError, user) {

			if (findUserError)	
				return res.status(500).json({ errors: { msg: findUserError.message }});
			else if (user)
				return res.status(403).json({ errors: { msg: 'This knob is linked to a pedal.' }});


			Knob.remove({ _id: knob._id}, function(removeError) {
				if (removeError)
					return res.status(500).json({ errors: { msg: removeError.message }});
			
				return res.sendStatus(200);
			});
		});
	});

});

module.exports = router;