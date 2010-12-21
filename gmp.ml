type rational;;
external q : int -> int -> rational = "q_create"
external q_show : rational -> string = "q_show"
external q_add : rational -> rational -> rational = "q_add"
external q_sub : rational -> rational -> rational = "q_sub"
external q_mul : rational -> rational -> rational = "q_mul"
external q_div : rational -> rational -> rational = "q_div"
external q_neg : rational -> rational = "q_oppos"
external q_sup_egal : rational -> rational -> bool = "q_sup_egal"
external q_egal : rational -> rational -> bool = "q_egal"

let z a = q a 1;;
