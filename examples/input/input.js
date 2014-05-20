var parser;

parser = function(term, cmd) {
  if (cmd === 'clear') {
    return term.clear();
  } else if (cmd === 'login') {
    return term.get_input('user name:', function(username) {
      return term.get_masked_input('password:', function(password) {
        return term.echo("" + username + "-" + password);
      });
    });
  } else {
    return term.echo(cmd);
  }
};

$(function() {
  return $('#terminal').terminal(parser, {
    greeting: 'Welcome to mini-term...'
  });
});
