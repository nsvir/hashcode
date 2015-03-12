
type t

val create : int -> int -> t

val isUsed : t -> bool

val setUsed : t -> unit

val setUnused : t -> unit

val getPool : t -> int

val setPool : t -> int -> unit

val unsetPool : t -> unit

val getSize : t -> int

val getCapacity : t -> int
