type Obj:void {
  .name: string
}

type Price:void {
  .euro: double
}

type Order:void {
  .obj: Obj
  .price: Price
}

type Details:void {
  .obj: Obj
  .price: Price
}

type Confirmation:void {
    .status: string
}

interface BSInterface {
  RequestResponse: checkPrice(Obj)(Price),
  sendMoney(Order)
  OneWay: sendItem()
}

interface SHInterface {
  RequestResponse: sendMoney(Order)
}

interface SHInterface {
  RequestResponse: help(Details)(Confirmation)
}
