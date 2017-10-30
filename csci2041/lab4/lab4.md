# Lab 4: Higher-order functions and maps

*CSci 2041: Advanced Programming Principles, Fall 2015*

**Due:** Thursday, October 5 at 11:59pm.


## Ground rules

You may choose to work alone or with a partner on this lab. If you choose to work in a group, follow these [group instructions](group-instructions.md) to set up a group repository, and use that repository to store your work in this lab.

Although labs are meant to be an open and collaborative environment, it is the
responsibility of both partners to contribute to learning the materials in every
lab. In particular, all partners are responsible for ensuring that submissions
are received by the due date.

As will be the case for all labs this semester, your work should appear in a directory called `lab4` of your personal or group repository.  The easiest way to accomplish this is to do a `git pull` in the public `labs2041-f17a` repository to get the lab files, then do a recursive copy to copy the entire `lab4` folder into the destination repository:

```
% cd ~/csci2041/labs2041-f17a
% git pull
% cd ..
% cp -R labs2041-f17a/lab3 repo-dest1234/
% cd repo-dest1234/
% git add lab3
```

# Introduction: Goals for this lab

+ Apply your knowledge of the OCaml type system to practice re-writing
  multi-argument functions as higher-order functions.

+ Practice using the `map` pattern and its relatives to compute iterative functions.


## 1. Rewriting higher-order functions

Recall that every definition and use of a multiple argument function
is actually an instance of a higher-order function, because:

+ The notation `fun x y z -> expr` is equivalent to `fun x -> fun y -> fun z -> expr`; and

+ The notation `f x y z` is equivalent to `let f1 = (f x) in let f2 = (f1 y) in (f2 z)`.

Furthermore, if we apply the above transformations to some OCaml code
using multiple argument functions, we'll find we can often perform
some or most of the evaluation before returning a function, using the
rules:

+ The expression `fun x -> if b then e1 else e2` is equivalent to `if b then (fun x -> e1) else (fun x -> e2)` if `x` is not used in `b`.

+ The expression `fun x -> let y = e1 in e2` is equivalent to `let y = e1 in fun x -> e2` if `x` is not used in `e1`.

+ The expression `fun x -> match e with | p1 -> e1 | p2 -> e2 | ... |
  pn -> en` is equivalent to `match e with | p1 -> (fun x -> e1) |
  ... pn -> (fun x -> en)` if `x` is not used in `e` or any of the
  patterns `p1`...`pn`.

+ `let` expressions can be reordered if the values do not depend on
  the names bound in them, e.g. `let n1 = e1 in let n2=e2 in e3` is
  equivalent to `let n2 = e2 in let n1 = e1 in e3` if `e1` does not
  contain `n2` and `e2` does not contain `n1`. Similarly, a `let` that
  appears as a case in a conditional can be "lifted" outside the
  conditional if neither the other branches nor the condition have a
  conflicting binding.

In this problem, we'll apply these rules to some familiar functions to
get more practice with seeing, writing, and using higher-order
functions.  As an example, consider the function `zip : 'a list -> 'b
list -> ('a * 'b) list`:

```
let rec zip l1 l2 =
  match l1 with
  | [] -> []
  | (h::t) -> match l2 with
              | [] -> []
              | (h'::t') -> (h,h') :: (zip t t')
```

(Notice this is the "truncating" version of `zip`.)  We first remove the `let` sugar to get:

```
let rec zip = fun l1 -> fun l2 ->
  match l1 with
  | [] -> []
  | (h::t) -> match l2 with
              | [] -> []
              | (h'::t') -> (h,h') :: (zip t t')
```

Next, since the first matched expression doesn't depend on l2, we
rewrite as:

```
let rec zip = fun l1 ->
  match l1 with
  | [] -> fun l2 -> []
  | (h::t) -> fun l2 -> match l2 with
              | [] -> []
              | (h'::t') -> (h,h') :: (zip t t')
```

Next we rewrite `(zip t t')`:

