# Exercise Set 3: User-Defined types in OCaml

*CSci 2041: Advanced Programming Principles, Fall 2017 (Afternoons)*

**Due:** Monday, September 25 at 11:59am

## 1. Records and enumerated unions: Card Games

The file `ex3/cards.ml` contains some syntax to help get started on this problem.  Copy it to an `ex3` directory in your personal repository to get started with them.

## Card Games

A "standard" card deck consists of 52 cards, each suit (Hearts, Clubs, Spades, Diamonds) having thirteen cards (2 through 10, Jack, Queen, King, Ace).  The file `cards.ml` contains incomplete definitions for three types: `card_suit`, `card_value`, and `card` (a record with suit and value fields.)  It also has incomplete definitions for functions to convert string representations of cards, like `"KD"` for Jack of Diamonds, into values of type `card`. (We're too lazy to look up how to represent a diamond, heart, club, or spade as a unicode character in OCaml.  If you want, you can add `unicode_string_of_card` and `card_of_unicode_string` functions to handle these fancier string representations.)

### `card_suit`, `card_value`, `string_of_card`, `card_of_string`

Complete the definitions of the `card_suit` and `card_value` types, along with the `card_of_string` and `string_of_card` functions.  Your definitions should allow comparisons between values of type `card_value` so that, for example, `Two < Five` and `Three < Queen` evaluate to true.  Some sample evaluations:

+ `let s : card_suit = Spades` should compile without errors

+ `let v : card_value = Jack` should compile without errors

+ `let c4c = { value = Four; suit = Clubs }` should compile without errors

+ `let cqd = { value = Queen; suit = Diamonds }` should compile without errors

+ `card_of_string "10D"` should evaluate to the record `{ value = Ten; suit = Diamonds }`

+ `string_of_card (card_of_string "9H")` should evaluate to `"9H"`


### `trick_winner`

Many card games involve play in "tricks" (eg. Spades, Hearts, Bridge, Whist), in which a player leads with a card, and other players also lay out cards, of the same suit if possible.  Once all players have played cards, the highest card of the same suit as the lead card "wins" or "takes" the "trick."  (and typically becomes the leader for the next trick.)  In `cards.ml` there is a prototype for the function `trick_winner : card list -> card` which should return the value of the winning `card` from a list of `card` values, assuming the cards were played in the order given.  (Assuming there are no "trump" cards, and Aces are "high".)  Fill in the definition for this function.  Some sample evaluations:

+ `trick_winner [ {value = Two; suit = Hearts}; {value = King; suit = Spades } ]` should evaluate to `{ value = Two; suit = Hearts }` because the lead suit was Hearts.

+ `trick_winner [ {value = Two; suit = Hearts}; {value = King; suit = Hearts } ]` should evaluate to `{ value = King; suit = Hearts }` because the King had the same suit as the lead card.

+ `trick_winner []` should raise an exception with `invalid_arg "empty trick"` because there can't be a winner in a trick with no cards.

### Test cases

To get full credit for this section, your solution should produce correct results on at least 8/9 sample evaluations.

## 2. Disjoint unions

### TLD of hostinfo

In lecture, we defined a type `hostinfo` that is either a 4-byte "IP
address" (like `(134,84,159,182)`) or a string-valued "DNS name" (like
`"www.myu.umn.edu"`):

```
type hostinfo = IP of int * int * int * int | DNSName of string
```
We've conveniently placed this type definition in the file
`ex3/hostinfo.ml`.

An important property of a DNS name is the _top level domain_ - the
string after the last `'.'` character. For example the top-level
domain (or TLD) of "www.myu.umn.edu" is "edu", the TLD of
"www.google.com" is "com", and the TLD of "cs2041.org" is "org".
In `hostinfo.ml`, add the OCaml definition for the function `tld : hostinfo -> string
option`, which returns the TLD of a hostinfo value that is a DNS
name, and `None` if its argument is an IP address.   Some example
evaluations:

+ `tld (IP (8,8,8,8))` evaluates to `None` because its argument is an
IP value.
+ `tld (DNSName "cnn.com")` evaluates to `Some "com"`
+ `tld (DNSName "comcast.net")` evaluates to `Some "net"`

