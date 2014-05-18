should = require('chai').should()
expect = require('chai').expect
_ = require('underscore')
Browser = require('zombie')

server = require('../server/server').server

describe 'Live Tests', (done) ->
  before (done) ->
    done()  

  after (done) ->
    server.close()
    done()    

  it 'should call do stuff', (done) ->
    browser = new Browser();
    browser.visit 'http://localhost:3000', () ->
      browser.text('H1').should.equal 'Hallo world'
      done()