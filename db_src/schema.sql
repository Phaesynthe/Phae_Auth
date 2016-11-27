DROP DATABASE IF EXISTS phae_auth;

/* Create the database */
CREATE DATABASE phae_auth;

/* Tables */
CREATE TABLE phae_auth.auth_credentials (
	id int(11) NOT NULL AUTO_INCREMENT,
	account_id int(11) NOT NULL, /* Need to alter this to be a UUID */
	indicator_credential varchar(256) NOT NULL,
	salt varchar(50) NOT NULL,
	pass_key varchar(128) NOT NULL,
	created_timestamp date NOT NULL,
	created_by int(11) NOT NULL,
	last_activity date NOT NULL,
	is_active tinyint(1) NOT NULL DEFAULT '1',
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE phae_auth.bearer_tokens (
	id int(11) NOT NULL AUTO_INCREMENT,
	credential int(11) NOT NULL, /* FKey to auth_credentials.id */
	token varchar(25) NOT NULL,
	date_set date NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE phae_auth.refresh_tokens (
  id int(11) NOT NULL AUTO_INCREMENT,
	credential int(11) NOT NULL, /* FKey to auth_credentials.id */
	token varchar(50) NOT NULL,
	date_set date NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
