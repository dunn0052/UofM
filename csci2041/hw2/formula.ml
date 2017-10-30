(* formula.ml - command line driver for hw2 boolExpr *)
(*added the --findsat arguement to use sat_main*)
let arglist = Array.to_list Sys.argv in match arglist with
| _::"--eval"::t -> BoolExpr.main t
|_::"--findsat"::t -> BoolExpr.sat_main ()
| _::t -> BoolExpr.main t
| _ -> failwith "there's always at least one argument."
