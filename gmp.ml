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

type approx;;
external approx_of_q : rational -> int -> approx = "f_create"
external approx_show : approx -> string = "f_show"
external approx_add : approx -> approx -> approx = "f_add"
external approx_sub : approx -> approx -> approx = "f_sub"
external approx_mul : approx -> approx -> approx = "f_mul"
external approx_div : approx -> approx -> approx = "f_div"
external approx_neg : approx -> approx = "f_oppos"
