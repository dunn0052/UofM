(* rewrite each of these function definitions as higher-order functions using the rules in lab4.md *)

let rec append l1 l2 = fun l1 -> match l1 with
  | [] -> l2
  | (h::t) -> h::(append t l2)

let rec take_until lst s = match lst with
  | [] -> []
  | (h::t) -> if h = s then [] else h::(take_until t s)

(* uncomment and fill in:  *)
(* let rec append_hof = fun l1 -> ... *)

(* let rec take_until_hof = fun lst -> *)
