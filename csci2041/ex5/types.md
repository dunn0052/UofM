1. `let rec any p lst = match lst with | [] -> false | x::xs -> (p x) || any p xs`
type: ('a -> bool) -> 'a list -> bool
any has a comparison function first and a list. It then uses the comparison function on each element of the list and returns if it's true or else runs again and eventually puts false

2. `let rec exclude p lst = match lst with | [] -> [] | h::t -> if (p h) then exclude p t else h::(exclude p t)`
type: ('a -> bool) -> 'a list -> 'a list
exclude has a comparison function and checks if an element passes the check it gets added to the list. The resulting list is returned after the initial list is exhausted.

3. `let rec acc2 f res lst1 lst2 = match (lst1,lst2) with | ([],_) | (_,[]) -> res | (h1::t1, h2::t2) -> acc2 f (f res h1 h2) t1 t2`
type: ('a -> 'b -> 'c -> 'a) -> 'a -> 'b list -> 'c list -> 'a
acc2 has a function that takes two lists and checks to see if either of them is empty. If so, then return the second argument. If not, then run the function again using f and res as the function applied to the old res and the heads of each list along with the tails of each respective list.

4. `let rec red f lst init = match lst with | [] -> init | h::t -> f h (red f t init)`
type: ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
red either returns the initial value submitted or else runs the function again with the head of the list using the same f on the head and recursively calls red on the rest of the list. -- returns the last item on the list.
