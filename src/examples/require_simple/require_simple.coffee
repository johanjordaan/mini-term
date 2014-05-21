require.config
  paths : 
      'jquery'   : '/jquery/dist/jquery.min'
      'mini-term': '/mini-term'

  shim :  
    'mini-term' :
      deps : ['jquery']

define ['jquery','mini-term'], ($,mini_term) ->
  parser = (term,cmd) ->
    if(cmd == 'clear')
      term.clear()
    else
      term.echo(cmd)

  $ ()->
    $('#terminal').terminal parser,{greeting:'Welcome to RequireJS mini-term...'}


