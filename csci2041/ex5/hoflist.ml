(* hoflist.ml - definitions first: *)
let rec any p lst = match lst with
| [] -> false
| x::xs -> (p x) || any p xs

let rec exclude p lst = match lst with
| [] -> []
| h::t -> if (p h) then exclude p t else h::(exclude p t)

let rec acc2 f res lst1 lst2 = match (lst1,lst2) with
| ([],_) | (_,[]) -> res
| (h1::t1, h2::t2) -> acc2 f (f res h1 h2) t1 t2

let rec red f lst init = match lst with
| [] -> init
| h::t -> f h (red f t init)

(* your answers go here: no let recs! *)

let mem (x : 'a) (lst : 'a list) = any (fun x -> List.mem x lst) lst

let implode lst = []

 let dot lst1 lst2 = acc2 (fun x y z -> x +. (y *. z )) 0. lst1 lst2

let onlySomes lst = exclude (fun x -> x = None) lst
