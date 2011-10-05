functions = []

next = ()->
  # console.log functions
  busy    = yes for fn in functions when fn.state is "running"
  allDone = yes for fn in functions when fn.state isnt "justAdded" or fn.state isnt "running"
  
  holaback = ()->
    # console.log "finished fn nr: #{key}"
    functions[key].state = "done"
    fn.callback.fn.apply null,arguments
    functions.splice 0,1
    next()
    
  if busy?
    # console.log "something is running, waiting till it ends."
  else
    for fn,key in functions
      if fn.state is "justAdded"
        # console.log "nothing is running, starting a new one...",fn.args
        do (fn,key)->
          fn.state = "running"
          fn.args.push holaback
          fn.fn.apply null,fn.args
        break
        
QueuedFunction = (fn,condition) ->
  return ()->
    # console.log "adding it to the queue.."
    args = [].slice.call arguments
    callback = args.pop()
    functions.push 
      fn        : fn
      args      : args
      callback  :
        fn        : callback
      state     : "justAdded"
      time      : Date.now()
    next()

module.exports = QueuedFunction