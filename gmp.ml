type z_t;;
external z_create : int -> z_t = "z_create"
external z_show : z_t -> string = "z_show"
external z_add : z_t -> z_t -> z_t = "z_add"
external z_sub : z_t -> z_t -> z_t = "z_sub"
external z_mul : z_t -> z_t -> z_t = "z_mul"
external z_neg : z_t -> z_t = "z_oppos"

type q_t;;
external q_create : int -> int -> q_t = "q_create"
external q_show : q_t -> string = "q_show"
external q_add : q_t -> q_t -> q_t = "q_add"
external q_sub : q_t -> q_t -> q_t = "q_sub"
external q_mul : q_t -> q_t -> q_t = "q_mul"
external q_div : q_t -> q_t -> q_t = "q_div"
external q_neg : q_t -> q_t = "q_oppos"
external q_of_z : z_t -> q_t = "q_of_z"
