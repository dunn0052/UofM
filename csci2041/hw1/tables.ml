(* tables.ml - CSci 2041 HW 1 table slicer and dicer *)
(* Kevin Dunn *)

(* Free functions, don't question! *)
(* read std input to eof, return list of lines *)
let read_lines () : string list =
  let rec read_help acc =
    try read_help ((read_line ())::acc) with End_of_file -> List.rev acc
  in read_help []

(* separate a string by delim into a list, trimming surrounding whitespace *)
let make_row delim str =
  let rec trim_strings ls acc = match ls with
  | [] -> List.rev acc
  | h::t -> trim_strings t ((String.trim h)::acc) in
  trim_strings (Str.split (Str.regexp delim) str) []

(* print a list of strings to std output, separated by delim string *)
(* avoids nasty quadratic concatenation behavior *)
let rec write_row r delim = match r with
| [] -> ()
| h::[] -> print_endline h
| h::t -> let () = print_string h in
          let () = print_string delim in write_row t delim

(* Output table using write_row, note let () = ... idiom *)
let rec output_table od t = match t with
| [] -> ()
| r::rs -> let () = write_row r od in output_table od rs

(* Now your turn. *)
(* translate a list of rows in string form into a list of *)
(* lists of string entries *)
let rec table_of_stringlist delim rlist =
  let rec loop rlist accum = match rlist with
  |[] -> List.rev accum
  |x::t -> loop t ((make_row delim x)::accum) in loop rlist []


(* translate a string list list into associative form, i.e. *)
(* a list of (row, column, entry) triples *)
let make_assoc rc_list = match rc_list with
  |[] -> []
  |h::t -> let rec loop1 accum r h = match h with
    |[] -> List.rev accum
    |q::p -> let rec loop2 accum c q = match q with
      |[] -> loop1 accum (r+1) p
      |x::y -> loop2 ((r,c,x)::accum) (c+1) y in loop2 accum 1 q
      in loop1 [] 1 rc_list


(* remap the columns of the associative form so that the first column number in clst *)
(* is column 1, the second column 2, ..., and any column not in clst doesn't appear *)
let remap_columns clst alst =
    let rec helper acc clst = match clst with
    |[] -> (make_assoc (acc::[]))
    |h::t -> let rec helper2 h acc alst = match alst with
      |[] -> helper acc t
      |(x,y,z)::p -> if (y = h) then helper2 h (z::acc) p else helper2 h acc p
      in helper2 h acc alst in helper [] clst
      
(* transpose table works on the associative form *)
let transpose_table alist =
  let rec helper alist acc = match alist with
  |[] -> acc
  |(x,y,z)::t -> helper t ((y,x,z)::acc) in helper alist []


(* remap the rows of the associative form so that the first row number in rlst *)
(* is row 1, the second is row 2, ..., and any row not in rlist doesn't appear *)
let remap_rows rlst alst = transpose_table (remap_columns rlst (transpose_table alst))

(* here's a tricky one! *)
let table_of_assoc alist = []

(* OK, more free stuff *)
let main transpose clst rlst id od =
  let sl = read_lines () in
  let rtable = table_of_stringlist id sl in
  let alist = make_assoc rtable in
  let clist = if clst = [] then alist else (remap_columns clst alist) in
  let rlist = if rlst = [] then clist else (remap_rows rlst clist) in
  let tlist = if transpose then transpose_table rlist else rlist in
  let ntable = table_of_assoc tlist in
  output_table od ntable
