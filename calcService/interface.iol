type SumRequest:void {
  .x:int
  .y:int
}

type ProdRequest:void {
  .x:int
  .y:int
}

type Numbers:void {
  .array[1,*]:int
}

type Int:void {
  .value:int
}

interface MyInterface {
  RequestResponse: sum(SumRequest)(Int),
  prod(ProdRequest)(Int),
  avg(Numbers)(Int)
  OneWay: close(Int)
}
