type t

val create : int -> int -> int -> Server.t -> t

val getNbRows : t -> int

val getNbSlotsByRow : t -> int

val getMatrix : t -> Slot.t array array

val getSlot : t -> int -> int -> Slot.t 

val setSlot : t -> int -> int -> Slot.t -> unit

val getPool : t -> int -> Server.t list