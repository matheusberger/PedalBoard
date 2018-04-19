var express = require('express');
var router = express.Router();

var User = require('../models/user');
var Pedal = require('../models/pedal');

const { check, validationResult } = require('express-validator/check');
const { matchedData, sanitize } = require('express-validator/filter');

router.post('/', [

	check('name', 'The pedal name was not informed.').exists(),

	check('knobs', 'The pedal must have at least one knob.').exists(),

	check('knobs.*.name', 'The knob name was not informed.').exists()

], (req, res, next) => {

	try {
		validationResult(req).throw();

		if (req.session.userId) {

			Pedal.create({
				name: req.body.name,
				knobs: req.body.knobs
			}, function(insertPedalError, pedal) {

				if (insertPedalError) {
					return res.status(500).json({ errors: { msg: 'There was a problem adding the pedal to the database.' }});
				}

				User.addPedal(req.session.userId, pedal._id, function(insertPedalToUserError) {

					if (insertPedalToUserError) {
						return res.status(500).json({ errors: { msg: insertPedalToUserError.message}});
					}

					return res.sendStatus(200);
				});
			});

		} else
			return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});


router.get('/', function (req, res) {

	if (req.session.userId) {

		User.findWithId(req.session.userId).then(user => {

			Pedal.findWithIds(user.pedals).then(pedals => {

				return res.status(200).send(pedals);

			}).catch(() => {

				return res.status(500).json({ errors: { msg: 'There was a problem while getting the pedals from the database.' }});
			});

		}).catch(() => {
			return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
		});

	} else
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});
});


router.get('/:id', function (req, res) {

	if (req.session.userId) {

		Pedal.findWithId(req.params.id).then(pedal => {

			return res.status(200).send(pedal);

		}).catch(() => {
			return res.status(404).json({ errors: { msg: 'The pedal not exist in the database.' }});
		});

	} else
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});
});

module.exports = router;
