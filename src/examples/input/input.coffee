parser = (term,cmd) ->
  if(cmd == 'clear')
    term.clear()
  else if(cmd == 'help')
    term.echo 'help clear login'
  else if(cmd == 'login')
    term.get_input 'user name:',(username)->
      term.get_masked_input 'password:',(password)->
        if password == "please"
          term.set_prompt "#{username}>"
        else 
          term.echo 'Wrong password'
  else if(cmd == '')
  else
    term.echo 'Unknown command'
 
$ ()->
  $('#terminal').terminal parser,{greeting:'Welcome to mini-term...',prompt:'welcome>'}