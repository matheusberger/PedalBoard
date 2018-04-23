var app = require('./app');
var fs = require('fs');
var https = require('https');

process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

var port = process.env.PORT || 3000;

var key = fs.readFileSync('encryption/key.pem');
var cert = fs.readFileSync('encryption/cert.pem');

var options = {
	url: 'https://54.207.101.234:3000/',
	key: key,
 	cert: cert,
 	requestCert: false,
  	rejectUnauthorized: false,
};

https.createServer(options, app).listen(port, function() {
  console.log('PedalBoard server listening on port ' + port);
});