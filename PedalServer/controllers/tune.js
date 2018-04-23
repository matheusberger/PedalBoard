var mongoose = require('mongoose');
var express = require('express');
var router = express.Router();

var User = require('../models/user');
var Tune = require('../models/tune');
var Pedal = require('../models/pedal');
var Knob = require('../models/knob');
var PedalSetup = require('../models/pedalSetup');

const { check, validationResult } = require('express-validator/check');

router.post('/', [

	check('name')
		.exists().withMessage('The tune name was not informed.')
		.isString().withMessage('The tune name must be a string.'),

	check('artist')
		.exists().withMessage('The artist name was not informed.')
		.isString().withMessage('The artist name must be a string.')

], (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	try {

		validationResult(req).throw();

		Tune.create({
			owner: currentAuthUserId,
			name: req.body.name,
			artist: req.body.artist
		}).then((tune) => {
			return res.status(200).send(tune);
		}).catch((createError) => {
			return res.status(500).json({ errors: { msg: createError.message}});
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.get('/:id', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId)
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	Tune.findOne({ _id: req.params.id}, function(findError, tune) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!tune)
			return res.status(404).json({ errors: { msg: 'Tune not found.' }});

		return res.status(200).send(tune);
	});

});


router.patch('/:id/name', [

	check('name')
		.exists().withMessage('The tune name was not informed.')
		.isString().withMessage('The tune name must be a string.'),

], (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	try {

		validationResult(req).throw();

		Tune.findOne({ _id: req.params.id }, function(findError, tune) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message}});
			else if (!tune)
				return res.status(404).json({ errors: { msg: 'Tune not found.' }});
			else if (!tune.owner.equals(currentAuthUserId))
				return res.status(409).json({ errors: { msg: 'User not allowed.' }});

			tune.name = req.body.name;

			tune.save(function(saveError, updatedTune) {
				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message}});

				return res.sendStatus(200);
			});
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.patch('/:id/artist', [

	check('artist')
		.exists().withMessage('The artist name was not informed.')
		.isString().withMessage('The artist name must be a string.')

], (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId) 
		return res.status(401).json({ errors: { msg: 'User not logged.' }});

	try {

		validationResult(req).throw();

		Tune.findOne({ _id: req.params.id }, function(findError, tune) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message}});
			else if (!tune)
				return res.status(404).json({ errors: { msg: 'Tune not found.' }});
			else if (!tune.owner.equals(currentAuthUserId))
				return res.status(409).json({ errors: { msg: 'User not allowed.' }});

			tune.artist = req.body.artist;

			tune.save(function(saveError, updatedTune) {
				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message}});

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

	Tune.findOne({ _id: req.params.id }, function(findError, tune) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message}});
		else if (!tune)
			return res.status(404).json({ errors: { msg: 'Tune not found.' }});
		else if (!tune.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		User.findOne({ 'tunes': { $in: [tune._id] }}, function(findUserError, user) {

			if (findUserError)	
				return res.status(500).json({ errors: { msg: findUserError.message }});
			else if (user)
				return res.status(403).json({ errors: { msg: 'This tune is linked to a user.' }});

			Tune.remove({ _id: req.params.id }, function(removeError) {
				if (removeError)
					return res.status(500).json({ errors: { msg: removeError.message}});

				return res.sendStatus(200);
			});
		});
	});
});


router.put('/:id/pedal/:pid', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId)
		return res.status(401).json({ errors: { msg: 'Uset not logged.' }});

	Tune.findOne({ _id: req.params.id }, function(findError, tune) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!tune)
			return res.status(404).json({ errors: { msg: 'Tune not found.' }});
		else if (!tune.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		let pedalId = mongoose.Types.ObjectId(req.params.pid);

		let tuneHasPedal = false;

		for (i = 0; i < tune.pedalSetups.length; i++) {
			if (tune.pedalSetups[i].pedal.equals(pedalId)) {
				tuneHasPedal = true;
				break;
			}
		}

		if (tuneHasPedal)
			return res.status(403).json({ errors: { msg: 'This pedal is already linked to the tune.' }});

		Pedal.findOne({ _id: req.params.pid }, function(findPedalError, pedal) {

			if (findPedalError)
				return res.status(500).json({ errors: { msg: findPedalError.message }});
			else if (!pedal)
				return res.status(404).json({ errors: { msg: 'Pedal not found.' }});
			else if (!pedal.owner.equals(currentAuthUserId))
				return res.status(409).json({ errors: { msg: 'User not allowed.' }});

			let ksValues = pedal.knobs.map(function(knob) {
				return {
					knob: knob,
					value: 0
				}
			});

			let pedalSetup = new PedalSetup({
				pedal: pedal._id
			});
			pedalSetup.knobsValue.push(...ksValues);

			tune.pedalSetups.push(pedalSetup);

			tune.save(function(saveError) {
				if (saveError)
					return res.status(500).json({ errors: { msg: createKnobsError.message }});

				return res.sendStatus(200);
			});
		});
	});
});


