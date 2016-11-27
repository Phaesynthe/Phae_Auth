const chai = require('chai');
const chaiHttp = require('chai-http');
const expect = require('expect');
const express = require('express');

const config = require('../app/config');

// Tested Module
var routs = require('../app/routs');
var app = express();

chai.use(chaiHttp);

describe('Routs', () => {

  it('initializes', () => {
    expect(() => {
      routs.init(app, config);
    }).toNotThrow('')
  });

  // Login is the most basic operation exposed to the user that all other operations assume has been correctly executed.
  describe('/login', () => {

    it('reports bad request when no body is supplied', done => {
      chai.request(app)
        .post('/login')
        .send()
        .end((err, res) => {
          expect(err).toBe.null;
          expect(res.status).toBe(400);
          done();
        });
    });

    it('requires a user credintal', done => {
      chai.request(app)
        .post('/login')
        .send({
          passcode: 'test_pass'
        })
        .end((err, res) => {
          expect(err).toBe.null;
          expect(res.status).toBe(400);
          done();
        });
    });

    it('requires a passcode', done => {
      chai.request(app)
        .post('/login')
        .send({
          user: 'test_user'
        })
        .end((err, res) => {
          expect(err).toBe.null;
          expect(res.status).toBe(400);
          done();
        });
    });

    // Test failed authentication

    it('authenticates with correct credintals and returns correct tokens', done => {
      chai.request(app)
        .post('/login')
        .send({
          passcode: 'test_pass',
          user: 'test_user'
        })
        .end((err, res) => {
          expect(err).toBe.null;
          expect(res.status).toBe(200);
          expect(res.body.bearer).toExist();
          expect(res.body.refresh).toExist();
          done();
        });
    });
  });

  describe('/logout', () => {
    it('returns 200', done => {
      chai.request(app)
        .get('/logout')
        .send()
        .end((err, res) => {
          expect(err).toBe.null;
          expect(res.status).toBe(200);
          done();
        });
    });
  });

});
