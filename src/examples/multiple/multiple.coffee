parser = (term,cmd) ->
  if(cmd == 'clear')
    term.clear()
  else
    term.echo(cmd)

$ ()->
  $('#terminal1').terminal parser,{greeting:'Welcome to the first mini-term...'}
  $('#terminal2').terminal parser,{greeting:'Welcome to the second mini-term...'}