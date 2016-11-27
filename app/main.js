const express = require('express');
const config = require('./config');
const routs = require('./routs');

var app = express();

routs.init(app, config);

app.listen(config.port, () => {
  console.log('Phaesynthe Authentication Service running on port ' + config.port);
});