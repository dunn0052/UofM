open SimUtil



(* filters out everything that's not alphabetic and turns it into a space instead*)
let filter_chars s = String.map (fun c -> match c with 'a'..'z' | 'A'..'Z' -> c | _ -> ' ') s


(*uses split_words function to take the long concatenated file into a list of individual
  words and then filters out those naughty spaces*)
let words s = List.filter (fun c -> not (String.contains c ' ')) (split_words (filter_chars s))



(*simply uses the stem function on each word*)
let stemlist ws = List.map (Stemmer.stem) ws


(*removes repeats aka a proper set*)
let to_set lst = List.fold_left (fun t h -> if List.mem h t then t else h::t) [] lst


(*Checks all elements of s2 to see if they are also an element of s1. If so, increment the accumulator value *)
let intersection_size s1 s2 = List.fold_left (fun x l -> if (List.mem l s1) then x + 1 else x) 0 s2

(* proper set of the union of both sets to ensure all elements get checked in either set and there are no accidental repeats *)
let union_size s1 s2 = List.fold_left (fun x l -> if (List.mem l s1) || (List.mem l s2) then x + 1 else x) 0 (to_set (s1@s2))

(* divides the result of the intersection and union -- returns the value as a float*)
let similarity s1 s2 = (float_of_int (intersection_size s1 s2 )) /. (float_of_int (union_size s1 s2 ))


(* pairs each similarity score with the name of each file, and then returns the max score *)
let find_max repsims repnames = match List.rev (List.sort compare (List.combine repsims repnames)) with
  [] -> (0.,"")
| h::t -> h;;

(* driver function to print and calculate similarity scores *)
let main all replist_name target_name =
  (* Read the list of representative text files *)
  let repfile_list = file_lines replist_name in
  (* Get the contents of the repfiles and the target file as strings *)
  let rep_contents  = List.map file_as_string repfile_list in
  let target_contents  = file_as_string target_name in
  (* Compute the list of words from each representative *)
  let rep_words = List.map words rep_contents in
  (* Convert the target text file into a list of words *)
  let target_words = words target_contents in
  (* Compute the lists of stems in all rep files and the target file *)
  let rep_stemlists = List.map stemlist rep_words in
  let target_stemlist = stemlist target_words in
  (* Convert all of the stem lists into stem sets *)
  let rep_stemsets = List.map to_set rep_stemlists in
  let target_stemset = to_set target_stemlist in
  (* Compute the similarities of each rep set with the target set*)
  let repsims = List.map (similarity target_stemset) rep_stemsets in
  let (sim,best_rep) = find_max repsims repfile_list in
  let () = if all then
  (* print out similarities to all representative files *)
  let () = print_endline "File\tSimilarity" in
  (* prints names and sim scores *)
  let () = List.iter2 (fun a b -> print_endline (a^"\t"^(string_of_float b))) repfile_list repsims in
  () else begin
  (* Print out the winner and similarity *)
  let () = print_endline ("The most similar file to "^target_name^" was "^best_rep) in
  print_endline ("Similarity: "^(string_of_float sim)) end in
  (* this last line just makes sure the output prints before the program exits *)
  flush stdout
