(* Second phase of the resolution algorithm *)

(* Figuring out which pool has the least CPU power
 * Allocate it the best unallocated server so far
 * Keep going until all servers are allocated. *)

let evalServer s =
  float_of_int (Server.getCapacity s) /. float_of_int (Server.getSize s)

let compareServer s1 s2 =
  Pervasives.compare (evalServer s1) (evalServer s2)

let run center =
  let sortedServerList =
    Center.getUsedServers center |> List.sort compareServer
  in
  let rec aux l = 
    match l with
    | [] -> ()
    | server :: tail ->
      let worstPoolIndex = Center.findWorstPool center in
      Server.setPool server worstPoolIndex;
      aux tail
  in
  aux sortedServerList



