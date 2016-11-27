// Currently Unused

const sql = require('mysql');
const db = {};

module.exports = (function () {

  return {
    /**
     * Passes a username/password pair to the database store procedure for validation.
     **/
    validateCredentials () {
      db.connect( err => {
        if (err) throw err;

        // execute a query on our database
        db.query('SELECT $1::text as name', ['brianc'], function (err, result) {
          if (err) throw err;

          // just print the result to the console
          console.log(result.rows[0]);

          // disconnect the client
          db.end(err => {
            if (err) throw err;
          });
        });
      });
    }
  };
})();
