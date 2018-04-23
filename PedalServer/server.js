var app = require('./app');
var fs = require('fs');
var https = require('https');

var port = process.env.PORT || 3000;

var key = fs.readFileSync('encryption/key.pem');
var cert = fs.readFileSync('encryption/cert.pem');

var options = {
  key: key,
  cert: cert
};

https.createServer(options, app).listen(port, function() {
  console.log('PedalBoard server listening on port ' + port);
});