Hint: you might find the functions `String.sub` and `String.rindex` in the
[`String` module](http://caml.inria.fr/pub/docs/manual-ocaml/libref/String.html)
to be useful here.

### Card_option: Trump cards

The file `Card_option.ml` contains the start of a similar set of types to represent playing cards as in the first problem: here we'll represent a card value as either `Simple of int`, or one of the "Face cards".  Here we'll extend the problem of determining the winner of a trick to consider the idea of "trump cards."  When a trick is played with a trump suit, the winner is the highest card of the lead suit, if no cards of the trump suit are played, or the highest card of the trump suit, if at least one such trump card is played.  

Fill in the definition of `trick_winner_trump : card list -> card_suit option -> card`, which can determine the winner of a trick when there is no trump suit (the second parameter is `None`) or when there is a trump suit (the second parameter is `Some s`).  Some sample evaluations:

+ `trick_winner_trump [{value = Simple 9; suit = Hearts}] (Some Diamonds)` should evaluate to `{value = Simple 9; suit = Hearts}`

+ `trick_winner_trump [{value = Simple 9; suit = Hearts}; {value = Simple 2; suit = Diamonds}] (Some Diamonds)` should evaluate to `{value = Simple 2; suit = Diamonds}`

+ `trick_winner_trump [{value = Simple 9; suit = Hearts}; {value = Simple 2; suit = Diamonds}] None` should evaluate to `{value = Simple 9; suit = Hearts}`

+ `trick_winner_trump [{value = Simple 9; suit = Hearts}; {value = Ace; suit = Hearts}] None` should evaluate to `{value = Ace; suit = Hearts}`

### Test cases

In order to receive full credit for this section, your solutions should produce correct results on 5/7 example evaluations.

## 3. Recursive Types

### Documents

An example of computing objects that have a hierarchical structure is
HTML documents; an HTML document in general is structured as a
sequence of HTML _entities_, (for example, anchors (links), text,
headings, lists, images, tables, frames...) many of which may enclose
more HTML entities.  In the file `ex3/document.ml`, you'll find definitions
for a type representing a small subset of HTML:

```
type entity =
        Title of entity list
        | Heading of entity list
        | Text of string
        | Anchor of anchor
and anchor = Named of string * (entity list) | HRef of string * (entity list)

type document = { head : entity list ; body : entity list }
```

Notice that the types `anchor` and `entity` are _mutually recursive_:
an `entity` might include an `anchor` as one of its elements and every
`anchor` includes an `entity list`.

#### Extending with Lists
Extend the definition of the `entity` type to include two further variants:

+ `List` - a List has a list type, `Unordered`, or `Ordered`, and a list of sub-entities.

+ `ListItem` - a `ListItem` holds an entity list as well, and should only occur
while nested inside a `List`.

Modify the example `document`, `d2`, in the place indicated to include a list of the
indicated elements.

You'll also need to update the function `check_rules` that checks that the
`head` of a document contains no `Anchor`s,  the `body` of a document contains
no `Title`s, `anchor`s do not include nested `anchor`s, and no `ListItem`s occur
outside of a `List`.

Test cases for this portion of the problem:

+ `let d : entity = (List (Ordered,[]))` compiles successfully.

+ `check_rules { head = d1.head ; body = [(List (Ordered, [ListItem []]))] }` evaluates to `True`

+ `check_rules d_err1` evaluates to `False`

+ `check_rules { head = d1.head; body = d1.body @ [(ListItem [(Text "ok")])]}` evaluates to `False` since the `ListItem` is not nested inside a `List` entity.

#### Computing with Documents
Once you've extended `entity` with `List`s, you should also add the
following functions that compute on documents:

+ `find_headings : document -> entity list` returns a list of all the
  `Heading` entities in the body of a document.  Example evaluations:
  `find_headings d1` should evaluate to
  `[Heading [(Text "CS 2041 Document")] ]` and `find_headings d_err1`
  should evaluate to `[]`.

+ `extract_text: document -> string` Should extract and concatenate
  together (separated by single spaces) the contents of all `Text`
  variants appearing in the body of its argument.  Example evaluation:
  `extract_text d1` should evaluate to `"CS 2041 Document A short
  document A little more stuff Click this to go back"`.

### Binary Search trees

Binary trees are a fundamental data structure in computer science, which you
will have seen in CSci 1933 or its equivalent.  A _binary search tree_ is an
extension of a binary tree that allows for efficient search and insertion of
elements, by enforcing the requirement that the value stored at each internal
node is greater than or equal to all elements in its left subtree, and less than
or equal to all elements in its right subtree.  You'll find the type definition
and function definitions for `insert` and `search` in the file `ex3/btrees.ml`,
and you should add your code for this problem to the same program.

+ Complete the function `tree_min : 'a btree -> 'a option` that finds the
smallest element in a binary tree (BST or not).  Example evaluations: `tree_min
Empty` should evaluate to `None`; `tree_min t3` should evaluate to `Some 3`

+ Complete the function `tree_max : 'a btree -> 'a option` which finds the
largest element in a binary tree (BST or not). Example evaluations: `tree_max
Empty` should evalute to `None`; `tree_min t5` should evaluate to `Some 12`.

+ Now fix the function `is_bstree : 'a bstree -> bool` that checks that its
argument satisfies the binary search tree condition.  Example evaluations:
`is_bstree Empty` should evaluate to `true`, `is_bstree Node(0,Empty,Leaf 1)`
should evaluate to `true`, `is_bstree Node(0,Leaf 1,Empty)` should evaluate to
`false`, and `is_bstree t3` should evaluate to `false`.

### Grading Criteria

In order to receive full credit for this section, your solution should prodœuce the correct result on at least 12/18 example evaluations.
