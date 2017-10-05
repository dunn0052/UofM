# Exercise Set 4: Functions as values

*CSci 2041: Advanced Programming Principles, Fall 2017 (Afternoons)*

**Due:** Monday, October 2 at 11:59am

## 1. Types and evaluation, again

In your terminal, change directory to the `ex4` directory within your personal class repository, and create a file with the name `evaluations.md` to record your answers to
this problem.  Remember to run `git add evaluations.md` before you commit.

For each of the following expressions, indicate whether OCaml will consider the
expression legal or not.  If it is not a legal expression, explain what the
problem is; otherwise, present its type and explain why this is the correct type.  Assume there are no bindings
preceding these expressions, that is, treat each expression as an independent
OCaml program.

1. `let x = 17 in let f () = x in let x = "nested" in f`

2. `let rec funny = fun x -> funny (x+1) in funny`

3. `let (<<|) f g = fun x -> g (f x) in  int_of_string <<|  string_of_int`

4. `let s f g = fun x -> (f x) (g x) in s`

5. `let rec red f x y = match x with
  | [] -> y
  | x'::xs -> f x' (red f xs y) in red`

6. `let c f g = fun x -> if (f x) then true else (g x) in c ((=) 10)`

7. `let swap f x y = f y x in swap (^) "!"`

8. `fun f g -> function [] -> [] | h::t -> (f h)::(g t)`

Your solution file should include each numbered expression, followed by the Legal/Not legal decision, followed by one or more lines of "reasoning", as follows:

```
1. `3 - 2 + 4`
Legal
type: int
reason: because (+) has type int->int->int and is applied to (3-2) and 4, and 4 has type int, and (-) has type int->int->int and is applied to 3 and 2 which have type int, producing an int.

2. `3.14 * 6 * 6`
Not legal
The * operator has type int -> int -> int but 3.14 has type float
```

### Test cases
+ One for each expression above: correct Legal/Not legal label, correct type label and one or more non-empty lines of explanation. (8 cases)

Your solution must pass 6/8 test cases to get full credit for this problem.

## 2. Functions and arguments

Create a file name `hof.ml` in the `ex4` directory to hold your solutions to this problem.

### `drop_until`

Provide a definition for the function `drop_until : ('a -> bool) -> ('a list) -> ('a list)` which drops elements from the beginning of a list that do not make its first argument true.  Some example evaluations:

+ `drop_until (fun _ -> true) []` should evaluate to `[]`.

+ `drop_until (fun _ -> true) [1]` should evaluate to `[1]`

+ `drop_until (fun s -> s.[0]='a') ["boring"; "as"; "always"]` should evaluate to `["as"; "always"]`

### `take_while`

Provide a definition for the function `take_while : ('a -> bool) -> 'a list -> 'a list` that returns the prefix list of its second argument such that all elements satisfy its first argument.  Some example evaluations:

+ `take_while (fun _ -> true) [1; 2; 3]` should evaluate to `[1; 2; 3]`.

+ `take_while ((=) "a") ["a"; "a"; "b"; "a"]` should evaluate to `["a"; "a"]`.

+ `take_while (fun _ -> false) ["say"; "anything"]` should evaluate to `[]`

### `take_until`

Provide a definition for the function `take_while : ('a -> bool) -> 'a list -> 'a list` that returns the prefix list of its second argument such that all elements do not satisfy its first argument.  Some example evaluations:

+ `take_until (fun _ -> false) [1; 2; 3]` should evaluate to `[1; 2; 3]`.

+ `take_until ((!=) "a") ["a"; "a"; "b"; "a"]` should evaluate to `["a"; "a"]`.

+ `take_until (fun _ -> true) ["say"; "anything"]` should evaluate to `[]`


### Test cases

In order to receive full credit for this problem, your solution should agree with the example evaluations on at least 6/9 cases.

## 3. Implementing sets as functions

In class, we discussed implementing sets of elements as lists.  This problem considers an alternative implementation:

```
type 'a set = 'a -> bool
```

In this implementation, a `'a set` returns `true` if its argument belongs to the set, and `false` otherwise, so we would implement `mem` as `let mem x s = (s x)`, `empty` as `let empty _ = false`, and `add` as `let add x s = fun y -> (y=x) || (s y)`.  These definitions appear in `ex4/funset.ml`; copy it to the `ex4` directory in your personal repo and add your solutions to the following problems.

### `union`

Add a definition for the function `union : 'a set -> 'a set -> 'a set`, where `x` is in `union s1 s2` if `x` is in `s1` or `x` is in s2.  Some example evaluations:

+ `mem 3 (union empty empty)` should evaluate to `false`

+ `mem 3 (union (add 3 empty) (add 5 empty))` should evaluate to `true`

### `intersect`

Add a definition for the function `intersect : 'a set -> 'a set -> 'a set` so that `x` is in `intersect s1 s2` if and only if `x` is in `s1` and `x` is in `s2`.  Some example evaluations:

+ `mem 0 (intersect empty (add 0 empty))` should evaluate to `false`, since `0` is not an element of the empty set.

+ `let s = (add 0 empty) in mem 0 (intersect s (add 1 s))` should evaluate to `true`.

### `rem`

Add a definition for the function `rem : 'a -> 'a set -> 'a set`, which removes an element from a set.  Some example evaluations:

+ `mem 0 (rem 0 (add 0 empty))` should evaluate to `false`

+ `mem "a" (rem "b" (add "a" empty))` should evaluate to `true`

### `setminus`

The set `setminus s1 s2` is the set of all elements that are elements of `s1` but not of `s2`.  Add an implementation of `setminus`.  Some example evaluations:

+ `mem 0 (setminus empty (add 0 empty))` should evaluate to `false`

+ `mem 0 (setminus (add 0 empty) empty)` should evaluate to `true`

+ `mem 1 (setminus empty empty)` should evaluate to `false`

+ `mem 1 (setminus (add 1 empty) (add 1 (add 0 empty)))` should evaluate to `false`.

### `range`

One advantage of the functional representation of sets is that we can represent very large sets efficiently.  Write an implementation for the function `range : 'a  -> 'a -> 'a set`, that returns a set of all the elements that are at least its first argument and at most its second argument.  Some example evaluations:

+ `mem 4 (range 4 max_int)` should evaluate to `true`

+ `mem 3 (range 4 max_int)` should evaluate to `false`

+ `mem 0.5 (range 0. 1.)` should evaluate to `true`

+ `mem 2. (range 0. 1.)` should evaluate to `false`

+ `mem "aa" (range "a" "b")` should evaluate to `true`

+ `mem "aa" (range "b" "c")` should evaluate to `false`

### `subset`

What would be the problem in implementing the function `subset : 'a set -> 'a set -> bool` for this implementation of sets?  No test cases, just think about the difficulty.


Your solution must pass at least 8/15 test cases to get full credit for this problem.
