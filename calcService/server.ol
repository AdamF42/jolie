include "interface.iol"
include "console.iol"

inputPort MyInput {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: MyInterface
}

main
{
  open=true;
  while(open){
    //input choice per poter rendere le chiamate indipendeti dall'ordine di chiamata
    [sum( num )( result ){
      println@Console( num.x+" "+num.y )();
      result=num.x+num.y
    }]

    [prod( num )( result ){
      println@Console( num.x+" "+num.y )();
      result=num.x*num.y;
      println@Console( result )();
      x=num
    }]

    [avg( num )( result ){
      i = 0;
      sum = 0;
      while( i < #num.array ) {
        sum = sum + num.array[i];
        i++
      };
      result=sum/#num.array
    }]

    [close(msg)]{
      open=false
    }
  }
}
