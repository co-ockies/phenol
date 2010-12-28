open Gmp
type num = Ratio of rational | Undefined

val fraction : int -> int -> num
val entier : int -> num
val q_of_num : num -> rational
val ( + ) : num -> num -> num
val ( - ) : num -> num -> num
val ( * ) : num -> num -> num
val ( / ) : num -> num -> num
val ( > ) : num -> num -> bool
val ( < ) : num -> num -> bool
val ( = ) : num -> num -> bool
val (>= ) : num -> num -> bool
val (<= ) : num -> num -> bool
val show : num -> string
