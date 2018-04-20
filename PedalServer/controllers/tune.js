var express = require('express');
var router = express.Router();

var User = require('../models/user');
var Tune = require('../models/tune');
var Pedal = require('../models/pedal');

const { check, validationResult } = require('express-validator/check');



/*

router.post('/', [

	check('name')
		.exists().withMessage('The tune name was not informed.')
		.isString().withMessage('The tune name must be a string.'),

	check('artist')
		.exists().withMessage('The artist name was not informed.')
		.isString().withMessage('The artist name must be a string.')

], (req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	try {

		validationResult(req).throw();

		Tune.create({
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


router.put('/:id', [

	check('name')
		.exists().withMessage('The tune name was not informed.')
		.isString().withMessage('The tune name must be a string.'),

	check('artist')
		.exists().withMessage('The artist name was not informed.')
		.isString().withMessage('The artist name must be a string.')

], (req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	try {

		validationResult(req).throw();

		Tune.findOne({ _id: req.params.id }, function(findError, tune) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message}});
			else if (!tune)
				return res.status(404).json({ errors: { msg: 'The tune not exist in the database.' }});
			else {

				tune.name = req.body.name;
				tune.artist = req.body.artist;

				tune.save(function(saveError, updatedTune) {

					if (saveError)
						return res.status(500).json({ errors: { msg: saveError.message}});
					else
						return res.status(200).send(updatedTune);
				});
			}

		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});





router.delete('/:id', (req, res, next) => {

	if (!req.session.userId)
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	Tune.findOne({ _id: req.params.id }, function(findError, tune) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message}});
		else if (!tune)
			return res.status(404).json({ errors: { msg: 'The tune not exist in the database.' }});
		else {

			Tune.remove({ _id: req.params.id }, function(removeError) {

				if (removeError)
					return res.status(500).json({ errors: { msg: removeError.message}});
				else {

					User.findByIdAndUpdate(req.session.userId, { $pull: { 'pedals': req.params.id } }, function(updateUserError, user) {
						
						if (updateUserError)
							return res.status(500).json({ errors: { msg: updateUserError.message}});
						else
							return res.sendStatus(200);
					});
				}
			});

		}
	});

});


router.put('/:id/pedal/:pid', (req, res, next) => {

	if (!req.session.userId)
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	try {

		validationResult(req).throw();

		Tune.findOne({ _id: req.params.id }, function(findError, tune) {

			if (findError)
				return res.status(500).json({ errors: { msg: findError.message}});
			else if (!tune)
				return res.status(404).json({ errors: { msg: 'The tune not exist in the database.' }});
			else {

				Pedal.findOne({ _id: req.params.pid }, function(findPedalError, pedal) {

					if (findPedalError)
						return res.status(500).json({ errors: { msg: findPedalError.message}});
					else if (!pedal)
						return res.status(404).json({ errors: { msg: 'The pedal not exist in the database.' }});
					else {

						Pedal.create({
							name: pedal.name,
							knobs: pedal.knobs
						}).then((copyPedal) => {

								tune.pedals.push(copyPedal._id);
								tune.save(function(saveError, tune) {

									if (saveError)
										return res.status(500).json({ errors: { msg: saveError.message}});
									else
										return res.status(200).send(copyPedal);
								});

						}).catch((createError) => {
							return res.status(500).json({ errors: { msg: createError.message}});
						})
					}

				});
			}
		});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.delete('/:id/pedal/:pid', (req, res, next) => {

	if (!req.session.userId)
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	Tune.findOne({ _id: req.params.id }, function(findError, tune) {

		if (findError)
			return res.status(500).json({ errors: { msg: findError.message}});
		else if (!tune)
			return res.status(404).json({ errors: { msg: 'The tune not exist in the database.' }});
		else {

			var hasPedal = false;
			for (i = 0; i < tune.pedals.length; i++) {
				if (tune.pedals[i].equals(req.params.pid)) {
					hasPedal = true;
				}
			}

			if (!hasPedal)
				return res.status(401).json({ errors: { msg: 'The pedal is not in the tune.' }});
			else {

				tune.update({ $pull: { 'pedals': req.params.pid }, function(updateError, tune) {

					if (updateError) {

					}
				});
			}
		}
	});

});
*/

module.exports = router;