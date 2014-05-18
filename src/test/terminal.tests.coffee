should = require('chai').should()
expect = require('chai').expect

_ = require('underscore')

Terminal  = require('../main/terminal').Terminal

describe 'Terminal', (done) ->
  echo = (terminal,command) ->
    terminal.echo(command)

  t = new Terminal(echo)

  describe '#constructor', () ->
    it 'should create a new terminal', () ->

  describe '#set_buffer/#get_buffer', () ->    
    it 'should add characters to the current buffer', () ->
      t.set_buffer(t.get_buffer() + 'help')
      t.set_buffer(t.get_buffer() + ' me')
      t.get_buffer().length.should.equal 7
      t.get_buffer().should.equal 'help me'

  describe '#echo', () ->   
    it 'should add a line to the lines list', () ->
      t.clear()
      t.echo("Hallo")
      t.get_lines().length.should.equal 1

    it 'should add multiple lines the line delimiter is the newline character (carrage return should be removed)', () ->
      t.clear()
      t.echo("Hallo wo\rrld\nWhyyyy")
      t.get_lines().length.should.equal 2      

  describe '#accept', () ->    
    it 'should execute the contents of the buffer on accept', () ->
      t.clear()
      t.accept()
      t.get_buffer().should.equal ''
      t.get_lines().length.should.equal 2






    
    


    
  