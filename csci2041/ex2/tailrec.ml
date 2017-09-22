(* tailrec.ml - exercise set 2, CSci 2041a, Fall 2017 *)
(* Kevin Dunn *)

(* Fix this: it has bugs and must be tail recursive... *)
let rec msort ls =
if ls = [] then [] else
  let rec split lst (l1,l2) = match lst with
    | [] -> (l1,l2)
    | h::t -> split t (l2,h::l1) in
  let rec merge l1 l2 = match (l1,l2) with
    | (_,[]) -> l1
    | ([],_) -> l2
    | (h1::t1,h2::t2) -> if h1 < h2
    then
      h1::(merge t1 l2)
    else
      h2::(merge l1 t2) in
  let (l1,l2) = split ls ([],[]) in merge (msort l1) (msort l2)

(* Fill in tail recursive range *)
let range m n = if m >= n then [] else
   let rec loop accum m n =
      if m >= n then
         List.rev accum
       else
         loop (m::accum) (m + 1) n
   in
      loop [] m n



(* *@ operator *)
let ( *@ ) m n = if m < 1 then [] else
   let rec loop accum m n =
      if m = 0 then
         List.flatten accum
       else
         loop (n::accum) (m -1) n
   in
      loop [] m n
