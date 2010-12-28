open Gmp

type num = Ratio of rational (*| Sub of num * num | Add of num * num
        | Mul of num * num | Div of num * num *)| Undefined

let fraction a b = Ratio (q a b);;
let entier a = Ratio (z a);;

let q_of_num a = match a with
        | Undefined -> z 0
        | Ratio x -> x;;

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
        | (Ratio x, Ratio y) -> if q_egal y (z 0) then Undefined else Ratio (q_div x y);;

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

let approx_of_num a = match a with
        | Undefined -> approx_of_q (z 0)
        | Ratio x -> approx_of_q x;;

