serializer = require "./index"

exampleFunction = (x,callback)-> setTimeout (()-> callback "Finished in 1 sec...with #{x} #{Date.now()}"),1000

# if you want to run all in parallel, they will approximately finish at the same time

for i in [0..10] 
  exampleFunction i,(r)->
   console.log "regular function out:",r

# now you can serialize this function, and it will finish in 10 seconds, running one after another

serializedExampleFunction = serializer exampleFunction

for i in [0..10]
  serializedExampleFunction i,(r)->
   console.log "queued function out:",r