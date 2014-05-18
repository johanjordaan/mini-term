if require?
  _ = require('underscore')

class TerminalVM
  constructor : (@element,@terminal,options) ->
    @set_options(options)
    @terminal.echo @_get_option(options,'greeting','welcome to mini-term...')
    @_redraw()

    me = @
    setInterval () ->
      if !me.element.is(':focus') then return
      c = me.element.find('#cursor')
      if c.text() == '_' 
        c.text('')
      else
        c.text('_')
    , 500
    
    @element.focusin () ->
      c = me.element.find('#cursor')
      c.text('_')

    @element.focusout () ->
      c = me.element.find('#cursor')
      c.text('')




  _handle_key : (key_name) ->
    switch key_name
      when 'ENTER' then @terminal.accept()
      when 'BACKSPACE' then @terminal.set_buffer(@terminal.get_buffer().substring(0,@terminal.get_buffer().length-1))
      else @terminal.set_buffer(@terminal.get_buffer()+key_name)

    @_redraw()

  _get_option : (options,key,default_value) ->
    if (options? and options[key]?) then options[key] else default_value

  _redraw : () ->
    @element.empty()
    for line in @terminal.get_lines()
      if line.cmd_ind
        @element.append "<div><span id='prompt'>#{@prompt}</span>#{line.line}</div>"
      else  
        @element.append "<div>#{line.line}</div>"

    @element.append "<div><span id='prompt'>#{@prompt}</span><span id='buffer'>#{@terminal.get_buffer()}</span><span id='cursor'>_</span></div>"
    
    @element.scrollTop(@element.prop('scrollHeight'))

  set_options : (options) ->
    @set_prompt(@_get_option(options,'prompt','mini-term>'))

  set_greeting : (@greeting) ->

  set_prompt : (@prompt) ->  





if module?
  module.exports.TerminalVM = TerminalVM


