open Rational
type expr = Ratio of rational | Sub of expr * expr | Add of expr * expr
        | Mul of expr * expr | Div of expr * expr | Undefined

val fraction : int -> int -> expr
val entier : int -> expr
val expr_to_rational : expr -> rational
val expr_to_string : expr -> string
val expr_to_approx : expr -> int -> approx
val ( +$ ) : expr -> expr -> expr
val ( -$ ) : expr -> expr -> expr
val ( *$ ) : expr -> expr -> expr
val ( /$ ) : expr -> expr -> expr

