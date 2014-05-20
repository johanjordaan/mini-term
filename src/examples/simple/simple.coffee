parser = (term,cmd) ->
  if(cmd == 'clear')
    term.clear()
  else
    term.echo(cmd)

$ ()->
  $('#terminal').terminal parser,{greeting:'Welcome to mini-term...'}