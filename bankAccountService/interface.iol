type LoginRequest: void {
 .name: string
}
type OpMessage: void{
 .sid: string
 .message?: int
}

interface BankInterface {
 RequestResponse: login(LoginRequest)(OpMessage), whithdraw(OpMessage)(int), deposit(OpMessage)(int),report(OpMessage)(int)
 OneWay: logout(OpMessage)
}
