var express = require('express');
var router = express.Router();

var User = require('../models/user');
var Tune = require('../models/tune');
var Pedal = require('../models/pedal');

const { check, validationResult } = require('express-validator/check');

router.post('/', [

	check('name', 'The tune name was not informed.').exists(),

	check('artist', 'The artist name was not informed.').exists()

], (req, res, next) => {

	if (!req.session.userId) 
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	try {

		validationResult(req).throw();

		Tune.create({
			name: req.body.name,
			artist: req.body.artist
		}).then((tune) => {

			User.findByIdAndUpdate(req.session.userId, { '$push': { tunes: tune._id }}, function(updateError, user) {

				if (updateError)
					return res.status(500).json({ errors: { msg: updateError.message}});
				else
					return res.sendStatus(200);
			});

		}).catch((createError) => {
			return res.status(500).json({ errors: { msg: createError.message}});
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

			Tune.find({ _id: { $in: user.tunes } }, function(findTunesError, tunes) {

				if (findTunesError)
					return res.status(500).json({ errors: { msg: findTunesError.message }});
				else
					return res.status(200).send(tunes);
			});
		}
	});	
});


router.put('/:id', [

	check('name', 'The new user name was not informed.').exists(),

	check('artist', 'The new artist name was not informed.').exists()

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


function insertPedals(requestBody, intoTune, callback) {

	var pedals = [];
	for (var i = 0; i < requestBody.pedals.length; i++) {
		let pedal = new Pedal({
			name: requestBody.pedals[i].name,
			knobs: requestBody.pedals[i].knobs
		});
		pedals.push(pedal);
	} 

	Pedal.create(pedals, function(createError) {

		if (createError)
			callback(createError);

		var pedalsIds = pedals.map(function(pedal) {
			return pedal._id;
		});

		intoTune.pedals = pedalsIds;

		intoTune.save(function(saveError, updatedTune) {

			if (saveError)
				callback(saveError);
			else
				callback();
		});
	});
}

router.put('/:id/pedal', [

	check('pedals')
		.exists().withMessage('The pedal ids were not informed.')
		.isArray().withMessage('The pedal ids must be an array.'),


	check('pedals.*.name').exists(),

	check('pedals.*.knobs')
		.exists()
		.isArray(),

	check('pedals.*.knobs.*.name').exists(),

	check('pedals.*.knobs.*.value').exists()

],(req, res, next) => {

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

				if (tune.pedals.length > 0) {
					console.log(tune.pedals);
					Pedal.deleteMany({ _id: { $in: tune.pedals }}, function(removeError) {

						if (removeError)
							return res.status(500).json({ errors: { msg: removeError.message}});
						else {

							insertPedals(req.body, tune, function(insertError) {

								if (insertError)
									return res.status(500).json({ errors: { msg: insertError.message}});
								else
									return res.sendStatus(200);
							});
						}
					});
				} else {

					insertPedals(req.body, tune, function(insertError) {

						if (insertError)
							return res.status(500).json({ errors: { msg: insertError.message}});
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