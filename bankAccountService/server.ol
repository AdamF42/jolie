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
      global.users.( request.name ) = 0
    };
    println@Console("USER "+request.name+" Request: Login")()
  };

  while( keepRunning ){

    [ whithdraw( request )( result ) {
      if (global.users.(username)>=request.message) {
        result.value=global.users.(username)=global.users.(username)-request.message;
        result.status="SUCCESS"
      }
      else {
        result.value=global.users.(username);
        result.status="FAILURE"
      };
      println@Console("USER: "+username+" Request: Whithdraw "+request.message )()
    }]

    [ deposit( request )( result ){
      result.value=global.users.(username)=global.users.(username)+request.message;
      result.status="SUCCESS";
      println@Console("USER: "+username+" Request: Deposit "+request.message )()
    }]

    [ report( request )( result ){
      println@Console( "USER: "+username+" Request: Report")();
      result.value=global.users.(username);
      result.status="SUCCESS"
    }]

    [ logout( request ) ] {
      println@Console("Sid: "+username+" Request: Logout")();
      keepRunning = false
    }

  }

}
