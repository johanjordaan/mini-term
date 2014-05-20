if require?
  _ = require('underscore')

class TerminalVM
  constructor : (@element,@terminal,@history,options) ->
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
      when 'ENTER' then @_enter()
      when 'BACKSPACE' then @terminal.set_buffer(@terminal.get_buffer().substring(0,@terminal.get_buffer().length-1))
      when 'UP' then @terminal.set_buffer(@history.up())
      when 'DOWN' then @terminal.set_buffer(@history.down())
      else @terminal.set_buffer(@terminal.get_buffer()+key_name)

    @_redraw()

  _enter : () ->
    if @terminal.mode == 'input'    
    else  
      @history.push(@terminal.get_buffer())
    
    @terminal.accept()  

  _redraw : () ->
    @element.empty()
    for line in @terminal.get_lines()
      if line.cmd_ind
        if line.masked
          @element.append "<div><span id='prompt'>#{line.prompt}</span></div>"
        else
          @element.append "<div><span id='prompt'>#{line.prompt}</span>#{line.line}</div>"
      else  
        @element.append "<div>#{line.line}</div>"
  
    if @terminal.mode == 'input' and @terminal.mask_input     
      @element.append "<div><span id='prompt'>#{@terminal.get_prompt()}</span></div>"
    else
      @element.append "<div><span id='prompt'>#{@terminal.get_prompt()}</span><span id='buffer'>#{@terminal.get_buffer()}</span><span id='cursor'>_</span></div>"
    
    @element.scrollTop(@element.prop('scrollHeight'))


if module?
  module.exports.TerminalVM = TerminalVM


