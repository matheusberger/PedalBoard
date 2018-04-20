var mongoose = require('mongoose');
var express = require('express');
var router = express.Router();

var User = require('../models/user');
var Pedal = require('../models/pedal');
var Tune = require('../models/tune');

const { check, validationResult } = require('express-validator/check');

// Request: create new Pedal
router.post('/', [

	check('name')
		.exists().withMessage('The pedal name was not informed.')
		.isString().withMessage('The pedal name must be a string'),

	check('knobs')
		.exists().withMessage('The pedal must have at least one knob.'),

	check('knobs.*.name')
		.exists().withMessage('The knob name was not informed.')
		.isString().withMessage('The knob name must be a string'),

	check('knobs.*.value')
		.exists().withMessage('The knob value was not informed.')
		.isInt({ min: 0, max: 100 }).withMessage('The knob value must be a int between 0 and 100.')

], (req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	try {

		validationResult(req).throw();

		Pedal.create({
			name: req.body.name,
			knobs: req.body.knobs
		}).then((pedal) => {

			return res.status(200).send(pedal);

		}).catch((createError) => {
			return res.status(500).json({ errors: { msg: createError.message }});
		});			

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});

// Request: get a pedal.
router.get('/:id', (req, res, next) => {

	if (!req.session.userId)
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'The pedal not exist in the database.' }});
		else
			return res.status(200).send(pedal);

	});

});

// Request: remove a pedal.
router.delete('/:id', (req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'This pedal not exist in the database.' }});
		else {

			User.findOne({ 'pedals': { $in: req.params.id }}, function(findUserError, user) {

				if (findUserError)	
					return res.status(500).json({ errors: { msg: findUserError.message }});
				else if (user)
					return res.status(401).json({ errors: { msg: 'This pedal is linked to a user.' }});
				else {

					Tune.findOne({ 'pedals': { $in: req.params.id }}, function(findTuneError, tune) {

						if (findTuneError)
							return res.status(500).json({ errors: { msg: findTuneError.message }});
						else if (tune)
							return res.status(401).json({ errors: { msg: 'This pedal is linked to a tune.' }});
						else {

							Pedal.remove({ _id: req.params.id}, function(removeError) {

								if (removeError)
									return res.status(500).json({ errors: { msg: removeError.message }});
								else
									return res.sendStatus(200);
							})
						}
					});
				}

			});
		}
	});

});

// Request: edit a pedal's name.
router.put('/:id/name/:name', (req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	try {

		validationResult(req).throw();

		Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (!pedal)
				return res.status(500).json({ errors: { msg: 'There was a problem while getting the pedal from the database.' }});
			else {

				pedal.name = req.params.pedal;
				pedal.save(function(saveError, updatedUser) {

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

// Request: edit a pedal's knob's value.
router.put('/:id/knob/:kid/value', [

	check('value')
		.exists().withMessage('The value was not informed.')
		.isInt({ min: 0, max: 100 }).withMessage('The value must be a int between 0 and 100.')

], (req, res, next) => {

	if (!req.session.userId)
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	try {

		validationResult(req).throw();

		Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (!pedal)
				return res.status(404).json({ errors: { msg: 'The pedal not exist in the database.' }});
			else {

				var hasKnob = false;
				var searchKnobId = mongoose.Types.ObjectId(req.params.kid);

				for (var i = 0; i < pedal.knobs.length; i++) {
					let knobId = pedal.knobs[i]._id;
					if (knobId.equals(searchKnobId)) {
						pedal.knobs[i].value = req.body.value;
						hasKnob = true;
						break;
					}
				}
				
				if (!hasKnob)
					return res.status(404).json({ errors: { msg: 'The knob not exist in the pedal.' }});
				else {
					pedal.save(function(saveError, pedal) {

						if (saveError)
							return res.status(500).json({ errors: { msg: saveError.message }});
						else
							return res.sendStatus(200);
					});
				}
			}

		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}

});


module.exports = router;