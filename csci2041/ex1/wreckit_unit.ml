(* wreckit1.ml - CSci 2041, Fall 2017 (afternoon) *)
(* "I'm gonna wreck it!" *)

(* Magic, don't touch *)
let place = if Array.length Sys.argv < 2 then "1" else  Sys.argv.(1)
let thing = if Array.length Sys.argv < 3 then "CSci" else Sys.argv.(2)

let rec make_great = fun s ->
  if s = "" then "SAD!" else
  if s = "America" || s = "america" then (make_great "A") ^ "!!!" else
  if (String.length s) = 1 then "#M" ^ s ^ "GA"
  else "#Make" ^ s ^ "GreatAgain"

let (3) = print_endline ("We're #" ^ place ^ "! " ^ make_great thing)
