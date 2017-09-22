(* Recursion, tail recursion, nested functions.  Unzip takes the first -> n items of each tuple in a list and pairs them up with the corresponding element.
list_cat non-tail recursively concatenates a list of strings together. list_deriv takes a list of integers, subtracts an element from the previous element and returns
the answers as a list of ints  *)

(* tuples *)
let (a,b) = (3,4) in a*b
(*int = 12*)

let c,d = 1,2
(*c: int = 1, d: int = 2*)


(* list patterns *)
let (h::t) = [1;2;3]
(*h: int = 1 t: int list = [2; 3] *)

let (x::y::z) = [1;2]
(*Match fail*)

let (_::rest) = [1;2]
(*rest: int list = [2]*)


(* "as" patterns *)
let ((a1,b1) as c1) = (2,3)
(*a1: int = 2, b1: int = 3, c1: int*int = (2, 3) *)

let ((a2,b2) as c2, d2) = ((2,3),4)
(* a2: int = 2, b2: int = 3,. c2: int*int = (2,3), d2: int = 4*)

(* OR patterns *)

(* This or pattern works... *)
let rec make_pairs = function
  | ([] | _::[]) -> []
  | a::b::t -> (a,b) :: make_pairs t
  (* if the list is empty or if there is only one thing then return an empty list
   or if there are at least 2 items in the list then pair the last two items with each
   other in a tuple

  type: 'a list -> ('a * 'b) list*)

(* but this one doesn't.  Why?  Fix it.*)
let rec singleton_or_empty_list = function
  | [] | _::[] -> true
  | _ -> false
(*ocaml wants both sides of the | to have the same set of identifiers
 so that you couldn't compare two different types*)

(* This pattern won't work, due to the *linearity* restriction.  It can be
fixed with "pattern guards" as in Hickey, though that's overkill here. *)
let twins p = match p with
  | (s,t) when s=t -> true
  | (s,t) -> false
