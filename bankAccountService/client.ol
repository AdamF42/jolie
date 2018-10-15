include "interface.iol"
include "console.iol"

outputPort Bank {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: BankInterface
}


main
{
  request.name="gino";
login@Bank(request)(response);
 opMessage.sid = response.sid;
 println@Console(opMessage.sid)()

}
