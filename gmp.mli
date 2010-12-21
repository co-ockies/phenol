type z_t
val z_create : int -> z_t
val z_show : z_t -> string
val z_add : z_t -> z_t -> z_t
val z_sub : z_t -> z_t -> z_t
val z_mul : z_t -> z_t -> z_t
val z_neg : z_t -> z_t

type q_t
val q_create : int -> int -> q_t
val q_show : q_t -> string
val q_add : q_t -> q_t -> q_t
val q_sub : q_t -> q_t -> q_t
val q_mul : q_t -> q_t -> q_t
val q_div : q_t -> q_t -> q_t
val q_neg : q_t -> q_t
val q_of_z : z_t -> q_t
