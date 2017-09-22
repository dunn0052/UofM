(* OCaml file for lab 1.
   Fix the errors in this file.  *)

let zero = (-2 + 2)

let myfun x = x
let beginning s = s.[zero]
let len valu = String.length valu

let mult x y = x * y

let or3 a b c = a || b || c

let helloworld = "hello" ^ "world"

let ending s t = let last = len s - 1 in String.sub s (last - t) t

(* let c = beginning "" *)

let () = print_string (ending "Looks like we made it!\n" 9)

let scale i (x,y) = (i*.x,i*.y)

let length (x,y) = sqrt(x*.x +. y*.y)

let unit_vector (x,y) = if length(x,y)=1. then true else false
