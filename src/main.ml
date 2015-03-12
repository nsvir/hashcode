open Slot

let _ =
  let center = Parser.create() in
  let servers = Center.getServers center in
  Center.setSlot center 0 0 (Cons (List.hd servers));
  Center.setSlot center 1 1 (Cons (List.hd (List.tl servers)));
  Center.setSlot center 3 1 (Cons (List.hd (List.tl (List.tl servers))));
  Flush.flush center
