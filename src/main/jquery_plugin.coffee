(
  terminals = {}

  ($) ->
    $.fn.terminal = (interpreter,options) ->
      # Crummy code to force div to acept key events
      #
      @.addClass 'mini-term'
      @.attr 'tabindex','1'
      @.focus()

      t = new Terminal(interpreter)
      tvm = new TerminalVM(@,t,options)   

      terminals[@[0].id] = tvm

      handle_special_keys = (e) ->
        
        e = e || window.event
        target = e.target || e.srcElement

        if(target.className == 'mini-term')
          if e.keyCode == 8
            e.preventDefault()
            terminals[target.id]._handle_key 'BACKSPACE'
          else if e.keyCode == 13
            e.preventDefault()
            terminals[target.id]._handle_key 'ENTER'
        else      
          if (e.keyCode == 8 && !/input|textarea/i.test(target.nodeName))
            return false

        return true

      handle_keys = (e) ->
        e.preventDefault()

        e = e || window.event
        target = e.target || e.srcElement

        if(target.className == 'mini-term')
          key_name = String.fromCharCode(e.which||e.charCode||e.keyCode)
          terminals[target.id]._handle_key key_name
            
          
      document.onkeydown = handle_special_keys
      document.onkeypress = handle_keys

      
     
      return @
)(jQuery)
