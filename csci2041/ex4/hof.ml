let rec drop_until p ls = match ls with
|[] -> []
|h::t -> if (p h) then h::t else drop_until p t

let rec take_while p ls = match ls with
|[] -> []
|h::t -> if (p h) then h::(take_while p t) else []

let rec take_until p ls = match ls with
|[] -> []
|h::t -> if not (p h) then h::(take_until p t) else []
