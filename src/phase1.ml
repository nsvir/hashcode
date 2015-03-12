(* First phase of the resolution *)


(* Figuring out which row has the least CPU power
 * Then try to place the best unallocated server so far in said row
 * Repeat until the grid is full. *)

(* Function that, given a center and a size returns a list of available slots. *)

exception NotFit
exception NotFitAtAll

let tryToPutServer row server =
  let lenght = Server.getSize server in
  let index, taille = Center.getRoom center row in
  if length > taille then
    raise NotFit
  else
    Center.setSlot row index (Cons server)

let rec placeServer row servers =
  match servers with
  | head::tail ->
     try
       tryToPutServer row head
     with
     | NotFit -> placeServer row tail
  | _ -> raise NotFitAtAll

let evalServer s =
  float_of_int (Server.getCapacity s) /. float_of_int (Server.getSize s)

let compareServer s1 s2 =
  Pervasives.compare (evalServer s1) (evalServer s2)

let findWorstPull center =
  let rows = Center.getMatrix center in
  placeServer center (Center.findLowerRow center) (Center.getServers center |> List.sort compareServer)
