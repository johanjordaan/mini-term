if require?
  _ = require('underscore')

class TerminalVM
  constructor : (@element,@terminal) ->
    me = @

    @terminal.echo 'welcome ...'
    @redraw()

  handle_key : (key_name) ->
    switch key_name
      when 'ENTER' then @terminal.accept()
      when 'BACKSPACE' then @terminal.set_buffer(@terminal.get_buffer().substring(0,@terminal.get_buffer().length-1))
      else @terminal.set_buffer(@terminal.get_buffer()+key_name)

    @redraw()

  redraw : () ->
    @element.empty()
    for line in @terminal.get_lines()
      if line.cmd_ind
        @element.append "<div><span>term> </span>#{line.line}</div>"
      else  
        @element.append "<div>#{line.line}</div>"

    @element.append "<div><span>term> </span><span id='buffer'>#{@terminal.get_buffer()}</span><span id='cursor'>_</span></div>"
    
    @element.scrollTop(@element.prop('scrollHeight'))


if module?
  module.exports.TerminalVM = TerminalVM


