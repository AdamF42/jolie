type LoginRequest: void {
 .name: string
}
type OpMessage: void{
 .sid: string
 // .message?: string
}
interface BankInterface {
 RequestResponse: login(LoginRequest)(OpMessage), whithdraw(int)(int)
 OneWay: print(OpMessage), logout(OpMessage)
}
