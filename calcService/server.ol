include "interface.iol"
include "console.iol"

inputPort MyInput {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: MyInterface
}

init
{
  println@Console( "Server ON" )()
}

main
{
  open=true;
  while(open){

    [sum( num )( result ){
      result.value=num.x+num.y;
      println@Console( num.x + " + " + num.y + " = " + result.value )()
    }]

    [prod( num )( result ){
      result.value=num.x*num.y;
      println@Console( num.x + " * " + num.y + " = " + result.value )()
    }]

    [avg( num )( result ){
      i = 0;
      sum = 0;
      numbersToSum="";
      while( i < #num.array ) {
        sum = sum + num.array[i];
        if (i==0) { numbersToSum = num.array[i] }
        else { numbersToSum = numbersToSum + ", "+ num.array[i] };
        i++
      };
      result.value=sum/#num.array;
      println@Console( "AVG[ " + numbersToSum + " ] = " + result.value)()
    }]

    [close(msg)]{
      open=false;
      println@Console( "Server OFF" )()
    }

  }
}
