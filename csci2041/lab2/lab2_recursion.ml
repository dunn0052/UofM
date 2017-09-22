(* Recursion, tail recursion, nested functions.  Unzip takes the first -> n items of each tuple in a list and pairs them up with the corresponding element.
list_cat non-tail recursively concatenates a list of strings together. list_deriv takes a list of integers, subtracts an element from the previous element and returns
the answers as a list of ints  *)

let rec unzip ls =
  let rec helper ls acc1 acc2 = match ls with
|[] -> ((List.rev acc1),(List.rev acc2))
|(h,s)::t -> helper t (h::acc1) (s::acc2) in helper ls [] []

let rec list_cat ls = match ls with
|[] -> ""
|h::t -> h^(list_cat t)

let rec list_deriv ls = match ls with
|[] -> []
|q::[] -> []
|h::t -> let rec helper h t acc = match t with
  |[] -> (List.rev acc)
  |y::z -> helper y z ((y - h)::acc) in helper h t []
