1. fun s -> match s with (x,[]) -> x | (_,h::t) -> h
legal
type 'a
puts 'a if empty list or the first element of the list if it is not empty

2. let rec drip n x = match (n,x) with (0,_) -> [] | (h,t) -> drip (h-1,t) in drip
not legal
This expression has type 'a * 'b but an expression was expected of type int

3. match [3] with h::t -> t::5
not legal
This expression has type int but an expression was expected of type               int list list
4. [1; 17; [1;3]]
not legal
list has both integers and a list of integers

5. [[]; ["hi"]; [":)"; ":("; "(o:)3"]]
legal
list of list of strings

6. let rec odds ls = match ls with [] -> [] | h::[] -> [h] | h::_::t -> h::(odds t) in odds [1;2;4;8]
legal
value: [1; 4]
