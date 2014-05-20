var parser;

parser = function(term, cmd) {
  if (cmd === 'clear') {
    return term.clear();
  } else {
    return term.echo(cmd);
  }
};

$(function() {
  $('#terminal1').terminal(parser, {
    greeting: 'Welcome to the first mini-term...'
  });
  return $('#terminal2').terminal(parser, {
    greeting: 'Welcome to the second mini-term...'
  });
});