```
let rec zip = fun l1 ->
  match l1 with
  | [] -> fun l2 -> []
  | (h::t) -> fun l2 -> match l2 with
              | [] -> []
              | (h'::t') -> (h,h') :: (let zip1 = (zip t) in zip1 t')
```

And we can "lift" the let binding outside of the `match l2`:

And finally, we can push the `fun l2 ->` inside this let expression,
since `l2` doesn't appear in `let zip1 = (zip t)`:

```
let rec zip = fun l1 ->
  match l1 with
  | [] -> fun l2 -> []
  | (h::t) -> let zip1 = (zip t) in
        fun l2 -> match l2 with
              | [] -> []
              | (h'::t') -> (h,h') :: (zip1 t')
```

The file `hof_rewrite.ml` contains two other familiar list functions, `append` and `take_until`. Show the process of applying these rules to each of them to produce
rewritten versions, `append_hof`, and `take_until_hof` that highlight their use of higher-order functions.

## 2. `map` and its friends

In class, we saw the higher-order function `map : ('a -> 'b) -> 'a list -> 'b list` (included in the OCaml standard libary as `List.map`), that can be used to apply a transformation to every element of a list.  OCaml also includes the function `String.map : (char -> char) -> string -> string` which can be used to apply some transformation to every character of a string, and `List.mapi : (int -> 'a -> b) -> 'a list -> 'b list` in which the function to be applied to each list element is also given the index of the element in the list.  Let's practice using these functions to write non-recursive definitions in the file `maps_r_us.ml`.

### `to_meters`

Fill in the definition of a function `to_meters : (int*int) list -> float list` that takes a list of measurements in "imperial" units (feet, inches) and converts each measurement to meters, truncated to 2 decimal places.  (Some relevant information : 12 inches = 1 foot = 0.3048 meters)  So for example `to_meters [(6,0); (5,8)]` should evaluate to `[1.82; 1.72]`.  

### `rot13`

The "rot13" "encryption" algorithm takes every alphabetical character in a string and "rotates" it 13 characters forward, wrapping around after `'z'`. Non-alphabetic characters are left unchanged.  So for example, `rot13 "a happy string"` should evaluate to `"n unccl fgevat"`, and `rot13 "pizza"` should evaluate to `"cvmmn"`. Give an implementation of `rot13` using no recursion.  Some helpful things to note: `int_of_char` and `char_of_int` convert between characters and their integer (ASCII) representations; OCaml supports ranges of characters in patterns using `..`, so for instance the pattern `'a'..'z'` matches all lowercase alphabetic characters and `'A'..'Z'` matches all uppercase characters.

### `wite_out`

"Wite-out" or "Liquid Paper" are products that could be used to cover over mistakes made when producing a paper document with ink.  Applying "wite-out" to a mistaken word would leave a blank space on the page.  Let's write a function `wite_out : string list -> i -> string_list` which "wites out" the `i`-th word in a list of strings, by replacing it with a string of spaces with the same length, so for example `wite_out ["your"; "my"; "bad"] 0` would evaluate to `["    "; "my"; "bad"]` and `wite_out ["win"; "1"; "10"] 1` would evaluate to `["win"; " "; "10"]`.  Use only non-recursive bindings, e.g. no `let rec`!

# Commit and push so that everything is up on GitHub

Now you need to just turn in your work.
Commit your changes and push them up to your central
GitHub repository.

Verify that this worked, by using your browser to see the changes on
https://github.umn.edu.  Your (group or personal) repository should have both the
files `lab4/hof_rewrite.ml` and `lab4/maps.ml`.

If you do not properly push your changes to the repository we
cannot give you credit for the lab, so please remember to do this
step!

__This concludes lab 4.__

**Due:** Thursday, October 5 at 11:59pm.

Note that any required changes must exist in your repository on
github.umn.edu. Doing the work but failing to push those changes
to your central repository will mean that we cannot see your work
and hence can't grade it.
