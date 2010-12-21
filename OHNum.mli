open Gmp
type n_t = Entier of z_t | Frac of q_t
val ( + ) : n_t -> n_t -> n_t
val show : n_t -> string
