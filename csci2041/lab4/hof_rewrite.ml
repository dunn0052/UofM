(* rewrite each of these function definitions as higher-order functions using the rules in lab4.md *)

<<<<<<< HEAD
let rec append l1 l2 = fun l1 -> match l1 with
=======
let rec append l1 l2 = match l1 with
>>>>>>> 881c89f72921d4108a9b924b49a2f370cb0861e7
  | [] -> l2
  | (h::t) -> h::(append t l2)

let rec take_until lst s = match lst with
  | [] -> []
  | (h::t) -> if h = s then [] else h::(take_until t s)

(* uncomment and fill in:  *)
<<<<<<< HEAD
(* let rec append_hof = fun l1 -> ... *)

(* let rec take_until_hof = fun lst -> *)
=======
let rec append_hof = fun l1 -> match l1 with
| [] -> (fun l2 -> l2)
| (h::t) -> (fun l2 -> h::(append_hof t l2))

let rec take_until_hof = fun lst -> match lst with
| [] -> (fun s -> [])
| (h::t) -> fun s -> if h = s then [] else h::(take_until_hof t s)
>>>>>>> 881c89f72921d4108a9b924b49a2f370cb0861e7
