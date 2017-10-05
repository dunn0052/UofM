type suit = Hearts | Clubs | Diamonds | Spades
type value = Simple of int |Jack | Queen | King | Ace
type card = { suit : suit; value : value }


let trick_winner cards = match cards with
  | [] -> invalid_arg "empty trick"
  | lead::t -> let rec win_helper t cw = match t with
    | c::t -> if (c.suit = cw.suit) && (c.value > cw.value) then win_helper t c
              else win_helper t cw
    | [] -> lead
    in win_helper cards lead

let rec trick_winner_trump cards (trump: suit option) = match cards with
|[] -> invalid_arg "empty trick"
|lead::t -> if (trump = None) then trick_winner cards else lead
