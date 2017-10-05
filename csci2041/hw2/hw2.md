# Homework 2: Expression parsing and evaluating

*CSci 2041: Advanced Programming Principles, Fall 2017 (afternoon section)*

**Due:** Wednesday, October 4 at 11:59pm

In the `hw2041-f17a/hw2` directory, you will find a files named `boolExpr.ml` and `satwith.ml`.
Create a directory named `hw2` in your personal repository, and copy both of these files
to your `hw2` directory.  Don't forget to run `git add` on both the directory and
the files!

## Background: Boolean Expressions, Lexing, and Parsing

Boolean expressions are a fundamental computational tool, used in everything
from databases to software testing, security, datacenter scheduling, and
operation planning.  A boolean expression consists of boolean operations (like
"and", "or", "not", "=", "xor") applied to boolean constants (True or False) and
variables that can take on boolean values.  If we set all of the variables in a
boolean expression to either true or false, we can evaluate the resulting
expression; if the evaluation is true, we say that the setting *satisfies* the
expression.  An expression is *satisfiable* if there is some setting of the
variables that satisfies the expression.  Finding a satisfying setting of the
variables is a hard problem and many large companies have "logistics"
departments that specialize in trying to satisfy huge boolean expressions, for
instance to find a feasible schedule for a major league sports season, or the
best place to build a new UPS distribution center.

n order to process expressions, we first have to obtain them from input, and we
often do this from strings (either stored in files, or entered into a program
some other way).  In this question, we'll write code to convert strings that
represent prefix-form boolean expressions into data structures representing
these expressions, evaluate these expressions, and search for satisfying
assignments.  Here are some examples of these expressions: `"(and (or (not (and
x y)) y) (and z F))"`, `"(or (and x (and y z)) (or (not z) (and x (not y))))"`.
(such prefix-form expressions are often called *S-expressions*)

### Lexing
Reading structures like expressions or programs is usually
separated into two phases, _lexing_ and _parsing_.  In _lexing_, a
string is converted into a list of *tokens*, which are the important
lexical components of a program.  Here, the important components are:

+ Opening and Closing parentheses, `(` and `)`.

+ Operator keywords, like `and`, `or`, and `not`

+ Constants, `T` and `F`

+ Variables, which could be named by strings like `x`, `y`, or `z_boolean_variable_blah_blah`.

### Parsing

In _parsing_, a list of tokens is converted to a structured
representation of an expression, often called an "abstract syntax
tree."  In order to do this, we need to define the syntax of
expressions and the abstract representation.  We do so inductively, as
follows.  A boolean expression is either:

+ a constant,or

+ a variable, or

+ An operation applied to one or two expressions, appearing in the input token sequence as, for instance, `OPEN NAND <expr1> <expr2> CLOSE`

When parsing a sequence of tokens into a syntax tree, we will often need to read sub-expressions from the sequence, and keep track of the remaining tokens after this sub-expression, e.g. after parsing the `<expr1>` above we'll need to know the remaining sequence of tokens to parse `<expr2>`, and after that we'll need to know whether there was a closing parenthesis to check if the entire expression was well-formed.  

### Evaluating

Once we have a syntax tree for a boolean expression, evaluating it is pretty straightforward: to evaluate a constant, just check if it's true or false; to evaluate an operation applied to two sub expressions, first evaluate the two sub expressions and then apply the appropriate logical operation, and to evaluate a variable, we just need some method of specifying which variables are set to true and which are set to false.  In this homework, we'll just use a list of variable names that represents all of the true variables; any variable that doesn't appear on the list is then set to false.  

If we then want to find a setting that satisfies an expression, we can just try taking all of the subsets of the list of variables in the expression, and evaluating the expression with each possible subset set to true.  If there are `n` variables, this will involve testing `2**n` possible subsets.  Interestingly, while the best known algorithms for testing satisfiability are usually much faster than this, in the worst case they can also wind up testing an exponentially large number of variable settings.

