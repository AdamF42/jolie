include "interface.iol"

inputPort MyInput {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: MyInterface
}

main
{
  sendNumber( x )( x )
}
