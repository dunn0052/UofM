(* picky function to truncate to places decimals *)
let float_trunc places s =
  let mul = 10. ** (float_of_int places) in
  (floor (s *. mul)) /. mul

let to_meters l = []

let rot13 s = ""

let wite_out ls = []
