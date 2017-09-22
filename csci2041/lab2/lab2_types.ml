(* Type inference examples.  These functions are "not polymorphic enough"  *)
(* Don't add or remove lines from this file, it will break gitbot *)

(* Intended type of pairwith:'a ->'b list -> ('a * 'b) list
   Actual type: 'a -> 'b list -> ('a * 'b) list
   Explanation: correct!
 *)
let rec pairwith x lst =
  match lst with
  | [] -> []
  | (h::t) -> (x,h) :: pairwith x t


(* Intended type of has_any:'a -> 'b list -> bool
   Actual type: has type 'a list
   Explanation: Not calling has_any with x t
 *)
let rec has_any x lst =
  match lst with
  | [] -> false
  | (h::t) -> x=h || has_any x t

(* Intended type of lookup: 'a -> ('a*bytes) list -> string
   Actual type:'a -> ('a * bytes) list -> singleton
   Explanation: correct!
 *)
let rec lookup key lst =
  match lst with
  | [] -> print_string "No match"
  | (k,v)::t -> if k=key then v else lookup key t


(* Intended type of reverse : 'a list -> 'a list
   Actual type: Unbound value tail_rev
   Explanation: Forgot to put rec before tail_rev definition
 *)
 let reverse ls =
   let rec tail_rev acc ls =
     match ls with
     | [] -> acc
     | (h::t) -> tail_rev (h::acc) t in tail_rev [] ls
