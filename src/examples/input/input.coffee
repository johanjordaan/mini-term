parser = (term,cmd) ->
  if(cmd == 'clear')
    term.clear()
  else if(cmd == 'login')
    term.get_input 'user name:',(username)->
      term.get_masked_input 'password:',(password)->
        term.echo "#{username}-#{password}"
  else
    term.echo(cmd)
 
$ ()->
  $('#terminal').terminal parser,{greeting:'Welcome to mini-term...'}