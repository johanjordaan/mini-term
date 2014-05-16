if require?
  _ = require('underscore')

class Terminal

  # options : history - length
  # options : lines - length

  constructor : (@interpreter) ->
    @clear()
    @history = []

  set_lines : (@lines) ->
  
  get_lines : () ->
    return @lines  

  set_buffer : (@buffer) ->
  
  get_buffer : () ->
    return @buffer

  set_history : (@history) ->
  
  get_history : () ->
    return @history  

  clear : () ->
    @set_buffer ''
    @set_lines [] 

  echo : (string) ->
    @_echo string, false  

  _echo : (string,cmd_ind) ->
    lines = string.replace('\r','').split('\n')
    for line in lines
      @lines.push { cmd_ind:cmd_ind ,line:line }  
 
  accept : () ->
    buffer = @get_buffer()
    @_echo buffer, true
    @set_buffer ''
    @interpreter @,buffer  
      

if module?
  module.exports.Terminal = Terminal


