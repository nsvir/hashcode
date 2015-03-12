open Slot

let write line =
  output_string stdout line

let concat server row cell=
  String.concat " "
		(string_of_int row::string_of_int cell::(string_of_int (Server.getPool server))::"\n"::[])

let findAndConcatAndWrite matrix =
  for i = 0 to (Array.length matrix) - 1 do
    for j = 0 to (Array.length matrix.(i)) - 1 do
      match matrix.(i).(j) with
      | Cons server -> write (concat server i j)
      | _ -> ()
    done;
  done

let flush center =
  findAndConcatAndWrite (Center.getMatrix center)
