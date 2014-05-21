require.config({
  paths: {
    'jquery': '/jquery/dist/jquery.min',
    'mini-term': '/mini-term'
  },
  shim: {
    'mini-term': {
      deps: ['jquery']
    }
  }
});

define(['jquery', 'mini-term'], function($, mini_term) {
  var parser;
  parser = function(term, cmd) {
    if (cmd === 'clear') {
      return term.clear();
    } else {
      return term.echo(cmd);
    }
  };
  return $(function() {
    return $('#terminal').terminal(parser, {
      greeting: 'Welcome to RequireJS mini-term...'
    });
  });
});
