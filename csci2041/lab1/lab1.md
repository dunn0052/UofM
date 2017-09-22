# Lab 1: Debugging and Writing simple OCaml Programs

*CSci 2041: Advanced Programming Principles, Fall 2017 (afternoon)*

**Due:** Thursday, September 14 at 11:59pm.


## Ground rules

You may work in a group of up to three students on this lab.  Although labs are meant to
be an open and collaborative environment, it is the responsibility of
all group members to contribute to learning the materials in every lab.
In particular, all members are responsible for ensuring that submissions are
received by the due date, and for letting us know if one teammate does
not participate in a given lab.  If you choose to work in a group you must complete the lab work in a group repository, which you can create at the start of the lab period by following [these instructions](group-instructions.md).

# Introduction: Goals for this lab

+ Learn some common OCaml errors and how to fix them

+ Write a few simple OCaml functions

# Interacting with an OCaml program

At the start of the lab, cd to the public lab repository and do a `git pull` to
make sure you have the latest lab materials.  You should find a new directory
there named `lab1`, and inside that directory will be a file named `lab1.ml`.
Copy the directory and file to your group or personal repository, and remember
to do a `git add` on both.

In this class, a typical method of developing and debugging OCaml programs will involve three windows or tabs:

+ You will write code in a text editor; several commonly used editors (e.g. emacs, gedit, atom)
  understand OCaml syntax and support syntax highlighting to help format your code.
  Open `lab1.ml` in your text editor of choice.

+ A terminal window with a shell in the directory where your code
  resigns.  You can build and run the program from the shell using the
  command `ocamlc`.  To try building an executable for the program in `lab1.ml`, type
  ```
  % ocamlc -o lab1 lab1.ml
  ```
  at the shell prompt now.  The compiler will fail, since the program has
  several deliberate bugs; we'll get to these a bit more in a moment.

+ An ocaml top-level shell.  OCaml has a top-level
  Read-Evaluate-Print-Loop (REPL) shell that is included by default as
  `ocaml`, or we can use the nicer `utop` REPL, which provides
  name-completion and syntax highlighting, but otherwise functions in
  the same way as `ocaml`.  To load a file in `utop`, we first start
  utop in a terminal window:
  ```
  % utop
  ```
  Then at the `utop` shell prompt, we can load a file using the `#use`
  _directive_.  A _directive_ is a command given to the REPL shell
  that is not a valid part of an OCaml program: we'll never type
  `#use` in a `.ml` file.  To attempt to compile and test out
  `lab1.ml` in `utop`, type the following at the `utop` prompt:
  ```
  utop # #use "lab1.ml" ;;
  ```
  `utop` will attempt to compile lab1.ml and will also print out an
  error message.   (The `;;` delimiter is also a command to the REPL,
  telling it to read and evaluate whatever you've typed so far.  It
  should also never be used in a `.ml` file).

# Debugging some errors

Now that we've got our programming environment set up, with the
editor, terminal and REPL loop, let's go back and look at what
`ocamlc` told us when we tried to compile `lab1.ml`.  In that
terminal window, you should see the error message:
```
File "lab1.ml", line 4, characters 17-18:
Error: Syntax error: operator expected.
```
Back in your editor, find the 4th line:
```
let zero = (-2 + )
```
We see that immediately before characters 16 and 17 there is a `+` but
there is no argument to `+`.  This is a syntax error, because there's
no way to read this as a valid expression (to _parse_ the line).  You
should fix this error by supplying a second argument to `+` that will
bind the name `zero` to the expected value.

If we try to build the program again using `ocamlc -o lab1 lab1.ml`, we'll
see a new error message.  This is progress! But we're not done yet:
```
File "lab1.ml", line 6, characters 4-7:
Error: Syntax error
```
Go back and find line 6 in the text editor window.  It might look like
this line is OK as a let expression: it defines a function that
returns its argument.  The problem here is that `fun` is an OCaml
keyword and can't be used as a variable name.  (Similarly, `function`
is also a keyword and can't be used.)  Choosing a new name for the
function, e.g. `myfun` or `fn` will fix this error; go ahead and do
this.

Building again, you'll find another Syntax Error on the next line.
See if you can figure out from looking at the line in your text editor
what the problem is.  (Fixing this problem will also require changing
another line later in the program.)  Another very similar syntax error
appears on line 8.  You can again fix it by changing the name of a
variable, although this time the variable is an argument.

Once these syntax errors are cleared up, if you build again, you'll
see the error message:
```
File "lab1.ml", line 10, characters 17-18:
Error: Unbound value y
```
Find line 10 in the editor: can you see the problem?

The compiler is telling us that the let declaration on line 10 defines
a function, `mult`, which references the name `y`, but `y` has not
been bound (defined) before. Looking at the definition of `mult`, we
see that only one variable name appears on the left of the `=` sign,
but two names are used on the right.  If we add `y` to the list of
arguments, this error should go away; try it now.

The next compiler error looks very similar:
```
File "lab1.ml", line 12, characters 16-17:
Error: Unbound value x
```
Look at line 12 and see if you can fix the problem.

