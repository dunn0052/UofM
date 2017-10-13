open SimUtil

(* Your code goes here: *)

(* Define the function that filters out non-alphabetic characters *)
let filter_chars s = String.map (fun c -> match c with 'a'..'z' | 'A'..'Z' | ' ' -> c | _ -> ' ') s

(* Define the function that converts a string into a list of words *)
let words s = List.filter (fun c -> not (String.contains c ' ')) (split_words (filter_chars s))

(* Define the function that converts a list of strings into a list of word lists*)
let wordlists ls = [[]]

(* Use Stemmer.stem to convert a list of words into a list of stems *)
let stemlist ws = List.map (Stemmer.stem) ws

(* Define a function to convert a list into a set *)
let to_set lst = List.fold_left (fun t h -> if List.mem h t then t else h::t) [] lst

(* Define the similarity function between two sets: size of intersection / size of union *)
let intersection_size s1 s2 = List.fold_left (fun x l -> if (List.mem l s1) then x + 1 else x) 0 s2

let union_size s1 s2 = List.fold_left (fun x l -> if (List.mem l s1) || (List.mem l s2) then x + 1 else x) 0 s1

let similarity s1 s2 = (float_of_int (intersection_size s1 s2 )) /. (float_of_int (union_size s1 s2 ))

(* Find the most similar representative file *)
let find_max repsims repnames = match List.rev (List.sort compare (List.combine repsims repnames)) with
  [] -> (0.,"")
| h::t -> h;;

  let main all replist_name target_name =
    (* Read the list of representative text files *)
    let repfile_list = [""] in
    (* Get the contents of the repfiles and the target file as strings *)
    let rep_contents = [""] in
    let target_contents = "" in
    (* Compute the list of words from each representative *)
    let rep_words = [[]] in
    (* Convert the target text file into a list of words *)
    let target_words = [] in
    (* Compute the lists of stems in all rep files and the target file *)
    let rep_stemlists = [[]] in
    let target_stemlist = [] in
    (* Convert all of the stem lists into stem sets *)
    let rep_stemsets = [[]] in
    let target_stemset = [] in
    (* Compute the similarities of each rep set with the target set *)
    let repsims = [] in
    let (sim,best_rep) = ("",0.) in
    let () = if all then
    (* print out similarities to all representative files *)
    let () = print_endline "" in
    () else begin
    (* Print out the winner and similarity *)
    let () = print_endline "" in
    print_endline ""  end in
    (* this last line just makes sure the output prints before the program exits *)
    flush stdout
