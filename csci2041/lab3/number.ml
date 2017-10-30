type number = Integer of int | Real of float
let z1 = Integer 420
let z2 = Integer 17
let r1 = Real 1.0
let r2 = Real 2.3

let to_int (n: number) = match n with
| Integer i -> Some i
| _ -> None

let to_float (n: number) = match n with
| Real x -> Some x
| _ -> None

let float_of_number (n: number) = match n with
| Integer i -> float_of_int i
| Real x -> x

let (+?) (x: number) (y: number) = match x,y with
| Integer i, Integer w -> Integer (i+w)
| Real r, Real y -> Real (r+.y)
| Real q, Integer e -> Real (q+.(float_of_number (Integer e)))
| Integer p, Real l -> Real ((float_of_number (Integer p))+.l)
