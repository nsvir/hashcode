
type t

val create : int -> int -> t

val isUsed : t -> bool

val setUsed : t -> ()

val setUnused : t -> ()

val getPool : t -> int

val setPool : t -> int -> ()

val unsetPool : t -> ()

