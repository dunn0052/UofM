(* picky function to truncate to places decimals *)
let float_trunc places s =
  let mul = 10. ** (float_of_int places) in
  (floor (s *. mul)) /. mul

let to_meters l = List.map (fun x -> match x with |(a ,  b) -> (float_trunc 2 (float_of_int(a)*.0.3048 +. float_of_int(b)*.0.3048/.12.0))) l

let rot13 s = ""

let wite_out ls = []
