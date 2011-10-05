(function() {
  var QueuedFunction, functions, next;
  functions = [];
  next = function() {
    var allDone, busy, fn, holaback, key, _i, _j, _len, _len2, _len3, _results;
    for (_i = 0, _len = functions.length; _i < _len; _i++) {
      fn = functions[_i];
      if (fn.state === "running") {
        busy = true;
      }
    }
    for (_j = 0, _len2 = functions.length; _j < _len2; _j++) {
      fn = functions[_j];
      if (fn.state !== "justAdded" || fn.state !== "running") {
        allDone = true;
      }
    }
    holaback = function() {
      functions[key].state = "done";
      fn.callback.fn.apply(null, arguments);
      functions.splice(0, 1);
      return next();
    };
    if (busy != null) {} else {
      _results = [];
      for (key = 0, _len3 = functions.length; key < _len3; key++) {
        fn = functions[key];
        if (fn.state === "justAdded") {
          (function(fn, key) {
            fn.state = "running";
            fn.args.push(holaback);
            return fn.fn.apply(null, fn.args);
          })(fn, key);
          break;
        }
      }
      return _results;
    }
  };
  QueuedFunction = function(fn, condition) {
    return function() {
      var args, callback;
      args = [].slice.call(arguments);
      callback = args.pop();
      functions.push({
        fn: fn,
        args: args,
        callback: {
          fn: callback
        },
        state: "justAdded",
        time: Date.now()
      });
      return next();
    };
  };
  module.exports = QueuedFunction;
}).call(this);
