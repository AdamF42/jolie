type SumRequest:void {
  .x:int
  .y:int
}

// Avrei anche potuto scriverlo così
// type SumRequest:void {
//  arr[2,2]:int
// }

type Numbers:void {
  // bisogna evitare di gestire array con 0 perchè schioppa
  // la divisionec (.array*:int)
  // nell'interfaccia va definito il controllo sui tipi
  .array1:int
}

interface MyInterface {
  RequestResponse: sum(SumRequest)(int),
  prod(SumRequest)(int),
  avg(Numbers)(int)
  OneWay: close(int)
}
