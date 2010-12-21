open Gmp

type num = Ratio of rational | Undefined

let fraction a b = Ratio (q a b);;
let entier a = Ratio (z a);;

let ( + ) a b = match (a, b) with
        | (Undefined, _) -> Undefined
        | (_, Undefined) -> Undefined
        | (Ratio x, Ratio y) -> Ratio (q_add x y);;

let ( - ) a b = match (a, b) with
        | (Undefined, _) -> Undefined
        | (_, Undefined) -> Undefined
        | (Ratio x, Ratio y) -> Ratio (q_sub x y);;

let ( * ) a b = match (a, b) with
        | (Undefined, _) -> Undefined
        | (_, Undefined) -> Undefined
        | (Ratio x, Ratio y) -> Ratio (q_mul x y);;

let ( / ) a b = match (a, b) with
        | (Undefined, _) -> Undefined
        | (_, Undefined) -> Undefined
        | (Ratio x, Ratio y) -> Ratio (q_div x y);;

let (>= ) a b = match (a, b) with
        | (Undefined, _) -> false
        | (_, Undefined) -> false
        | (Ratio x, Ratio y) -> q_sup_egal x y;;

let ( = ) a b = match (a, b) with
        | (Undefined, _) -> false
        | (_, Undefined) -> false
        | (Ratio x, Ratio y) -> q_egal x y;;

let ( < ) a b = match (a, b) with
        | (Undefined, _) -> false
        | (_, Undefined) -> false
        | (Ratio x, Ratio y) -> not (q_sup_egal x y);;

let (<= ) a b = match (a, b) with
        | (Undefined, _) -> false
        | (_, Undefined) -> false
        | (Ratio x, Ratio y) -> (q_egal x y) || (not (q_sup_egal x y));;

let ( > ) a b = match (a, b) with
        | (Undefined, _) -> false
        | (_, Undefined) -> false
        | (Ratio x, Ratio y) -> (q_sup_egal x y) && (not (q_egal x y));;

let show a = match a with
        | Undefined -> "Undefined"
        | Ratio x -> q_show x;;

