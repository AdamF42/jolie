include "interface.iol"
include "console.iol"

outputPort Bank {
  Location: "socket://localhost:8000"
  Protocol: soap
  Interfaces: BankInterface
}

////////////// GET INPUT FROM CONSOLE //////////////
init {
	registerForInput@Console()()
}

main {
////////////////////// LOGIN ///////////////////////
  println@Console("Insert your username")();
  in(username);
  println@Console("Insert your password")();
  in(password);
  request.username=username;
  request.password=password;
  login@Bank(request)(response);
  mySid = response.sid;
  println@Console("Your session identifier is: " + mySid)();

  ////////////// SERVICE OPERATIONS ///////////////
  while(userSelection!=0) {
    println@Console("Select an operation:
          0 to logout,
          1 to withdraw,
          2 to deposit,
          3 to get the balance")();
    in(userSelection);

    if(userSelection == 0){
      println@Console("0: Logout")();
      req.sid=mySid;
      logout@Bank(req)
    }
    else if (userSelection == 1){
      println@Console("1: Withdraw => Insert amount")();
      in(amount);
      req.sid=mySid;
      req.message=int(amount);
      whithdraw@Bank(req)(res);
      if (res.status=="FAILURE") {println@Console("ERROR: Insufficient credit")()}
    }
    else if (userSelection == 2){
      println@Console("2: Deposit => Insert amount")();
      in(amount);
      req.sid=mySid;
      req.message=int(amount);
      deposit@Bank(req)(res)
    }
    else if (userSelection == 3) {
      req.sid=mySid;
      report@Bank(req)(res);
      println@Console("3: Balance => " + res.value)()
    }
    else
      print@Console("ERROR: Invalid input")()
  }
}
