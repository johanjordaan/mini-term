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
    done()
#    browser = new Browser();
#    browser.visit 'http://localhost:3000', () ->
#      browser.text('#prompt').should.equal 'term>'
#      browser.fire 'keydown', "#terminal", () ->
#        console.log browser.text('#buffer')
#        done()
