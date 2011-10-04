(function() {
  var functions, next, serializer;
  functions = [];
  next = function() {
    var allDone, busy, fn, holaback, ____fn, ____key, _i, _j, _len, _len2, _len3, _results;
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
      functions[____key].state = "done";
      ____fn.callback.fn.apply(null, arguments);
      functions.splice(0, 1);
      return next();
    };
    if (busy != null) {
      ;
    } else {
      _results = [];
      for (____key = 0, _len3 = functions.length; ____key < _len3; ____key++) {
        ____fn = functions[____key];
        if (____fn.state === "justAdded") {
          (function(____fn, ____key) {
            ____fn.state = "running";
            ____fn.args.push(holaback);
            return ____fn.fn.apply(null, ____fn.args);
          })(____fn, ____key);
          break;
        }
      }
      return _results;
    }
  };
  serializer = function(fn, condition) {
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
  module.exports = serializer;
}).call(this);
