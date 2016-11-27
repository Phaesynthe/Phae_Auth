var local;

// Set local configuration object
// This is only intended for development and testing environments
try {
  local = require('./config.local');
}
catch (e) {
  if (!(e instanceof Error && e.code === 'MODULE_NOT_FOUND')) {
    console.log('ERROR: ' + e.code);
  } else {
    local = {};
  }
}

var config = {
  port: local.port || process.env.HOST_PORT || 80,
  db: {
    host     : local.db.host     || process.env.DB_HOST,
    user     : local.db.user     || process.env.DB_USER,
    password : local.db.password || process.env.DB_PASSWORD,
    database : local.db.database || process.env.DB_DATABASE
  }
};

module.exports = config;