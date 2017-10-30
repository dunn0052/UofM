(* read std input to eof, return list of lines *)
let read_lines () : string list =
  let rec read_help acc =
    try read_help ((read_line ())::acc) with End_of_file -> List.rev acc
  in read_help []

(* split a string at word boundaries and parens *)
let wordlist s : string list =
  let splitlist = Str.full_split (Str.regexp "\\b\\|(\\|)") s in
  let rec filter_splist lst = match lst with
    | [] -> []
    | (Str.Delim "(")::t -> "(" :: (filter_splist t)
    | (Str.Delim ")")::t -> ")" :: (filter_splist t)
    | (Str.Delim _) :: t -> filter_splist t
    | (Str.Text s) :: t -> let s' = String.trim s in
			   let t' = (filter_splist t) in
			   if not (s' = "") then s' :: t' else t'
  in filter_splist splitlist

(* is s a legal variable name? *)
let is_varname s =
  let rec checker i =
    if i = 0 then
      'a' <= s.[i] && s.[i] <= 'z'
    else
      (('a' <= s.[i] && s.[i] <= 'z') ||
  	   ('0' <= s.[i] && s.[i] <= '9')) && checker (i-1)
  in checker ((String.length s) - 1)

(* tokens - added all of the requested tokens *)
type bexp_token = OP | CP | AND | OR | NOT | XOR | EQ | NAND | CONST of bool | VAR of string

(* convert a string into a token *)
let token_of_string = function
  | "(" -> OP
  | ")" -> CP
  | "and" -> AND
  | "or" -> OR
  | "not" -> NOT
  | "xor" -> XOR
  | "=" -> EQ
  | "nand" -> NAND
  | "T" -> CONST true
  | "F" -> CONST false
  | s -> if (is_varname s) then (VAR s) else (invalid_arg ("Unknown Token: "^s))

(* convert a list of strings into a a list of tokens *)
let tokens wl : bexp_token list = List.map token_of_string wl

(* type representing a boolean expression, you need to add variants here *)
type boolExpr =
| Const of bool
| Id of string
| Nand of boolExpr * boolExpr
| And of boolExpr * boolExpr
| Or of boolExpr * boolExpr
| Not of boolExpr
| Xor of boolExpr * boolExpr
| Eq of boolExpr * boolExpr

(* attempt to turn a list of tokens into a boolean expression tree.
A token list representing a boolean expression is either
 + a CONST token :: <more tokens> or
 + a VAR token :: <more tokens> or
 + an OPEN PAREN token :: a NAND token :: <a token list representing a boolean expression> @
                                          <a token list representing a boolen expression> @ a CLOSE PAREN token :: <more tokens>
 any other list is syntactically incorrect. *)
let parse_bool_exp tok_list =
(* when possibly parsing a sub-expression, return the first legal expression read
   and the list of remaining tokens  *)
(* I added in the rest of the expressions*)
  let rec parser tlist = match tlist with
    | (CONST b)::t -> (Const b, t)
    | (VAR s)::t -> (Id s, t)
    | OP::NAND::t -> let (a1, t1) = parser t in
                    let (a2, t2) = parser t1 in
                    (match t2 with
                     | CP::t' -> ((Nand (a1,a2)), t')
		                 | _ -> invalid_arg "sexp: missing )")
    | OP::AND::t -> let (a1, t1) = parser t in
                    let (a2, t2) = parser t1 in
                    (match t2 with
                    | CP::t' -> ((And (a1,a2)), t')
                 		| _ -> invalid_arg "sexp: missing )")
    | OP::OR::t -> let (a1, t1) = parser t in
                    let (a2, t2) = parser t1 in
                    (match t2 with
                    | CP::t' -> ((Or (a1,a2)), t')
                    | _ -> invalid_arg "sexp: missing )")
    | OP::XOR::t -> let (a1, t1) = parser t in
                    let (a2, t2) = parser t1 in
                    (match t2 with
                    | CP::t' -> ((Xor (a1,a2)), t')
                    | _ -> invalid_arg "sexp: missing )")
    | OP::EQ::t -> let (a1, t1) = parser t in
                    let (a2, t2) = parser t1 in
                    (match t2 with
                    | CP::t' -> ((Eq (a1,a2)), t')
                    | _ -> invalid_arg "sexp: missing )")
    | OP::NOT::t -> let (a1, t1) = parser t in
                    (match t1 with
                    | CP::t' -> (Not (a1), t')
                    | _ -> invalid_arg "sexp: missing ")
    | _ -> invalid_arg "parse failed."
  in let bx, t = parser tok_list in
     match t with
     | [] -> bx
     | _ -> invalid_arg "parse failed: extra tokens in input."

