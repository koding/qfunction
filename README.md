# Why Serialize?
      
  In some cases, (for example adding users to linux box) if you try to run your functions in parallel it will fail.
  
  You want to have very simple queue, that will register each incoming function, and execute it one by one.
  
  For example:
  
      # here is an example function that will callback after 1 second.
      
      exampleFunction = (x,callback)-> setTimeout (()-> callback "Finished in 1 sec...with #{x} #{y} #{Date.now()}"),1000
      
      # if you want to run the for loop below, they will approximately finish at the same time
      
      for i in [0..10] 
        exampleFunction i,(r)->
         console.log r
      
      # now you can serialize this function, and it will finish in 10 seconds, running one after another
      
      serializedExampleFunction = serializer exampleFunction

      for i in [10..10]
        serializedExampleFunction i,(r)->
         console.log r

## Installation

    $ npm install serializer