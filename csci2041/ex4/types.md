1. `let x = 17 in let f () = x in let x = "nested" in f`
type: unit -> int
x is set to 17 initially so f sends out type int

2. `let rec funny = fun x -> funny (x+1) in funny`
type: int -> 'a
funny has polymorphic type originally, but the is turned to int via (x+1)

3. `let (<<|) f g = fun x -> g (f x) in int_of_string <<| string_of_int`
type: bytes -> bytes
<<| nests x into f into g into <<|


4. `let s f g = fun x -> (f x) (g x) in s`
type: ('a -> 'b -> 'c) -> ('a -> 'b) -> 'a -> 'c
s takes 2 function arguments and each of those take a different argument

5. `let rec red f x y = match x with | [] -> y | x'::xs -> f x' (red f xs y) in red`
type: ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
red takes in a function f list x and y and then either matches x with empty or calls f with the head of x and recursively call red with f, the tail of x and y again

6. `let c f g = fun x -> if (f x) then true else (g x) in c ((=) 10)``
type: (int -> bool) -> int -> bool
c takes comparator f and g. If f x is true then true else return what g x says

7. `let swap f x y = f y x in swap (^) "!"``
type: bytes -> bytes
swap changes (^) and "!" values

8. `fun f g -> function [] -> [] | h::t -> (f h)::(g t)``
type: ('a -> 'b) -> ('a list -> 'b list) -> 'a list -> 'b list
f takes function g that takes a list and either returns and the empty list or adds f of the head of the list to the output of g to the tail of the list
