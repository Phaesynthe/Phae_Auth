const bodyParser = require('body-parser');

const dal =require('./dal');

module.exports = {
  init: (app, config) => {
    // Configure for reading passed in body objects
    app.use(bodyParser.urlencoded({ extended: false }));
    app.use(bodyParser.json());

    // Configure the header object
    app.use(function (req, res, next) {
      res.header('Access-Control-Allow-Origin', '*');
      res.header('Access-Control-Allow-Methods', 'GET,POST,DELETE');
      res.header('Access-Control-Allow-Headers', 'Content-Type');
      next();
    });

    // Public Access Points

    /**
     *
     **/
    app.post('/login', (req, res) => {
      var user = req.body.user;
      var passcode = req.body.passcode;

      if (!user || !passcode) {
        res.status(400).send(); // Incomplete request
        return;
      }

      res.status(200).send({
        bearer: 'token that will be supplied from DAL',
        refresh: 'token that will be supplied from DAL'
      });
    });

    app.get('/logout', (req, res) => {
      console.log('check for active tokens and destroy');
      res.status(200).send();
    });
  }
};