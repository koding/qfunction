# Why Queued Function?
      
  In some cases, (for example adding users to linux box) if you try to run your functions in parallel it will fail. And you need very lightweight queue functionality without adding any complexity to your project.
  
  You want to have very simple queue, that will register each incoming function, and execute it one by one.
  
  For example:
  
      qfunction = require "qfunction"
      
      # here is an example function that will callback after 1 second.

			exampleFunction = (x,callback)-> setTimeout (()-> callback "Finished in 1 sec...with #{x} #{Date.now()}"),1000

      # if you run the for-loop below, they will approximately all finish at the same time

			for i in [0..10] 
			  exampleFunction i,(r)->
			   console.log "regular function out:",r

		# now you can create a queued version of this function, and it will finish in 10 seconds, running one after another

		queuedExampleFunction = qfunction exampleFunction

		for i in [0..10]
		  queuedExampleFunction i,(r)->
		   console.log "queued function out:",r


## Installation

    $ npm install qfunction
    
## To do

    - Queue can be persisted to a db (right now, pending functions will die if node process dies)
    - Functions that don't have a callback can be serialized (however, i don't know why those need to be serialized)