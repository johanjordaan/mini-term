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

      handle_special_keys = (e) ->
        

        e = e || window.event
        target = e.target || e.srcElement

        if(target.className == 'terminal_base')
          if e.keyCode == 8
            e.preventDefault()
            tvm.handle_key 'BACKSPACE'
          else if e.keyCode == 13
            e.preventDefault()
            tvm.handle_key 'ENTER'
        else      
          if (e.keyCode == 8 && !/input|textarea/i.test(target.nodeName))
            return false

        return true

      handle_keys = (e) ->
        e.preventDefault()

        e = e || window.event
        target = e.target || e.srcElement

        if(target.className == 'terminal_base')
          key_name = String.fromCharCode(e.which||e.charCode||e.keyCode)
          tvm.handle_key key_name
            

      document.onkeydown = handle_special_keys
      document.onkeypress = handle_keys

      
     
      return @
)(jQuery)
