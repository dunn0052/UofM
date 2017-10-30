let rec map f lst =
  match lst with
  | [] -> []
  | h::t -> (f h)::(map f t)

(* fold_left in Ocaml *)
let rec fold f acc lst =
  match lst with
  | [] -> acc
  | h::t -> fold f (f acc h) t

(* fold_right in Ocaml *)
let rec reduce f lst init =
  match lst with
  | [] -> init
  | h::t -> f h (reduce f t init)

(* list functions from map,fold, and reduce *)

(* takes the elements off the head of the second list and cons onto the second list *)
let append l1 l2 = reduce (fun x l -> x::l) l1 l2

let filter pred lst = reduce (fun x l -> if pred x then x::l else l) lst []

let list_cat = fold (fun x s -> x^s ) ""

let list_fst = map (fun x -> match x with |(a,_) -> a)

let mem x ls = reduce (fun x b -> x || b ) (map (fun h -> x = h) ls) false

let count_intersection lst1 lst2 = fold (fun x l -> if (mem l lst1) then x+1 else x) 0 lst2
