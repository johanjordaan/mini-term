if require?
  _ = require('underscore')

class HistoryItem
  constructor : (@data) ->
    @prev = null
    @next = null

class History
  # Constructs an empty history tracker based on a 2xlinked list
  #
  constructor : () ->
    @head = null
    @tail = null
    @current = null

  # Push an item at the tail of the list
  #  
  push : (data) ->
    if data.trim() == ''
      return 

    item = new HistoryItem(data)
    if !@head?
      @head = item
      @tail = item
    else
      item.prev = @tail
      @tail.next = item
      @tail = item


  # Moves the current item up the list. Once it gets to the top it cycles
  #    
  up : () ->
    if !@current? or !@current.prev?
      @current = @tail
    else
      @current = @current.prev
    return @current.data

  # Moves the current item down the list. Once it gets to the bottom it returns 
  # empty and it does not cycle 
  #  
  down : () ->
    if !@current? or !@current.next?
      @current = null
      return '' 
    else
      @current = @current.next
  
    return @current.data

  # Pop the current item and clears the current item.
  #  
  pop : () ->
    if !@current?
      return ''
    if !@current.prev?
      @head = @current.next
      @head.prev = null
    else
      @current.prev.next = @current.next

    if !@current.next?
      @tail = @current.prev
      @tail.next = null      
    else
      @current.next.prev = @current.prev

    ret_val = @current.data   
    @current = null 
    return  ret_val 

if module?
  module.exports.History = History
