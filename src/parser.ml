open Slot

exception WrongFirstLine

type firstline =
    {
      rows : int;
      slots : int;
      unavailable: int;
      groups: int;
      servers: int;
    }

let readline () = input_line stdin

let getFirstLine line =
  let start = ref 0
  and next = ref 0
  and array = Array.make 5 0 in
  try
    for i = 0 to 3 do
      next := String.index_from line !start ' ';
      array.(i) <- int_of_string (String.sub line !start (!next - !start));
      start := !next + 1
    done;
    array.(4) <- int_of_string (String.sub line (!next + 1) ((String.length line - 1) - !next));
    {rows = array.(0); slots = array.(1); unavailable = array.(2); groups = array.(3); servers = array.(4)}
  with _ -> raise WrongFirstLine

let getInt line =
  let middle = String.index line ' '
  and length = String.length line in
  (int_of_string (String.sub line 0 (middle)),
   int_of_string (String.sub line (middle + 1) (length - 1 - middle)))

let rec displayServers list =
  match list with
  | head::tail ->
     Printf.printf "size: %d capacity:%d\n" (Server.getSize head) (Server.getCapacity head);
     displayServers tail
  | _ -> ()

let displayTab array first =
  for i = 0 to first.slots do
    Printf.printf "--"
  done;
  Printf.printf "\n\n";
  for i = 0 to first.rows - 1 do
    Printf.printf "|";
    for j = 0 to first.slots - 1 do
      let bool = match array.(i).(j) with Unavailable -> "X" | Empty -> "." | _ -> "?" in
      Printf.printf "%s|" bool
    done;
    Printf.printf "\n\n"
  done;
  for i = 0 to first.slots do
    Printf.printf "--"
  done;
  Printf.printf "\n"

let _ =
  let first = getFirstLine (readline ()) in
  Printf.printf "Rows: %d | Slots: %d | unavailable: %d | groups: %d | servers: %d\n"
		first.rows first.slots first.unavailable first.groups first.servers;
  let center = Center.create first.rows first.slots first.groups first.servers in
  for i = 0 to first.unavailable - 1 do
    let row, cell = getInt (readline ()) in
    Center.setSlot center row cell Unavailable;
  done;
  for i = 0 to first.servers - 1 do
    let size, capacity = getInt (readline ()) in
    Center.addServer center (Server.create size capacity)
  done;
  center
