let fixduck l = List.map (function "goose" -> "grey duck" |"duck" -> "duck" |x -> x^" duck") l

let hex_list l = List.map (function x -> String.uppercase((Printf.sprintf "%x") x)) l

let de_parenthesize l = List.filter (function '(' | ')'-> false | _ -> true) l

let p_hack l = List.filter (function (x, y) -> if x < 0.05 then true else false) l
