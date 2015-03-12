
type t = {
  matrix : Slot.t array array ;
  nbPools : int ;
  nbRows : int ;
  nbSlotsByRow : int ;
  nbServers : int ;
  mutable servers : Server.t list
}

let create nbRows nbSlotsByRow nbPools nbServers =
  let matrix = Array.make_matrix nbRows nbSlotsByRow Slot.Empty in
  { matrix; nbRows; nbSlotsByRow; nbPools; nbServers; servers = [] }

let getNbRows center =
  center.nbRows

let getNbSlotsByRow center =
  center.nbSlotsByRow

let getMatrix center =
  center.matrix

let getSlot center rowIndex slotIndex =
  center.matrix.(rowIndex).(slotIndex)

let setSlot center rowIndex slotIndex slotValue =
  center.matrix.(rowIndex).(slotIndex) <- slotValue

let addServer center server =
  center.servers <- server :: center.servers

let getServers center =
  center.servers

let getPool center n = (* renvoie la pool numéro n dans le center passé en paramètre *)
  let result = ref [] in
  for i = 0 to center.nbRows - 1 do
    for j = 0 to center.nbSlotsByRow do
      match center.matrix.(i).(j) with
      | Slot.Empty -> ()
      | Slot.Unavailable -> ()
      | Slot.Tail -> ()
      | Slot.Cons server ->
        if Server.getPool server = n then
          result := server :: !result;
    done;
  done;
  !result

let getUsedServers center =
  center.servers |> List.filter Server.isUsed

let getPoolCapacity pool =
  let rec aux l acc =
    match l with 
    | hd :: tl -> aux tl (acc + Server.getCapacity hd)
    | [] -> acc in 
    aux pool 0

let findWorstPool center =
  let worstPoolSoFar = ref (getPool center 0) in
  let worstPoolCapacity = ref (getPoolCapacity !worstPoolSoFar) in
  let worstPoolIndex = ref 0 in
  for i = 0 to center.nbPools - 1 do
    let newPool = getPool center i in
    let currentPoolCapacity = getPoolCapacity newPool in
    if currentPoolCapacity < !worstPoolCapacity then (
      worstPoolSoFar := newPool;
      worstPoolCapacity := currentPoolCapacity;
      worstPoolIndex := i
    )
  done;
  !worstPoolIndex

let getRowCapacity center rowIndex =
  let row = center.matrix.(rowIndex) in
  row |> Array.fold_left (
    fun sum slot ->
      match slot with
      | Slot.Cons server -> sum + Server.getCapacity server
      | _ -> sum
  ) 0