Moving on, we get an interesting error:
```
File "lab1.ml", line 14, characters 17-24:
Error: This expression has type string but an expression was expected of type
         int
```
Look at line 14; characters 17-24 are the string literal `"hello"`.
Why does OCaml "expect" an expression of type `int` here?  This is
because we're trying to give `"hello"` as an argument to the operator
`+`, which only operates on `int`s.  This is what's called a _type
error_, because we're calling a function or operator with an argument
whose expression evaluates to a different type than the one expected
by the callee.

What causes an error like this?  Well, either we're passing the wrong
arguments to the operator `+`, or, we're using the wrong operator.
Since it looks like this line of code is trying to concatenate the
arguments, we probably meant to call the string concatenation
operator, `^`.  Change this in the code and see what happens next.

If we now try to build the code, we get what looks like another type
error:
```
File "lab1.ml", line 16, characters 41-58:
Error: This expression has type int -> string
       but an expression was expected of type int
```
Looking at line 16, it seems that we are trying to take the last `t`
characters from the string `s`, by calling `String.sub` with the
arguments `s`, `last - t` and `t`.  But the compiler is complaining
about the "expression" `String.sub s last`.  What's going on?

The problem is that infix operators have a higher lower precedence
than function application, so instead of thinking we want to pass
`last - t` as an argument to `String.sub s`, the compiler thinks we
meant to pass `String.sub s last` as an argument to `-`.  We can fix
this with parentheses around `last - t` in order to clear up what the
arguments are to `-`.  Do this and try to build the file again.

Hey!  we made it!  Let's execute the program and see what happens.  At
the terminal shell prompt, type:
```
% ./lab1
```
You should see:
```
Fatal error: exception Invalid_argument("index out of bounds")
```
Uh oh.  Now what?  This is an example of a _run-time error_, a program
bug that happens when we encounter conditions that the compiler can't
predict before hand.  What's going wrong here?  Let's switch to the
`utop` top-level shell and try to compile and evaluate `lab1.ml`:
```
utop # #use "lab1.ml" ;;
val zero : int = 0
val fn : 'a -> 'a = <fun>
val beginning : string -> char = <fun>                                                                                                                                                                             
val len : string -> int = <fun>
val mult : int -> int -> int = <fun>
val or3 : bool -> bool -> bool -> bool = <fun>
val helloworld : string = "helloworld"
val ending : string -> int -> string = <fun>
Exception: Invalid_argument "index out of bounds".
```
It looks like the run-time error is happening after we evaluate the
let declaration binding `ending`.  If we look in the text editor, the
next expression is:
```
let c = beginning ""
```
What's going on here?  The type of `beginning` is `string -> char`,
and we're calling it with `""`, a string; so there's not a type error
or a syntax error here.  If we look at the definition of `beginning`,
we see that `beginning s` returns `s.[0]`, that is, it tries to return
the character at index `0` of its argument.  Since the argument here
is the empty string, `""`, it doesn't have a character at index 0,
resulting in the `index out of bounds` exception.  We'll learn later
how to handle exceptions; for now you can go ahead and "fix" this
problem by commenting out the offending expression.  Build and run the
program one last time, and declare victory!

# Writing new OCaml Functions

Now that we're experienced at understanding error messages, let's wrap
up by writing a few functions that deal with 2-dimensional vectors,
represented as pairs of `float`s.  (As a reminder, a 2-dimensional
vector is basically just an (x,y) point in space: its length is its
distance from the origin - (0,0)) With your partner, go back to
`lab1.ml` in the text editor and try writing OCaml definitions for the
following functions:

+ `scale : float -> float * float -> float * float` Scalar
  multiplication of a vector by a real number simply multiplies both
  components by the scalar, e.g., `scale 3. (1., 2.)` should
  evaluate to `(3., 6.)` and `scale 2. (-1.,4.)` should evaluate to
  `(-2.,8.)`.

+ `length : float * float -> float`: The length of a vector (a,b) is
  the square root of a * a  + b * b, so `length (3.,4.)` should
  evaluate to `5.` and `length (5.,12.)` should evaluate to `13.`.
  (There is an OCaml function, `sqrt : float -> float`, that computes
  the square root of a floating-point number.)

+ `unit_vector : float * float -> bool`: A vector is a *unit vector*
  if its length is 1.  So `unit_vector (0.0,1.0)` should evaluate to
  `true`, `unit_vector (1.5,2.7)` should evalute to `false`,
  `unit_vector (0.6,0.8)` should evalute to `true`, and `unit_vector
  (0.,0.5)` should evaluate to `false`.

# Commit and push so that everything is up on GitHub

Now you need to just turn in your work.
Commit your changes and push them up to your central
GitHub repository.

Verify that this worked, by using your browser to see the changes on
https://github.umn.edu.

If you do not properly push your changes to the repository we
cannot give you credit for the lab, so please remember to do this
step!

__This concludes lab 1.__

**Due:** Thursday, September 14 at 11:59pm.

Note that any required changes must exist in your repository on
github.umn.edu. Doing the work but failing to push those changes
to your central repository will mean that we cannot see your work
and hence can't grade it.
