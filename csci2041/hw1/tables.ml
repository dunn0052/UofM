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

(* table_of_stringlist reads each element on the list of strings and uses the make_row function. The make_row output is consed onto a dummy list and that list is
 consed onto the return list. The function loops this pattern until the list of strings is exhausted. It then returns the final return list.*)

let rec table_of_stringlist delim rlist =
  let rec loop rlist accum = match rlist with
  |[] -> List.rev accum
  |x::t -> loop t ((make_row delim x)::accum) in loop rlist []


(* make_assoc takes a list of a list of strings and reads each string list. It assigns the first element row 1 and column 1. It then takes the next string and assigns it
   the same row and column + 1. Once it reaches the end of the first inner list it increments the row number and assigns columns once again starting at 1.*)
let make_assoc rc_list = match rc_list with
  |[] -> []
  |h::t -> let rec loop1 accum row h = match h with
    |[] -> List.rev accum
    |h::t -> let rec loop2 accum col h = match h with
      |[] -> loop1 accum (row+1) t
      |x::y -> loop2 ((row,col,x)::accum) (col+1) y in loop2 accum 1 h
      in loop1 [] 1 rc_list


(* remap_columns runs through the associative table list and collects the elements whos columns correspond with the column index list elements.
   It then takes the list of collected elements and simply uses the previous make_assoc function to make a new column.*)
let remap_columns clst alst =
    let rec helper acc clst = match clst with
    |[] -> (make_assoc (acc::[]))
    |h::t -> let rec helper2 h acc alst = match alst with
      |[] -> helper acc t
      |(x,y,z)::t -> if (y = h) then helper2 h (z::acc) t else helper2 h acc t
      in helper2 h acc alst in helper [] clst

(* transpose_table takes the associative form elements from the list, and cons the elements onto a new return list with the rows and columns switched. *)

let transpose_table alist =
  let rec helper alist acc = match alist with
  |[] -> acc
  |(x,y,z)::t -> helper t ((y,x,z)::acc) in helper alist []


(*remap_rows takes the list of elements in associative form, transposes the row with columns and performs the column remap function. Once that is returned it is then
  transposed once again to return the remapped rows instead of columns. *)

let remap_rows rlst alst = transpose_table (remap_columns rlst (transpose_table alst))

(* The table_of_assoc function sorts the list of associative entries. It then begins at row 1, column 1 and continues putting the values of each consecutive
   Column entry  into a dummy list. If a column isn't present in the row, it then tries with column + 1 until it reaches the end of the columns. Once it reaches
   The end of the columns it sets columns back to 1 and incriments the row number and cons the list of elements onto the eventual return list.
   It then does the column search and pull again and again until it reaches the end of the original list. Once the end has been reached, it returns the final return list*)

let table_of_assoc ls = match (List.sort compare ls) with
|[] -> []
|h::t -> let rec loop accu row ls = match ls with
  |[] -> (List.rev accu)
  |h::t -> (*let col = 1 in *)let rec ele_grab col row ls acc = match ls with
    |[] -> if (acc = []) then loop accu (row+1) t else loop ((List.rev acc)::accu) (row+1) t
    |(x,y,z)::t -> if (x = row) then ele_grab (col + 1) row t (z::acc) else ele_grab (col + 1) row t acc
    in ele_grab 1 row ls [] in loop [] 1 ls

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
