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
    host     : local.dbHost     || process.env.DB_HOST,
    user     : local.dbUser     || process.env.DB_USER,
    password : local.dbPassword || process.env.DB_PASSWORD,
    database : local.dbDatabase || process.env.DB_DATABASE
  }
};

module.exports = config;