## Homework 2: `formula`

Open `boolExpr.ml` in your favorite text editor, and you'll see that there's some
implementation in the file already:

+ `read_lines` reads a file from standard input and returns a list of strings, one for each line in the file.

+ `wordlist` takes a string and splits it by word boundaries and parentheses.

+ `is_varname` checks if a string starts with a lower-case letter and is a string of alphanumeric characters.  This is the criterion we'll use for valid variable names in our boolean expressions

+ the type `bexp_token` represents the lexical tokens we care about in our boolean s-expressions.  It's incomplete right now, because the provided program only implements the `NAND` boolean operation.

+ `token_of_string` converts a string into a `bexp_token`.

+ `tokens` converts a list of strings into a list of tokens

+ the type `boolExpr` is an inductive type representing boolean expressions.  It's also incomplete, since it only implements the `nand` operation.

+ `parse_bool_exp` attempts to read a complete boolean expression from a list of tokens.  It fails with an Invalid_argument exception if the list of tokens doesn't form a syntactically valid boolean s-expression.

+ `bool_exp_of_s_exp` pipelines the wordlist through parsing functions to convert a string into a boolean expression.

+ `eval_bool_exp` evaluates a boolean expression `bexp`, assuming the variables in the list `tru` are set to `true` and any other variables in the formula are set to `false`.

There's one more function fully implemented in `boolExpr.ml`, which is `main`.  This function handles the flow of work currently done by the tool:

+ Read the formula as a string from stdin

+ Concatenate the lines into a single string

+ Process the string through the parsing pipeline

+ Evaluate the resulting formula

+ Print a message to standard output saying what the result was.

A separate file, `formula.ml` contains code to read the command-line arguments (the list of variables to set to `true`) and call the `main` function in `boolExpr.ml`.

The files as given will compile (with `ocamlc -o formula str.cma boolExpr.ml formula.ml`) and evaluate boolean s-expressions that consist only of `NAND` operations, constants, and variables.  For this assignment, you will be enhancing the functionality of the tool, as follows:

### 1. `bexp_token` and `token_of_string`

You will be augmenting the tool to support several additional boolean operations: "and", "or", "not", "xor", and "=".  In order to do this, you'll need to modify the `bexp_token` type to include variants for each of these operations: `AND`, `OR`, `NOT`, `XOR`, and `EQ`, and modify `token_of_string` to support converting from the string to the token representation of each. Some example evaluations:

+ `token_of_string "and"` should evaluate to `AND`

+ `token_of_string "or"` should evaluate to `OR`

+ `token_of_string "not"` should evaluate to `NOT`

+ `token_of_string "xor"` should evaluate to `XOR`

+ `token_of_string "="` should evaluate to `EQ`


### 2. `boolExpr` and `parse_bool_exp`

Once we can lex the additional tokens, we'll need to add support for these operations to the `boolExpr` type.  Add variants `And`, `Or`, `Not`, `Xor`, and `Eq` to `boolExpr`.  A `Not` variant should hold a single `boolExpr`, while the rest should hold a pair of `boolExpr` values.  Once you've modified the type to accommodate these kinds of expressions, you can modify `parse_bool_exp` to parse them from a list of tokens. Some example evaluations:

+ `parse_bool_exp [OP; AND; OP; OR; CONST true; CONST false; CP; OP; NOT; CONST false; CP; CP]` should evaluate to `And (Or (Const true, Const false), Not (Const false))`

+ `parse_bool_exp [OP; EQ; OP; XOR; VAR "x"; VAR "y"; CP; CONST false; CP]` should evaluate to `Eq (Xor (Id "x", Id "y"), Const false)`

The `bool_exp_of_s_exp` pipeline should naturally fail for strings that are not syntactically valid boolean s-expressions, for example:

