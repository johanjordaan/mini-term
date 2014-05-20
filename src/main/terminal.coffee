if require?
  _ = require('underscore')



class Terminal

  # mode can be eithet input or buffer
  constructor : (@interpreter,options) ->
    @set_options(options)
    @clear()
    @echo(@_get_option(options,'greeting','welcome to mini-term...'))

  set_lines : (@lines) ->
  
  get_lines : () ->
    return @lines  

  set_buffer : (@buffer) ->
  
  get_buffer : () ->
    return @buffer

  set_prompt : (@prompt) ->
  
  get_prompt : () ->
    if @mode == 'input'
      return @input_prompt
    else  
      return @prompt

  _get_option : (options,key,default_value) ->
    if (options? and options[key]?) then options[key] else default_value
  
  set_options : (options) ->
    @set_prompt(@_get_option(options,'prompt','mini-term>'))  

  clear : () ->
    @set_buffer ''
    @set_lines []
    @mode = 'buffer' 

  echo : (string) ->
    @_echo string, false, '', false  

  _echo : (string,cmd_ind,prompt,masked) ->
    lines = string.replace('\r','').split('\n')
    for line in lines
      @lines.push { cmd_ind:cmd_ind ,line:line, prompt:prompt, masked:masked }  
 
  accept : () ->
    buffer = @get_buffer()
    @set_buffer ''  

    if @mode == 'input'
      @_echo buffer, true, @input_prompt,@mask_input
      @mode = 'buffer'            
      @input_cb(buffer)   # This has to be the last expression in case we do another get_input
    else  
      @_echo buffer, true, @prompt,false
      @interpreter @,buffer  

  get_input : (prompt,cb) ->
    @mode = 'input'
    @input_cb = cb
    @input_prompt = prompt
    @mask_input = false

  get_masked_input : (prompt,cb) ->
    @mode = 'input'
    @input_cb = cb
    @input_prompt = prompt
    @mask_input = true


      

if module?
  module.exports.Terminal = Terminal