(* pipeline from s-expression string to boolExpr *)
let bool_exp_of_s_exp s = s |> wordlist |> tokens |> parse_bool_exp

(* evaluate the boolean expression bexp, assuming the variable names
   in the list tru are true, and variables not in the list are false *)
(* I added in the rest of the expressions*)
let rec eval_bool_exp bexp tru =
  match bexp with
  | Const b -> b
  | Id s -> List.mem s tru
  | Nand (x1, x2) -> not ((eval_bool_exp x1 tru) && (eval_bool_exp x2 tru))
  | And (x1, x2) -> ((eval_bool_exp x1 tru) && (eval_bool_exp x2 tru))
  | Or (x1, x2) -> ((eval_bool_exp x1 tru) || (eval_bool_exp x2 tru))
  | Xor (x1, x2) -> (not ((eval_bool_exp x1 tru) && (eval_bool_exp x2 tru)) && ((eval_bool_exp x1 tru) || (eval_bool_exp x2 tru)))
  | Not x ->  not (eval_bool_exp x tru)
  | Eq (x1, x2) -> x1 = x2







(* list all the subsets of the list s *)
(* This function begins with a list of an empty list*)
(* it then adds the first element to that list and appends the original empty list*)
(* then it recursively adds the next element of s to the current list and appends*)
(* the previous list to that one until there are no more elements in s*)
let rec subsets s = match s with
|[] -> [[]]
|h::t ->
  let f x l = match x with
  |x -> x::l
    in (List.map (f h) (subsets t))@(subsets t)

(* Used in var_list to remove duplicate variable entries.*)
(* I don't know why an if statement when capturing var names*)
(* didn't work so I made a function to do it.*)
(* *)
let remove_duplicates ls =
  let rec helper ls acc = match ls with
  |[] -> (List.rev acc)
  |h::t -> if (List.mem h t) then helper t acc else helper t (h::acc)
    in helper ls []

(* find all the variable names in a boolExpr by looking through*)
(*each boolean operator node recursively and returning either the*)
(*variable added onto the accumulator list or blank if a constant*)
let var_list bexp =
  let rec vhelp x acc = match x with
  |Const b -> []
  |Id s -> s::acc
  |And(x1,x2) -> remove_duplicates((vhelp x1 acc)@(vhelp x2 acc))
  |Or(x1,x2) -> remove_duplicates((vhelp x1 acc)@(vhelp x2 acc))
  |Nand(x1,x2) -> remove_duplicates((vhelp x1 acc)@(vhelp x2 acc))
  |Xor(x1,x2) -> remove_duplicates((vhelp x1 acc)@(vhelp x2 acc))
  |Eq(x1,x2) -> remove_duplicates((vhelp x1 acc)@(vhelp x2 acc))
  |Not x1 -> remove_duplicates((vhelp x1 acc))
    in vhelp bexp []


(* find_sat takes in a bool expression and makes a power set of it's list of variables. *)
(* It then tries the variable subsets until the expression evaluates to true*)
(* Finally it outputs the option list of the variables that evaluate to true*)
(* If it doesn't find any set of variables that satisfy the expression it returns None*)
let find_sat_set bexp =
  let rec help_sat bexp ls = match ls with
  | [] -> None
  | h::t -> if (eval_bool_exp bexp h) then Some h else help_sat bexp t
  in help_sat bexp (subsets (var_list bexp))

(*otl = option list to list, is a helper function for sat_main*)
(*so that it can take the option byte list and turn it into a regular byte list*)
let otl x = match x with
 | Some t -> (t : bytes list)
 | None -> []

(* sat_main is very similar to regular main, but it gives result*)
(* an option list of a satisfying condition. It then either prints the*)
(*satisfiable condition with the list of variables set to true or*)
(*lets the user know that nothing with satisfy the expression.*)
let sat_main () =
  let sExpr = String.concat " " (read_lines ()) in
  let bExpr = bool_exp_of_s_exp sExpr in
  let result = find_sat_set bExpr in
  let svarlist = "Satisfied when the variables {" ^ (String.concat ", " (otl result) ) ^"} are set to true." in
  let output = if (result = None) then "Not satisfiable" else svarlist in
  print_endline output


let main true_vars_list =
  let sExpr = String.concat " " (read_lines ()) in
  let bExpr = bool_exp_of_s_exp sExpr in
  let result = eval_bool_exp bExpr true_vars_list in
  let svarlist = " when the variables {" ^ (String.concat ", " true_vars_list) ^"} are set to true." in
  let output = (if result then "True" else "False")^svarlist in
  print_endline output