router.delete('/:id/pedal/:pid', (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId)
		return res.status(401).json({ errors: { msg: 'Uset not logged.' }});

	Tune.findOne({ _id: req.params.id }, function(findError, tune) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!tune)
			return res.status(404).json({ errors: { msg: 'Tune not found.' }});
		else if (!tune.owner.equals(currentAuthUserId))
			return res.status(409).json({ errors: { msg: 'User not allowed.' }});

		let pedalId = mongoose.Types.ObjectId(req.params.pid);

		let tuneHasPedal = false;
		for (i = 0; i < tune.pedalSetups.length; i++) {
			if (tune.pedalSetups[i].pedal.equals(pedalId)) {
				tuneHasPedal = true;
				break;
			}
		}

		if (!tuneHasPedal)
			return res.status(403).json({ errors: { msg: 'This pedal is not linked to the tune.' }});

		Pedal.findOne({ _id: req.params.pid }, function(findPedalError, pedal) {

			if (findPedalError)
				return res.status(500).json({ errors: { msg: findPedalError.message }});
			else if (!pedal)
				return res.status(404).json({ errors: { msg: 'Pedal not found.' }});
			else if (!pedal.owner.equals(currentAuthUserId))
				return res.status(409).json({ errors: { msg: 'User not allowed.' }});

			tune.pedalSetups = tune.pedalSetups.filter(function(pedalSetup) {
				return !pedalSetup.pedal.equals(pedal._id);
			});

			tune.save(function(saveError) {

				if (saveError)
					return res.status(500).json({ errors: { msg: createKnobsError.message }});

				return res.sendStatus(200);
			});

		});
	});
});


router.patch('/:id/pedal/:pid/knob/:kid/value', [

	check('value')
		.exists().withMessage('The value was not informed.')
		.isInt({ min: 0, max: 100 }).withMessage('The value must be a int between 0 and 100.')

], (req, res, next) => {

	let currentAuthUserId = mongoose.Types.ObjectId(req.session.userId);

	if (!currentAuthUserId)
		return res.status(401).json({ errors: { msg: 'Uset not logged.' }});

	try {

		validationResult(req).throw();

		Tune.findOne({ _id: req.params.id }, function(findError, tune) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message }});
			else if (!tune)
				return res.status(404).json({ errors: { msg: 'Tune not found.' }});
			else if (!tune.owner.equals(currentAuthUserId))
				return res.status(409).json({ errors: { msg: 'User not allowed.' }});

			let requestPedalId = mongoose.Types.ObjectId(req.params.pid);
			let requestKnobId = mongoose.Types.ObjectId(req.params.kid);

			let didChangeValue = false;

			for (i = 0; i < tune.pedalSetups.length; i++) {

				if (tune.pedalSetups[i].pedal.equals(requestPedalId)) {

					for (j = 0; j < tune.pedalSetups[i].knobsValue.length; j++) {

						if (tune.pedalSetups[i].knobsValue[j].knob.equals(requestKnobId)) {
							tune.pedalSetups[i].knobsValue[j].value = req.body.value;
							didChangeValue = true;
							break;
						}
					}
				}
			}

			if (!didChangeValue)
				return res.status(403).json({ errors: { msg: 'Pedal or Knob not found.' }});

			tune.save(function(saveError, updatedTune) {
				if (saveError)
					return res.status(500).json({ errors: { msg: saveError.message}});

				return res.sendStatus(200);
			});
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}

});


module.exports = router;