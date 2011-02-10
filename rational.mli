type rational
val q : int -> int -> rational
val z : int -> rational
val q_to_string: rational -> string
val q_add : rational -> rational -> rational
val q_sub : rational -> rational -> rational
val q_mul : rational -> rational -> rational
val q_div : rational -> rational -> rational
val q_neg : rational -> rational
val q_sup_egal : rational -> rational -> bool
val q_egal : rational -> rational -> bool
val ( +/ ) : rational -> rational -> rational
val ( -/ ) : rational -> rational -> rational
val ( */ ) : rational -> rational -> rational
val ( // ) : rational -> rational -> rational
val ( =/ ) : rational -> rational -> bool
val (<=/ ) : rational -> rational -> bool
val (>=/ ) : rational -> rational -> bool
val ( >/ ) : rational -> rational -> bool
val ( </ ) : rational -> rational -> bool
val (<>/ ) : rational -> rational -> bool

type approx;;
val q_to_approx : rational -> int -> approx
val approx_to_string : approx -> string
val approx_add : approx -> approx -> approx
val approx_sub : approx -> approx -> approx
val approx_mul : approx -> approx -> approx
val approx_div : approx -> approx -> approx
val approx_neg : approx -> approx
