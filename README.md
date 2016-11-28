# Phaesynthe Authentication #

![Build Status](https://circleci.com/gh/Phaesynthe/Phae_Auth.svg?style=shield&circle-token=:circle-token)

This is a microservice that provides user validation services.


## Database Design Concepts

Basic methodology taken from [CrackStation](https://crackstation.net/hashing-security.htm). The principal, is receive
the user's initial password and apply a long salt, then hash the password. Only the salt and hashed password are
retained. This should increase the computational complexity of cracking any single password while ensuring that cracking
one password does not provide information for cracking the next password.

The trade here is that, because we do not retain a copy of the password, we cannot apply rules based on historic
patterns or audit the strength of existing passwords in any way.

Also, we restrict the application's database user's privliges from interacting with the authentication data directly.
That user can only interact with stored procedures that then interact with the data. This should lessen the chances that
an intruder could get a copy of a large set of passwords.
