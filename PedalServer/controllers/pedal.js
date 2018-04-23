var mongoose = require('mongoose');
var express = require('express');
var router = express.Router();

var User = require('../models/user');
var Pedal = require('../models/pedal');
var Tune = require('../models/tune');
var Knob = require('../models/knob');

const { check, validationResult } = require('express-validator/check');

router.post('/', [

	check('name')
		.exists().withMessage('The pedal name was not informed.')
		.isString().withMessage('The pedal name must be a string'),

	check('knobs')
		.exists().withMessage('The pedal must have at least one knob.')
		.isArray().withMessage('The pedal knobs must be a array of knobs ids.')

], (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	try {

		validationResult(req).throw();

		let knobsIds = req.body.knobs.map(function(knobId) {
			return mongoose.Types.ObjectId(knobId);
		});

		Pedal.create({
			owner: currentAuthUserId,
			name: req.body.name,
			knobs: knobsIds
		}).then((pedal) => {
			return res.status(200).send(pedal);
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

	Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'Pedal not found.' }});

		return res.status(200).send(pedal);
	});

});


router.delete('/:id', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'Pedal not found.' }});
		else if (!pedal.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		User.findOne({ 'pedals': { $in: [pedal._id] }}, function(findUserError, user) {

			if (findUserError)	
				return res.status(500).json({ errors: { msg: findUserError.message }});
			else if (user)
				return res.status(403).json({ errors: { msg: 'This pedal is linked to a user.' }});


			Tune.findOne({ 'pedalSetups': { $elemMatch: { 'pedal': pedal._id }}}, function(findTuneError, tune) {

				if (findTuneError)
					return res.status(500).json({ errors: { msg: findTuneError.message }});
				else if (tune)
					return res.status(403).json({ errors: { msg: 'This pedal is linked to a tune.' }});

				Knob.remove({ _id: { $in: pedal.knobs }}, function(removeKnobsError) {

					if (removeKnobsError)
						return res.status(500).json({ errors: { msg: removeError.message }});

					Pedal.remove({ _id: pedal._id}, function(removeError) {
						if (removeError)
							return res.status(500).json({ errors: { msg: removeError.message }});
					
						return res.sendStatus(200);
					});
				});
			});
		});
	});

});


router.patch('/:id/name/', [

	check('name')
		.exists().withMessage('The new name was not informed.')
		.isString().withMessage('The new name must be a string'),

], (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	try {

		validationResult(req).throw();

		Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (!pedal)
				return res.status(404).json({ errors: { msg: 'Pedal not found.' }});
			else if (!pedal.owner.equals(currentAuthUserId))
				return res.status(409).json({ errors: { msg: 'User not allowed.' }});

			pedal.name = req.body.name;

			pedal.save(function(saveError, updatedUser) {
				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message }});
			
				return res.sendStatus(200);
			});
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.put('/:id/knob/:kid', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'Pedal not found.' }});
		else if (!pedal.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		let knobId = mongoose.Types.ObjectId(req.params.kid);

		let pedalHasKnob = false;
		for (i = 0; i < pedal.knobs.length; i++) {
			if (pedal.knobs[i].equals(knobId)) {
				pedalHasKnob = true;
				break;
			}
		}

		if (pedalHasKnob)
			return res.status(403).json({ errors: { msg: 'This knob is already linked to the pedal.' }});

		pedal.knobs.push(knobId);

		pedal.save(function(saveError, updatedUser) {
			if (saveError)
				return res.status(500).json({ errors: { msg: saveError.message }});
		
			return res.sendStatus(200);
		});
	});
});


router.delete('/:id/knob/:kid', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'Pedal not found.' }});
		else if (!pedal.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		let knobId = mongoose.Types.ObjectId(req.params.kid);

		let pedalHasKnob = false;
		for (i = 0; i < pedal.knobs.length; i++) {
			if (pedal.knobs[i].equals(knobId)) {
				pedalHasKnob = true;
				break;
			}
		}

		if (!pedalHasKnob)
			return res.status(403).json({ errors: { msg: 'This knob is not linked to the pedal.' }});

		pedal.knobs = pedal.knobs.filter(function(knob) {
			return !knob.equals(knobId);
		});

		pedal.save(function(saveError, updatedUser) {
			if (saveError)
				return res.status(500).json({ errors: { msg: saveError.message }});
		
			return res.sendStatus(200);
		});
	});
});

module.exports = router;