var History, HistoryItem, _;

if (typeof require !== "undefined" && require !== null) {
  _ = require('underscore');
}

HistoryItem = (function() {
  function HistoryItem(data) {
    this.data = data;
    this.prev = null;
    this.next = null;
  }

  return HistoryItem;

})();

History = (function() {
  function History() {
    this.head = null;
    this.tail = null;
    this.current = null;
  }

  History.prototype.push = function(data) {
    var item;
    if (data.trim() === '') {
      return;
    }
    item = new HistoryItem(data);
    if (this.head == null) {
      this.head = item;
      return this.tail = item;
    } else {
      item.prev = this.tail;
      this.tail.next = item;
      return this.tail = item;
    }
  };

  History.prototype.up = function() {
    if ((this.current == null) || (this.current.prev == null)) {
      this.current = this.tail;
    } else {
      this.current = this.current.prev;
    }
    return this.current.data;
  };

  History.prototype.down = function() {
    if ((this.current == null) || (this.current.next == null)) {
      this.current = null;
      return '';
    } else {
      this.current = this.current.next;
    }
    return this.current.data;
  };

  History.prototype.pop = function() {
    var ret_val;
    if (this.current == null) {
      return '';
    }
    if (this.current.prev == null) {
      this.head = this.current.next;
      this.head.prev = null;
    } else {
      this.current.prev.next = this.current.next;
    }
    if (this.current.next == null) {
      this.tail = this.current.prev;
      this.tail.next = null;
    } else {
      this.current.next.prev = this.current.prev;
    }
    ret_val = this.current.data;
    this.current = null;
    return ret_val;
  };

  return History;

})();

if (typeof module !== "undefined" && module !== null) {
  module.exports.History = History;
}

var terminals;

(terminals = {}, function($) {
  return $.fn.terminal = function(interpreter, options) {
    var handle_keys, handle_special_keys, t, tvm;
    this.addClass('terminal_base');
    this.attr('tabindex', '1');
    this.focus();
    t = new Terminal(interpreter);
    tvm = new TerminalVM(this, t, options);
    terminals[this[0].id] = tvm;
    handle_special_keys = function(e) {
      var target;
      e = e || window.event;
      target = e.target || e.srcElement;
      if (target.className === 'terminal_base') {
        if (e.keyCode === 8) {
          e.preventDefault();
          terminals[target.id]._handle_key('BACKSPACE');
        } else if (e.keyCode === 13) {
          e.preventDefault();
          terminals[target.id]._handle_key('ENTER');
        }
      } else {
        if (e.keyCode === 8 && !/input|textarea/i.test(target.nodeName)) {
          return false;
        }
      }
      return true;
    };
    handle_keys = function(e) {
      var key_name, target;
      e.preventDefault();
      e = e || window.event;
      target = e.target || e.srcElement;
      if (target.className === 'terminal_base') {
        key_name = String.fromCharCode(e.which || e.charCode || e.keyCode);
        return terminals[target.id]._handle_key(key_name);
      }
    };
    document.onkeydown = handle_special_keys;
    document.onkeypress = handle_keys;
    return this;
  };
})(jQuery);

var Terminal, _;

if (typeof require !== "undefined" && require !== null) {
  _ = require('underscore');
}

Terminal = (function() {
  function Terminal(interpreter) {
    this.interpreter = interpreter;
    this.clear();
    this.history = [];
  }

  Terminal.prototype.set_lines = function(lines) {
    this.lines = lines;
  };

  Terminal.prototype.get_lines = function() {
    return this.lines;
  };

  Terminal.prototype.set_buffer = function(buffer) {
    this.buffer = buffer;
  };

  Terminal.prototype.get_buffer = function() {
    return this.buffer;
  };

  Terminal.prototype.set_history = function(history) {
    this.history = history;
  };

  Terminal.prototype.get_history = function() {
    return this.history;
  };

  Terminal.prototype.clear = function() {
    this.set_buffer('');
    return this.set_lines([]);
  };

  Terminal.prototype.echo = function(string) {
    return this._echo(string, false);
  };

  Terminal.prototype._echo = function(string, cmd_ind) {
    var line, lines, _i, _len, _results;
    lines = string.replace('\r', '').split('\n');
    _results = [];
    for (_i = 0, _len = lines.length; _i < _len; _i++) {
      line = lines[_i];
      _results.push(this.lines.push({
        cmd_ind: cmd_ind,
        line: line
      }));
    }
    return _results;
  };

  Terminal.prototype.accept = function() {
    var buffer;
    buffer = this.get_buffer();
    this._echo(buffer, true);
    this.set_buffer('');
    return this.interpreter(this, buffer);
  };

  return Terminal;

})();

if (typeof module !== "undefined" && module !== null) {
  module.exports.Terminal = Terminal;
}

var TerminalVM, _;

if (typeof require !== "undefined" && require !== null) {
  _ = require('underscore');
}

TerminalVM = (function() {
  function TerminalVM(element, terminal, options) {
    var me;
    this.element = element;
    this.terminal = terminal;
    this.set_options(options);
    this.terminal.echo(this._get_option(options, 'greeting', 'welcome to mini-term...'));
    this._redraw();
    me = this;
    setInterval(function() {
      var c;
      if (!me.element.is(':focus')) {
        return;
      }
      c = me.element.find('#cursor');
      if (c.text() === '_') {
        return c.text('');
      } else {
        return c.text('_');
      }
    }, 500);
    this.element.focusin(function() {
      var c;
      c = me.element.find('#cursor');
      return c.text('_');
    });
    this.element.focusout(function() {
      var c;
      c = me.element.find('#cursor');
      return c.text('');
    });
  }

  TerminalVM.prototype._handle_key = function(key_name) {
    switch (key_name) {
      case 'ENTER':
        this.terminal.accept();
        break;
      case 'BACKSPACE':
        this.terminal.set_buffer(this.terminal.get_buffer().substring(0, this.terminal.get_buffer().length - 1));
        break;
      default:
        this.terminal.set_buffer(this.terminal.get_buffer() + key_name);
    }
    return this._redraw();
  };

  TerminalVM.prototype._get_option = function(options, key, default_value) {
    if ((options != null) && (options[key] != null)) {
      return options[key];
    } else {
      return default_value;
    }
  };

  TerminalVM.prototype._redraw = function() {
    var line, _i, _len, _ref;
    this.element.empty();
    _ref = this.terminal.get_lines();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      line = _ref[_i];
      if (line.cmd_ind) {
        this.element.append("<div><span id='prompt'>" + this.prompt + "</span>" + line.line + "</div>");
      } else {
        this.element.append("<div>" + line.line + "</div>");
      }
    }
    this.element.append("<div><span id='prompt'>" + this.prompt + "</span><span id='buffer'>" + (this.terminal.get_buffer()) + "</span><span id='cursor'>_</span></div>");
    return this.element.scrollTop(this.element.prop('scrollHeight'));
  };

  TerminalVM.prototype.set_options = function(options) {
    return this.set_prompt(this._get_option(options, 'prompt', 'mini-term>'));
  };

  TerminalVM.prototype.set_greeting = function(greeting) {
    this.greeting = greeting;
  };

  TerminalVM.prototype.set_prompt = function(prompt) {
    this.prompt = prompt;
  };

  return TerminalVM;

})();

if (typeof module !== "undefined" && module !== null) {
  module.exports.TerminalVM = TerminalVM;
}
