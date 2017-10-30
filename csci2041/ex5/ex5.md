# Exercise Set 5: List Higher-Order functions

*CSci 2041: Advanced Programming Principles, Fall 2017 (Afternoons)*

**Due:** Monday, October 9 at 11:59am

## 1. Filters and maps

Create a file name `maps_and_filters.ml` in the `ex5` directory to hold your solutions to this problem.  Each problem but the last can be solved by a single call to `List.map` or `List.filter`.

### `fixduck`

Find all instances of `"goose"` in a `string list` and replace them with the right-thinking `"grey duck"`; for any other string but `"duck"`, append `" duck"`. Example evaluations: `fixduck ["duck"; "duck"; "goose"]` should evaluate to `["duck"; "duck"; "grey duck"]` and `fixduck ["purple"; "blue"; "duck"]` should evaluate to `["purple duck"; "blue duck"; "duck"]`. (`fixduck ["gooseduck"]` should evaluate to `["gooseduck duck"]`.)

### `hex_list`

Convert a list of integers into their hexadecimal string representations.  (Note: the most concise way to do this for a single string is with `(Printf.sprintf "%X"))`.)  Examples: `hex_list [10]`  should evaluate to `["A"]` and `hex_list [19; 10; 31137]` should evaluate to `["13"; "A"; "79A1"]`.

### `de_parenthesize`

Remove all `'('` and `')'` chars from a char list. Examples: `de_parenthesize ['('; 'c'; 'a'; 'r'; ' '; '('; 'c'; 'd'; 'r'; ' '; 'l'; ')'; ')']` should evaluate to `['c'; 'a'; 'r'; ' '; 'c'; 'd'; 'r'; ' '; 'l']` and `de_parenthesize [':';'-'; ')']` should evaluate to `[':'; '-']`.

### `p_hack`

Given a list of `float*string` pairs, keep only pairs where the first element is less than `0.05`.  Example evaluations: `p_hack [(0.04, "Red meat vs cancer"); (0.1, "Internet vs cancer")]` should evaluate to `[(0.04, "Red meat vs cancer")]`, and `p_hack [(0.2, "random study"); (0.3, "random study 2"); (0.25, "random study 3"); (0.049, "random study 4")]` should evaluate to `[(0.049, "random study 4")]`.

### `assoc_of_table`

*Challenge* From homework 1.  Use `List.mapi` twice, and `List.flatten` the result.  Same example evaluations given there.

### Test cases

In order to receive full credit for this problem, your solution should agree with the example evaluations on at least 7/12 cases, and the file must not include a single `let rec` declaration.

## 2. Folds and Reductions

Each of the following functions can be implemented by a single call to List.fold_left or List.fold_right.  In a file named `folds.ml`, give implementations of:

### `rank`

`rank : 'a -> 'a list -> int` counts the number of items less than its first argument in its second argument, e.g. `rank 2 [1;3]` should evaluate to `1`, `rank "a" []` should evaluate to `0`, and `rank 3.14 [0.; 1.; 2.71828; 6.022e23]` should evaluate to `3`.

### `prefixes`

`prefixes : 'a list -> 'a list list` should return a list of all prefixes of the input list, e.g. `prefixes [1; 2]` should evaluate to `[[1;2]; [1]; []]`, and `prefixes ["a";"b";"c"]` should evaluate to `[["a"; "b"; "c"]; ["a;b"]; ["a"]; []]`.

### `suffixes`

`suffixes : 'a list  -> 'a list list` should return a list of all suffixes of the input list, e.g. `suffixes [1; 2]` should evaluate to `[[1;2]; [2]; []]`, and `suffixes [["a"]]` should evaluate to `[["a"]; []]`.

### `delta_encode`

The "delta encoding" of a list [a0, a1, a2, ... ] replaces each value other than the first with its difference from the previous value, eg, [a0, a1-a0, a2-a1, ...].  Give a definition of the function `delta_encode : int list -> int list` that returns the delta encoding of a list of integers.  Examples: `delta_encode [32; 34; 29; 33]` should evaluate to `[32; 2; -5; 4]` and `delta_encode [32767; 31337; 32123; 32210]` should evaluate to `[32767; -1430; 786; 87]`.

### Test cases
In order to receive full credit, your solutions to this problem should agree on at least 6/9 of the example evaluations, and should not use any "let rec" bindings.

## 3. Types and uses of higher-order list functions

In your terminal, change directory to the `ex4` directory within your personal class repository, and create a file with the name `types.md` to record your answers to the first part of this problem.  Your solutions to the second part should be recorded in a file called `hoflist.ml`

### Types

Consider the following higher-order functions.  For each function, what is its type?  Explain your answer.


### `any`
```
let rec any p lst = match lst with
| [] -> false
| x::xs -> (p x) || any p xs
```

### `all`
```
let rec exclude p lst = match lst with
| [] -> []
| h::t -> if (p h) then exclude p t else h::(exclude p t)
```

### `acc2`
```
let rec acc2 f res lst1 lst2 = match (lst1,lst2) with
| ([],_) | (_,[]) -> res
| (h1::t1, h2::t2) -> acc2 f (f res h1 h2) t1 t2
```

### `red`
```
let rec red f lst init = match lst with
| [] -> init
| h::t -> f h (red f t init)
```

### Using functions
Each of the following functions can be implemented via a single
call to one of the preceding higher-order functions.  Give the
single-call implementation of each:

+ `mem (x : 'a) (lst : 'a list) : bool` returns `true` if `x` is an
  element of `lst` and `false` otherwise.  Example evaluations: `mem 2 [1;2]` should evaluate to `true`, and `mem "a" []` should evaluate to `false`.

+ `implode : char list -> string` takes a list of characters and
  squashes them into a string.  (Note: `String.make 1 c` makes a
  single-character string out of character `c`)  Example evaluations: `implode ['a'; ' '; 'f'; 'i'; 'n'; 'e'; ' '; 'm'; 'e'; 's'; 's']` should evaluate to `"a fine mess"`.

+ `dot : float list -> float list -> float` computes the dot product
  of its arguments.  Example evaluation: `dot [1.;2.;3.] [4.;5.;6.]` should evaluate to `32.`

+ `onlySomes : 'a option list -> 'a option list` removes all of the
  `None` variants from a list of `'a option` values.  `onlySomes [Some 1; None]` should evaluate to `[Some 1]` and `onlySomes []` should evaluate to `[]`.

### Test cases

For each higher order function in part 1, is the type correct, and is there an explanation?  (8 tests).  For each implementation in part 2, does it call one of the functions in part 1 (4 tests)? Is it correct on the given examples (6 tests)?

Your solution must pass 12/18 test cases to get full credit for this problem.
