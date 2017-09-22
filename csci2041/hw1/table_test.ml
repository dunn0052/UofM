
let rec helper h lst  acc= match lst with
|[] -> acc
|(x,y,z)::t -> if x = h then helper h t (z::acc) else helper h t acc


let rec helper h lst  acc= match lst with
|[] -> acc
|(x,y,z)::t -> if x = h then helper h t (z::acc) else helper h t acc
