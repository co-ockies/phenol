open Gmp
type num = Ratio of rational | Undefined

val fraction : int -> int -> num
val entier : int -> num
val ( + ) : num -> num -> num
val show : num -> string
