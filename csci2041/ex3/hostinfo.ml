(* hostinfo, the "name" of a computer connected to the Internet *)
type hostinfo = IP of int*int*int*int | DNSName of string

(* Here's where your definition of tld goes: *)
let tld = function
DNSName s ->  Some (String.sub s ((String.rindex s '.') + 1) 3)
|IP _ -> None
