type t

val create : int -> int -> int -> int -> t

val getNbRows : t -> int

val getNbSlotsByRow : t -> int

val getMatrix : t -> Slot.t array array

val getSlot : t -> int -> int -> Slot.t 

val setSlot : t -> int -> int -> Slot.t -> unit

val getPool : t -> int -> Server.t list

val addServer : t -> Server.t -> unit

val getServers : t -> Server.t list

val getUsedServers : t -> Server.t list

val getRowCapacity : t -> int -> int

val getPoolCapacity : Server.t list -> int

val findWorstPool : t -> Server.t list
