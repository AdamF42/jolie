include "interface.iol"
include "console.iol"

inputPort MyInput {
  Location: "socket://localhost:8000"
  Protocol: soap
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

main {
  ////////////////////// LOGIN ///////////////////////
  login( request )( response ){
    username = request.username;
    password = request.password;
    println@Console("user: " + username + " login")();

    if ( is_defined( global.users.( username ) ) ) {
      println@Console("user: " + username + " found")();
      response.sid = csets.sid = new;
      response.status = "SUCCESS"
    }else{
      println@Console("user: " + username + " not found")();
      response.sid = "";
      response.status = "FAILURE"
    };

    println@Console("USER "+username+" Request: Login")()
  };
  /////////////////// REGISTRATION ///////////////////
  register( request )( response ){
    username = request.username;
    password = request.password;
    println@Console("user: " + username + " registration")();

    if ( !is_defined( global.users.( username ) ) ) {
      println@Console("user: " + username + " not found")();
      global.users.( username ).balance = 0;
      global.users.( username ).password = password;
      response.sid = csets.sid = new;
      response.status = "SUCCESS"
    }else{
      println@Console("user: " + username + " found")();
      response.sid = " ";
      response.status = "FAILURE"
    };

    println@Console("USER "+username+" Request: Registration")()
  };

  while( keepRunning ){

    [ whithdraw( request )( result ) {
      if (global.users.(username).balance >= request.message) {
        result.value=global.users.(username).balance=global.users.(username).balance-request.message;
        result.status="SUCCESS"
      }
      else {
        result.value=global.users.(username).balance;
        result.status="FAILURE"
      };
      println@Console("USER: "+username+" Request: Whithdraw "+request.message )()
    }]

    [ deposit( request )( result ){
      result.value=global.users.(username).balance=global.users.(username).balance+request.message;
      result.status="SUCCESS";
      println@Console("USER: "+username+" Request: Deposit "+request.message )()
    }]

    [ report( request )( result ){
      println@Console( "USER: "+username+" Request: Report")();
      result.value=global.users.(username).balance;
      result.status="SUCCESS"
    }]

    [ logout( request ) ] {
      println@Console("Sid: "+username+" Request: Logout")();
      keepRunning = false
    }

  }

}
