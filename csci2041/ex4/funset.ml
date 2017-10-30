(* funset.ml -- function representation of sets *)

(* an 'a set returns true if an element belongs to it *)
type 'a set = 'a -> bool

(* no element belongs to the empty set *)
let empty : 'a set = fun _ -> false

(* membership testing is straightforward *)
let mem x (s: 'a set) = s x

(* adding an element: test for x, otherwise return what s says *)
let add x (s: 'a set) : 'a set = fun y -> (y=x) || (s y)

let rem x (s: 'a set) : 'a set = fun y -> not (y=x) ||  not (s y)

let union (s1: 'a set) (s2: 'a set) = fun x -> if s1 x || s2 x then true else false

let intersect (s1: 'a set) (s2: 'a set) = fun x -> if s1 x && s2 x then true else false

let setminus (s1: 'a set) (s2: 'a set) = fun x -> if s1 x && not (s2 x) then true else false
