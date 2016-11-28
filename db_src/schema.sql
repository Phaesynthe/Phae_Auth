DROP DATABASE IF EXISTS phae_auth;

/* Create the database */
CREATE DATABASE phae_auth;

/* Tables */
CREATE TABLE phae_auth.auth_credentials (
	id INT(11) NOT NULL AUTO_INCREMENT,
	external_id VARCHAR(36) NOT NULL, /* external UUID */
	indicator_credential VARCHAR(256) NOT NULL,
	salt VARCHAR(50) NOT NULL,
	pass_key VARCHAR(128) NOT NULL,
	created_timestamp DATETIME NOT NULL,
	created_by INT(11) NOT NULL,
	last_activity datetiDATETIMEme NOT NULL,
	is_active tinyint(1) NOT NULL DEFAULT '1',
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE phae_auth.bearer_tokens (
	id INT(11) NOT NULL AUTO_INCREMENT,
	credential INT(11) NOT NULL,
	token VARCHAR(128) NOT NULL,
	date_set DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
    FOREIGN KEY (credential) REFERENCES phae_auth.auth_credentials(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
