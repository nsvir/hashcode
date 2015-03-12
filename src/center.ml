
type t = {
  matrix : Slot.t array array ;
  nbPools : int ;
  nbRows : int ;
  nbSlotsByRow : int ;
  servers : Server.t list
}

let create nbRows nbSlotsByRow nbPools servers =
  let matrix = Array.make_matrix nbRows nbSlotsByRow Slot.Empty in
  { matrix; nbRows; nbSlotsByRow; nbPools; servers }

let getNbRows center =
  center.nbRows

let getNbSlotsByRow center =
  center.nbSlotsByRow

let getMatrix center =
  center.matrix

let getSlot center rowIndex slotIndex =
  center.matrix[rowIndex][slotIndex]

let setSlot center rowIndex slotIndex slotValue =
  center.matrix[rowIndex][slotIndex] <- slotValue

let getPool center n = (* renvoie la pool numéro n dans le center passé en paramètre *)
  let result = ref [] in
  for i = 0 to nbRows - 1 do
    for j = 0 to nbSlotsByRow do
      match center.matrix.(i).(j) with
      | Slot.Empty -> ()
      | Slot.Unavailable -> ()
      | Slot.Tail -> ()
      | Cons server ->
        if Server.getPool server = n then
          result := server :: !result;
    done;
  done;
  !result

