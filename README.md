mini-term
=========

The aim of the project is to make a very simple terminal available for use in web pages. It will not try to be a fully fledged terminal. It will not try to do cute command parsing for you. It will be minimal and allow you the maiximum amount of flexability.

Have a look in examples for demo implimentations.

## Install

``` 
bower install mini-term
``` 

## Features
* Simple api
* Flexamble api 
* History
* Simple integration - jQuery plugin
* Multiple terminals per page
* Simple user input mechanism via api



## Usage
The following minimal html illustrates the most basic usage of mini-term.

```html
<html>
  <head>
    <!-- 1) jquery is required -->
    <script src="/jquery/dist/jquery.min.js"></script>
    <!-- 2) include the mini-term script and css -->
    <script src="/mini-term.js"></script>
    <link href="/mini-term.css" rel="stylesheet"></link>

    <!-- 3) Create command handler for the terminal and link the terminal --> 
    <script>
      // A parser/command handler has a handlet to the terminal and the command string
      // See the documentation for the terminal api
      parser = function(term, cmd) {
        if (cmd === 'clear') {
          return term.clear();
        } else {
          return term.echo(cmd);
        }
      };

      // Link the div to the terminal and set the parser to use
      // See the documentation for the options that can be passed to the terminal with the parser
      $(function() { $('#terminal').terminal(parser); });
    </script>
  </head>
  <body>
    
    <div id="terminal" class="simple" style="height:150px;"></div>
  </body>
</html>
```

## Options

Options are passed to the terminal via the binding method : `$(function() { $('#terminal').terminal(parser); options });`

The options paramter is an object which has the following properties:

### options.greeting : string
This is the greeting which is displayed when the terminal is started initially and when the terminal is reset via the reset api command.

### options.prompt : string
This is the prompt for the terminal.


## API

### term.echo(string)
This command will print the string to the terminal. If the string contains new lines then each line will be printed on a seperate line in the terminal.

### term.clear()
This command will clear the terminal.

### term.reset()
This command resets the terminal to its initial state. This includes clearing the history and displaying the greeting.


## Contributing

Insall grunt globally
```
npm install -g grunt
```

Fork the development branch on git hub

Install the dependencies
``` 
npm install 
```

Then run the default grunt build task
```
grunt
```
or 
```
grunt run
```
to start the example server. (The server runs on port 3000)

Make your changes (remember to add tests)

Commit and create a pull request.














## Copyright and license
Licensed under the **MIT** license.



