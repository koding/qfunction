functions = []

next = ()->
  # console.log functions
  busy    = yes for fn in functions when fn.state is "running"
  allDone = yes for fn in functions when fn.state isnt "justAdded" or fn.state isnt "running"
  
  holaback = ()->
    # console.log "finished fn nr: #{____key}"
    functions[____key].state = "done"
    ____fn.callback.fn.apply null,arguments
    functions.splice 0,1
    next()
    
  if busy?
    # console.log "something is running, waiting till it ends."
  else
    for ____fn,____key in functions
      if ____fn.state is "justAdded"
        # console.log "nothing is running, starting a new one...",fn.args
        do (____fn,____key)->
          ____fn.state = "running"
          ____fn.args.push holaback
          ____fn.fn.apply null,____fn.args
        break
        
serializer = (fn,condition) ->
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

module.exports = serializer
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    