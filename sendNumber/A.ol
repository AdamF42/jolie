include "interface.iol"
include "console.iol"

outputPort B {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: MyInterface
}

main
{
  sendNumber@B( 5 )( response );
  println@Console( response )()
}
