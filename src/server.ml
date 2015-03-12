type t = {
  size : int ;
  capacity : int ;
  mutable used : bool ;
  mutable pool : int }

let create size capacity = 
  { size; capacity; used = false; pool = -1}

let isUsed server =
  server.used

let setUsed server = 
  server.used <- true

let setUnused server =
  server.used <- false

let getPool server =
  server.pool

let setPool server pool =
  server.pool <- pool

let unsetPool server =
  server.pool <- (-1)

let getSize server =
  server.size

let getCapacity server =
  server.capacity
