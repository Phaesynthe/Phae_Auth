// Currently Unused

const sql = require('mysql');

const db = sql.createConnection({
  host     : 'localhost',
  user     : 'me',
  password : 'secret',
  database : 'my_db'
});

// db.connect();

module.exports = (function () {

  return {
    /**
     * Passes a username/password pair to the database store procedure for validation.
     **/
    validateCredentials (user, passcode) {
      // hit DB with pair
      // Success will contain a token

      return {
        bearer: 'test'
      };
    }
  };
})();
