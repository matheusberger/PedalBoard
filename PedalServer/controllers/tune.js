var express = require('express');
var router = express.Router();

var User = require('../models/user');
var Tune = require('../models/tune');

const { check, validationResult } = require('express-validator/check');

router.get('/', function (req, res) {

	if (req.session.userId) {

		User.findWithId(req.session.userId).then(user => {

			Tune.findWithIds(user.tunes).then(tunes => {

				return res.status(200).send(tunes);

			}).catch(() => {

				return res.status(500).json({ errors: { msg: 'There was a problem while getting the tunes from the database.' }});
			});

		}).catch(() => {
			return res.status(500).json({ errors: { msg: 'There was a problem while getting the user from the database.' }});
		});

	} else
		return res.status(403).json({ errors: { msg: 'No user is current logged.' }});
});


router.post('/', [

	check('name', 'The tune name was not informed.').exists(),

	check('artist', 'The artist name was not informed.').exists()


], (req, res, next) => {

	try {
		validationResult(req).throw();

		if (req.session.userId) {

			Tune.create({
				name: req.body.name,
				artist: req.body.artist
			}, function(insertTuneError, tune) {

				if (insertTuneError) {
					return res.status(500).json({ errors: { msg: 'There was a problem adding the tune to the database.' }});
				}

				User.addTune(req.session.userId, tune._id, function(insertTuneToUserError) {

					if (insertTuneToUserError) {
						return res.status(500).json({ errors: { msg: insertTuneToUserError.message}});
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


router.delete('/:id', [

	check('id', 'The tune id was not informed.').exists()

], (req, res, next) => {

	try {
		validationResult(req).throw();

		if (req.session.userId) {

			Tune.findWithId(req.params.id).then((tune) => {

				Tune.remove({ _id: req.params.id }, function(removeTuneError) {

					if (removeTuneError) {
						return res.status(500).json({ errors: { msg: 'There was a problem while removing the tune from the database.' }});
					}

					User.removeTune(req.session.userId, req.params.id).then(() => {

						return res.sendStatus(200);

					}).catch(() => {

						return res.status(500).json({ errors: { msg: 'There was a problem while removing the tune from the database.' }});
					});
				});

			}).catch(() => {
				return res.status(404).json({ errors: { msg: 'The tune not exist in the database.' }});
			});

		} else
			return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}

});


router.put('/:id', [

	check('id', 'The tune id was not informed.').exists(),

	check('name', 'The new user name was not informed.').exists(),

	check('artist', 'The new artist name was not informed.').exists()

], (req, res, next) => {

	try {
		validationResult(req).throw();

		if (req.session.userId) {

			Tune.findWithId(req.params.id).then(tune => {

				tune.update(req.body.name, req.body.artist).then((tuneUpdated) => {

					return res.status(200).send(tuneUpdated);

				}).catch(() => {
					return res.status(500).json({ errors: { msg: 'There was a problem while updating the tune from the database.' }});
				});

			}).catch(() => {
				return res.status(404).json({ errors: { msg: 'The tune not exist in the database.' }});
			});

		} else
			return res.status(403).json({ errors: { msg: 'No user is current logged.' }});

	} catch (validationError) {
		return res.status(422).json({ errors: validationError.mapped() });
	}
});

module.exports = router;