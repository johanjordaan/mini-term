var parser;

parser = function(term, cmd) {
  if (cmd === 'clear') {
    return term.clear();
  } else if (cmd === 'help') {
    return term.echo('help clear login');
  } else if (cmd === 'login') {
    return term.get_input('user name:', function(username) {
      return term.get_masked_input('password:', function(password) {
        if (password === "please") {
          return term.set_prompt("" + username + ">");
        } else {
          return term.echo('Wrong password');
        }
      });
    });
  } else if (cmd === '') {

  } else {
    return term.echo('Unknown command');
  }
};

$(function() {
  return $('#terminal').terminal(parser, {
    greeting: 'Welcome to mini-term...',
    prompt: 'welcome>'
  });
});
