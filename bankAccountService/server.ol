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
  keepRunning = true;
  println@Console("Server ON")()
}

main
{
  ////////////////////// LOGIN ///////////////////////
  login( request )( response ){
    // create new userid
    response.sid = csets.sid = new;
    username = request.name;
    // init user's bankAccount if it does not exist
    if ( !is_defined( global.users.( request.name ) ) ) {
      global.users.(request.name) = 0
    };
    println@Console("USER "+request.name+" Request: Login")()
  };

  while( keepRunning ){

    [ whithdraw( request )( result ){
      global.user.username=global.user.username-request.message;
      result=global.user.username;
      println@Console("Sid: "+username+" OP: Whithdraw "+request.message )()
    }]

    [ deposit( request )( result ){
      global.user.username=global.user.username+request.message;
      result=global.user.(username);
      println@Console("Sid: "+username+" Op: Deposit "+request.message )()
    }]

    [ report( request )( result ){
      println@Console( "Sid: "+username+" Op: Report")();
      result=global.user.username
    }]

    [ logout( request ) ] {
      println@Console("Sid: "+username+" Op: Logout")();
      keepRunning = false
    }

  }

}
