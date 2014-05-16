if require?
  _ = require('underscore')

class TerminalVM
  constructor : (@element,@terminal) ->
    me = @
    @element.bind 'keypress', (event) ->
      me.key_down(event)

    @terminal.echo 'welcome ...'
    @redraw()

  key_down : (event) ->
    event.preventDefault()
    switch event.keyCode
      when 13 then @terminal.accept()
      else @terminal.set_buffer(@terminal.get_buffer()+String.fromCharCode(event.which||event.charCode||event.keyCode))

    @redraw()


  redraw : () ->
    @element.empty()
    for line in @terminal.get_lines()
      if line.cmd_ind
        @element.append "<div><span>term> </span>#{line.line}</div>"
      else  
        @element.append "<div>#{line.line}</div>"

    @element.append "<div><span>term> </span><span id='buffer'>#{@terminal.get_buffer()}</span></div>"
    
    @element.scrollTop(@element.prop('scrollHeight'))


if module?
  module.exports.TerminalVM = TerminalVM


