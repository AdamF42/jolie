include "interface.iol"
include "console.iol"

inputPort MyInput {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: BankInterface
}

execution{ concurrent }

cset {
 sid:
  OpMessage.sid
}

init
{
  println@Console("Server ON")()
}

main
{

  [ login( request )( response ){
    // create new userid
    response.sid = csets.sid = new;
    // init user's bankAccount
    global.user.(response.sid) = 0;
    println@Console("User "+request.name+" Sid: "+csets.sid+" Op: Login")()
   }]



 [ whithdraw( request )( result ){
   // println@Console(request.message)();
   // username = global.username.(sid);

   global.user.(request.sid)=global.user.(request.sid)-request.message;
   result=global.user.(request.sid);
   println@Console("Sid: "+request.sid+" OP: Whithdraw "+request.message )()
 }]

 [ deposit( num )( result ){
   println@Console("User "+username+" Sid: "+csets.sid+" Op: Deposit "+num )();
   money=money+num;
   result=money
 }]

 [ report( num )( result ){
   println@Console( "User "+username+" Sid: "+csets.sid+" Op: Report "+num )();
   result=money
 }]

 [ logout( request ) ]
  {
    username = request.sid;
    println@Console("User "+username+" Sid: "+csets.sid+" Op: Logout")();
    keepRunning = false
  }
}
