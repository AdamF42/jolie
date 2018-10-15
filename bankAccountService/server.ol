include "interface.iol"
include "console.iol"

inputPort MyInput {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: BankInterface
}

cset {
 sid: OpMessage.sid
}
main
{
[login( request )( response ){
 username = request.name;
 response.sid = csets.sid = new

 }]

 [whithdraw( num )( result ){
   println@Console( num.x+" "+num.y )();
   result=num.x+num.y
 }]

 [whithdraw( num )( result ){
   println@Console( num.x+" "+num.y )();
   result=num.x+num.y
 }]
}
