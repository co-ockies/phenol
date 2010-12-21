open Gmp

type num = Ratio of rational | Undefined

let fraction a b = Ratio (q a b);;
let entier a = Ratio (z a);;
let ( + ) a b = match (a, b) with
        | (Undefined, _) -> Undefined
        | (_, Undefined) -> Undefined
        | (Ratio x, Ratio y) -> Ratio (q_add x y);;
let show a = match a with
        | Undefined -> "Undefined"
        | Ratio x -> q_show x;;
