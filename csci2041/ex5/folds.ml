let rank c l = List.fold_left (fun b a -> if a < c then b+1 else b) 0 l

let delta_encode = List.map (fun x y = match x y with |x::[] -> x |x::y::t -> x - y) l
