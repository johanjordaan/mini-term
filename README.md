mini-term
=========

## Install

``` 
npm install mini-term
``` 

## Usage

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

## Contributing


## Copyright and license
Licensed under the **MIT** license.



