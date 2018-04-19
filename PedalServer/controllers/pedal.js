var express = require('express');
var router = express.Router();

var User = require('../models/user');
var Pedal = require('../models/pedal');
var Tune = require('../models/tune');

const { check, validationResult } = require('express-validator/check');

router.post('/', [

	check('name', 'The pedal name was not informed.').exists(),

	check('knobs', 'The pedal must have at least one knob.').exists(),

	check('knobs.*.name', 'The knob name was not informed.').exists()

], (req, res, next) => {

	try {

		validationResult(req).throw();

		if (!req.session.userId)
			return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

		Pedal.create({
			name: req.body.name,
			knobs: req.body.knobs
		}).then((pedal) => {

			User.findOne({ _id: req.session.userId}, function(findError, user) {

				if (findError)
					return res.status(500).json({ errors: { msg: findError.message }});
				else if (!user)
					return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
				else {

					user.pedals.push(pedal._id);
					user.save(function(saveError, user) {

						if (saveError)
							return res.status(500).json({ errors: { msg: saveError.message }});
						else
							return res.sendStatus(200);
					});
				}
			});

		}).catch((createError) => {
			return res.status(500).json({ errors: { msg: createError.message }});
		});			

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.get('/', (req, res, next) => {

	if (!req.session.userId)
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	User.findOne({ _id: req.session.userId}, function(findError, user) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!user)
			return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
		else {

			Pedal.find({ _id: {$in: user.pedals} },function(findPedalsError, pedals) {

				if (findPedalsError)
					return res.status(500).json({ errors: { msg: findPedalsError.message }});
				else
					return res.status(200).send(pedals);
			});
		}
	});	
});


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


router.delete('/:id', (req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	Pedal.findOne({ _id: req.params.id}, function(findError, pedal) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message }});
		else if (!pedal)
			return res.status(404).json({ errors: { msg: 'The pedal not exist in the database.' }});
		else {

			Tune.findOne({ pedals: req.params.id}, function(findTuneError, tune) {

				if (findTuneError)
					return res.status(500).json({ errors: { msg: findTuneError.message }});
				else if (tune)
					return res.status(401).json({ errors: { msg: 'The pedal is beeing used in some tune.' }});
				else {

					Pedal.remove({ _id: req.params.id}, function(removeError) {

						if (removeError)
							return res.status(500).json({ errors: { msg: removeError.message }});
						else {

							User.findByIdAndUpdate(req.session.userId, { $pull: { 'pedals': req.params.id } }, function(updateUserError, user) {

								if (updateUserError)
									return res.status(500).json({ errors: { msg: updateUserError.message }});
								else 
									return res.sendStatus(200);
							});
						}
					});
				}

			});

		}
		
	});

});

module.exports = router;