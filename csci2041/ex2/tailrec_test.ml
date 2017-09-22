let ( *@ ) m n = if m < 1 then [] else
   let rec loop accum m n =
      if m = 0 then
          accum
       else
         loop (n::accum) (m -1) n
   in
      loop [] m n
