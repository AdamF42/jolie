type LoginRequest: void {
 .name: string
}
type OpMessage: void {
 .sid: string
 .message?: int
}
type OpReturn: void {
  .value: int
  .status: string
}

interface BankInterface {
 RequestResponse: login(LoginRequest)(OpMessage), whithdraw(OpMessage)(OpReturn), deposit(OpMessage)(OpReturn),report(OpMessage)(OpReturn)
 OneWay: logout(OpMessage)
}
