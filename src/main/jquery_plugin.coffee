(
  ($) ->
    $.fn.terminal = (interpreter) ->
      # Crummy code to force div to acept key events
      #
      @.addClass 'terminal_base'
      @.attr 'tabindex','1'
      @.focus()

      
      t = new Terminal(interpreter)
      tvm = new TerminalVM(@,t)   
      return @
)(jQuery)
