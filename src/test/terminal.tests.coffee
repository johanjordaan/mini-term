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

  describe '#set_prompt', () ->
    it 'should set the prompt to the provided value', () ->
      t.set_prompt('prompt>')
      t.prompt.should.equal 'prompt>'

  describe '#echo', () ->   
    it 'should add a line to the lines list', () ->
      t.clear()
      t.echo("Hallo")
      t.get_lines().length.should.equal 1
      t.get_lines()[0].line.should.equal 'Hallo'

    it 'should set the prompt to an empty string', () ->
      t.get_lines()[0].prompt.should.equal ''

    it 'should set the cmd_ind to false on echo', () ->
      t.get_lines()[0].cmd_ind.should.equal false


    it 'should add multiple lines the line delimiter is the newline character (carrage return should be removed)', () ->
      t.clear()
      t.echo("Hallo wo\rrld\nWhyyyy")
      t.get_lines().length.should.equal 2      

  describe '#accept', () ->    
    ta = new Terminal(()->)
    ta.clear()
    ta.set_buffer('help')
    ta.accept()
    it 'should clear the buffer on accept', () ->
      ta.get_buffer().should.equal ''
    it 'should add one line to the terminal lines with the correct value and prompt', () ->
      ta.get_lines().length.should.equal 1   
      ta.get_lines()[0].line.should.equal 'help'       
      ta.get_lines()[0].prompt.should.equal 'mini-term>'


  describe '#get_input', (done) ->
    ti = new Terminal(()->)
    ti.clear()
    ti.get_input 'user name:',(username)->
      username.should.equal = 'johan'

      it 'should create a line with the correct prompt an value', (done)->
        ti.get_lines().length.should.equal 1   
        ti.get_lines()[0].line.should.equal 'johan'       
        ti.get_lines()[0].prompt.should.equal 'user name:'

        done()

    ti.set_buffer('johan')    
    ti.accept()




    
    


    
  