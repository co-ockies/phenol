open Rational

type expr = Ratio of rational | Sub of expr * expr | Add of expr * expr
        | Mul of expr * expr | Div of expr * expr | Undefined

let fraction a b = Ratio (q a b);;
let entier a = Ratio (z a);;

let expr_to_rational a = match a with
        | Undefined -> z 0
        | Ratio x -> x
        | _ -> z 0;;

let ( +$ ) a b = match (a, b) with
        | (Undefined, _) -> Undefined
        | (_, Undefined) -> Undefined
        | (Ratio x, Ratio y) -> Ratio (x +/ y)
        | (x, y) -> Add (x, y);;

let ( -$ ) a b = match (a, b) with
        | (Undefined, _) -> Undefined
        | (_, Undefined) -> Undefined
        | (Ratio x, Ratio y) -> Ratio (x +/ y)
        | (x, y) -> Sub (x, y);;

let ( *$ ) a b = match (a, b) with
        | (Undefined, _) -> Undefined
        | (_, Undefined) -> Undefined
        | (Ratio x, Ratio y) -> Ratio (x */ y)
        | (x, y) -> Mul (x, y);;

let ( /$ ) a b = match (a, b) with
        | (Undefined, _) -> Undefined
        | (_, Undefined) -> Undefined
        | (Ratio x, Ratio y) -> if q_egal y (z 0) then Undefined else Ratio (x // y)
        | (x, y) -> Div (x, y);;


let rec expr_to_string a = match a with
        | Undefined -> "Undefined"
        | Ratio x -> q_to_string x
        | Add (x, y) -> (expr_to_string x) ^ "+" ^ (expr_to_string y)
        | Sub (x, y) -> (expr_to_string x) ^ "-" ^ (expr_to_string y)
        | Mul (x, y) -> (expr_to_string x) ^ "*" ^ (expr_to_string y)
        | Div (x, y) -> (expr_to_string x) ^ "/" ^ (expr_to_string y);;

let expr_to_approx a prec = match a with
        | Undefined -> q_to_approx (z 0) prec
        | Ratio x -> q_to_approx x prec
        | _ -> q_to_approx (z 0) prec;;
