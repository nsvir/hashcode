(* Second phase of the resolution algorithm *)

(* Figuring out which pool has the least CPU power
 * Allocate it the best unallocated server so far
 * Keep going until all servers are allocated. *)

let worstPoolSoFar = ref (getPool center 0);

let getCapacity(pool) =
  let rec aux l acc =
          match l with 
            | hd :: tl -> aux tl (acc + hd.capacity)
            | [] -> acc in 
  aux pool 0

let findWorstPool(center) =
        for i = 0 to 44 do
                let newPool = getPool(center,i) in
                if getCapacity(newPool) < getCapacity(!worstPoolSoFar) then
                        worstPoolSoFar := newPool
        done;
        !worstPoolSoFar

