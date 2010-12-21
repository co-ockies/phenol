open Gmp

type n_t = Entier of z_t | Frac of q_t

let ( + ) n1 n2 = match (n1, n2) with
        | (Entier a, Entier b) -> Entier (z_add a b)
        | (Frac a, Frac b) -> Frac (q_add a b)
        | (Entier a, Frac b) -> Frac (q_add (q_of_z a) b)
        | (Frac a, Entier b) -> Frac (q_add a (q_of_z b));;
let show n = match n with
        | Entier a -> z_show a
        | Frac a -> q_show a;;