+ `"and T F"` would be ill-formed because of the lack of parentheses;
+ `"(and T F"` would be ill-formed becuse of the lack of closing
parenthesis;
+ `"(and T)"` and `"(or T F T)"` would be ill-formed due to the
wrong number of arguments.
+ `"(and or T)"` would be ill-formed because the first argument to `and`
is not a valid expression.
+  `"(not T))"` would be ill-formed because of the extra closing paren;
+ `"T F"` would be ill-formed because it represents more than one
expression.


### 3. `eval_bool_exp`

Once we can represent the new boolean operations as `boolExpr`s, we'll need to modify `eval_bool_exp` to evaluate them correctly.  Some sample evaluations:

+ `eval_bool_exp (Not (Const false)) []` should evaluate to `true`

+ `eval_bool_exp (Eq (Const false, Const true)) []` should evaluate to `false`

+ `eval_bool_exp (Xor (Const false, Const true)) []` should evaluate to `true`

+ `eval_bool_exp (And (Const false, Or (Id "y", Const true))) []` should evaluate to `false`

### 4. `subsets`

Besides adding to the set of boolean operations supported by `formula`, we are also going to add a second functionality: trying to find a satisfying assignment to the variables in a formula.  One important function we'll need to do that is `subsets : 'a list -> 'a list list` which should take a list of items and return all possible subsets of that list.  So for example

+ `subsets []` should evaluate to `[[]]`, because the empty set is a subset of any set.

+ `subsets [1]` should evaluate to (a permutation of) `[[1]; []]`

+ `subsets ["a";"b"]` should evaluate to (a permutation of) `[["a";"b"]; ["a"]; ["b"]; []]`

Hint: if `s` is a subset of `t` then it is also a subset of `h::t`, and so is `h::s`.  Solutions to this problem that use less stack space will be worth more points.

### 5. `var_list`

Another important function needed to find satisfying assignments is the function `var_list : boolExpr -> string list` which should produce a list of all of the variable identifiers that appear in a boolean expression; each identifier should appear only once.  Some example evaluations:

+ `var_list (Id "avar")` should evaluate to `["avar"]`

+ `var_list (Const true)` should evaluate to `[]`

+ `var_list (And (Id "avar", Id "avar"))` should evaluate to `["avar"]`

+ `var_list (And (Id "var1", Or (Id "var2", Const false)))` should evaluate to (a permutation of) `["var1"; "var2"]`.

### 6. `find_sat_set`

Given the two previous functions, we can write the function `find_sat_set : boolExpr -> string list option` which should return `Some` string list if it finds a subset of variables that can be set to true to satisfy the expression, or `None` if there is no such subset.  Some example evaluations:

+ `find_sat_set (Const false)` should evaluate to `None`

+ `find_sat_set (Const true)` should evaluate to `Some []`

+ `find_sat_set (Or (Id "x", Const false))` should evaluate to `Some ["x"]`

In general, if `find_sat_set bexp` evaluates to `Some t` then `eval_bool_exp bexp t` should evaluate to `true`.

### 7. `sat_main` and `formula.ml`

When we run our tool with the `find_sat_set` mode, we'll need a different `main` function to handle reading the input formula, parsing it, passing the expression to `find_sat_set`, and printing the result to standard output.  Fill in the `sat_main : unit -> unit` function so that if the input boolean s-expression is satisfiable, the tool prints `"Satisfied when the variables {x1, x3} are set to true."` (or whichever set of variables is found by `find_sat_set`) and if the formula is not satisfied by any setting of variables, the tool prints `"Not satisfiable"`.  Then modify the command-line portion of `formula.ml` so that it calls `BoolExpr.sat_main ()` when we run the tool as `formula --findsat`.

## Other considerations

In addition to satisfying the functional specifications given above, your code should be readable, with comments that explain what you're trying to accomplish.  It must compile with `ocamlc -c str.cma boolExpr.ml formula.ml`.  It must be committed in the `hw2` directory of your personal repository.  Finally, solutions that pay careful attention to resources like running time and stack space (e.g. using tail recursion wherever feasible) and code reuse are worth more than solutions that do not have these properties.
