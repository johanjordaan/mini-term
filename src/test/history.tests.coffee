should = require('chai').should()
expect = require('chai').expect

_ = require('underscore')

History  = require('../main/history').History

describe 'History', (done) ->
  h = new History()

  it 'should create a new history', () ->
    expect(h.head).to.be.null
    expect(h.tail).to.be.null
    expect(h.current).to.be.null

  it 'should push new history items from the bottom of the stack', () ->
    h.push 'First'
    h.push 'Second'
    h.push 'Third'

    h.head.data.should.equal 'First'
    h.tail.data.should.equal 'Third'
    expect(h.current).to.be.null

  it 'navigate up the stack', () ->
    item = h.up()
    item.should.equal 'Third'
    item = h.up()
    item.should.equal 'Second'
    item = h.up()
    item.should.equal 'First'

  it 'navigate up the stack and warp over', () ->
    item = h.up()
    item.should.equal 'Third'

  it 'navigate down the stack', () ->
    item = h.up()
    item = h.up()
    item.should.equal 'First'
    item = h.down()
    item.should.equal 'Second'
    item = h.down()
    item.should.equal 'Third'

  it 'navigate down the stack and return an empty string at the end', () ->
    item = h.down()
    item.should.equal ''
    item = h.down()
    item.should.equal ''

  it 'should pop the item rom the current location in the stack', () ->
    h.up()
    h.up()
    h.current.data.should.equal 'Second'
    item = h.pop()
    expect(h.current).to.be.null
    item.should.equal 'Second'
    h.head.next.data.should.equal 'Third'
    expect(h.head.prev).to.be.null
    h.tail.prev.data.should.equal 'First'
    expect(h.tail.next).to.be.null


    
    
    
    














    
    


    
  