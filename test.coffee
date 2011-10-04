serializer = require "./serialize"

userAdd = (x,y,callback)-> setTimeout (()-> callback null,"res:#{Date.now()} called with #{x} and #{y}"),1000

chris = (x,y,callback)->
 setTimeout ()->
  callback "im finished in 2 secs...with #{x} #{y} #{Date.now()}"
 ,2000


serializedUseradd = serializer userAdd

sChris = serializer chris


for i in [50..60]
  sChris i,i+1,(r)->
   console.log r