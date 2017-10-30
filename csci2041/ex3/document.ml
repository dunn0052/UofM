type entity =
  Title of entity list
  | Heading of entity list
  | Text of string
  | Anchor of anchor
 and anchor = Named of string * (entity list) | HRef of string * (entity list
  | List of entity list

type document = { head : entity list ; body : entity list }

(* a few example documents *)
let d1 = { head = [(Title [(Text "cs2041.org")])] ;
	   body = [ (Heading [(Text "CS 2041 Document")]) ;
		    (Text "A short document") ;
		    (Anchor (Named ("here", []))) ;
		    (Text "A little more stuff") ;
		    (Anchor (HRef ("#here", [(Text "Click this to go back")]))) ] }

let d2 = { head = [(Title [(Text "github.umn.edu/cs2041-f17a/labs2041-f17a/lab2")])] ;
	   body = [ (Heading [(Text "Lab 2: Types, Patterns and Recursion")]) ;
		    (Text "Due dates and stuff.") ;
		    (Heading [(Text "Ground rules")]) ;
		    (Text "Work with a partner, and so on.") ;
		    (Heading [(Text "Goals for this lab")]) ;
		    (* Add a list here:
                       + apply type inference knowledge
                       + see pattern matching examples
                       + write recursive functions *)
		    (Heading [(Text "Types and Type inference")]) ;
		    (Text "The rest of the lab gets boring quickly...") ] }

let d_err1 = { head = [(Anchor (Named ("notgood", [])))] ;
	       body = [(Text "But sort of boring.")] }

let d_err2 = { head = [] ;
	       body = [(Title [(Text "The Title doesn't go in the body!")])] }

let d_err3 = { head = [(Title [(Text "Title's where it goes but...")])] ;
	       body = [(Anchor (Named ("evenworse", [(Anchor (Named ("nested anchor!", [])))])))] }

(* Example of computing on a document *)
let check_rules { head ; body } =
  let rec check_head el = match el with
    | [] -> true
    | (Title el')::t | (Heading el')::t -> (check_head el') && (check_head t)
    | (Text _)::t -> check_head t
    | (Anchor _)::t -> false in
  let rec check_body el nest = match el with (* nest = are we inside an Anchor element? *)
    | [] -> true
    | (Title el')::t -> false
    | (Text _)::t -> check_body t nest
    | (Heading el')::t -> (check_body el' nest) && (check_body t nest)
    (* When we check the elements inside this anchor, set nest to true, but not in the tail*)
    | (Anchor (Named (_,el')))::t
    | (Anchor (HRef (_,el')))::t -> if nest then false else (check_body el' true) && (check_body t nest) in
  (* Initially, nest = false... *)
  (check_body body false) && (check_head head)
