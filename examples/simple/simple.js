var parser;

parser = function(term, cmd) {
  if (cmd === 'clear') {
    return term.clear();
  } else {
    return term.echo(cmd);
  }
};

$(function() {
  return $('#terminal').terminal(parser, {
    greeting: 'Welcome to mini-term...'
  });
});
