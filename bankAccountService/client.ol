include "interface.iol"
include "console.iol"

outputPort Bank {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: BankInterface
}

////////////// GET INPUT FROM CONSOLE //////////////
init {
	registerForInput@Console()()
}

main
{
////////////////////// LOGIN ///////////////////////
  request.name="Pippo";
  login@Bank(request)(response);
  opMessage.sid = response.sid;
  println@Console("Your session identifier is: "+opMessage.sid)();

  while(risposta!=0) {
    println@Console("Inserisci:
          0 per uscire,
          1 per prelevare,
          2 per depositare,
          3 per un report")();
    in(risposta);

    if(risposta == 0){
      println@Console("0: Logout")();
      logout@Bank(opMessage)
    }else if (risposta == 1){
      println@Console("1: Prelievo")();
      req.sid=opMessage.sid;
      req.message=2;
      whithdraw@Bank(req)(res);
      println@Console(res)()
    }else if (risposta == 2){
      println@Console("2: Deposito")();
      req.sid=opMessage.sid;
      req.message=5;
      deposit@Bank(req)(res);
      println@Console(res)()
    }else if (risposta == 3) {
      println@Console("3: Report")();
      report@Bank(opMessage)(res);
      println@Console(res)()
    }else
      print@Console("ERROR")()
  }
}