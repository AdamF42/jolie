include "interface.iol"
include "console.iol"

outputPort B {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: MyInterface
}

main
{
  operand.x=2;
  operand.y=3;
  sum@B( operand )( response );
  println@Console( response )();

  num.array[0]=4;
  num.array[1]=8;
  num.array[2]=2;
  avg@B( num )( response );
  println@Console( response )();

  prod@B( operand )( response );
  println@Console( response )();

  close@B(1)
}
