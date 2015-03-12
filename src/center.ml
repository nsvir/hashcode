type center = {matrix : slot.t array array ; nbRows : int ; nbSlotsByRow : int }


let getPool center n = (* renvoie la pool numéro n dans le center passé en paramètre *)
        let result = ref [] in
        for i = 0 to nbRows - 1 do
                for j = 0 to nbSlotsByRow do
                        match center.matrix.(i).(j) with
                        | slot.Empty -> ()
                        | slot.Unavailable -> ()
                        | slot.Tail -> ()
                        | Cons server -> result := server :: !result;
        !result;
