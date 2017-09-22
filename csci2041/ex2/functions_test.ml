let ( ++ ) x y =
if x + y > 32767 then
  32767
else if x + y < -32768 then
  -32768
else x + y


let vec_add (a, b) (c, d) = (a+.c,b+.d)
let dot (a, b) (c, d) = a*.c+.b*.d
let perp (a, b) (c, d) = if dot (a, b) (c, d) = 0.0 then true else false

let rec range m n =
if m < n then
  m::range (m + 1) n
else
  m::[]


let rec sum_positive = function
| [] -> 0
| x::xs -> if x < 0 then
  sum_positive xs
else
  (x + sum_positive xs)

  (* Fix this definition *)
let rec take m lst = match (m,lst) with
| (_,[]) -> []
| (0,_) -> []
| (n,h::t) -> h::(take (n-1) t)
