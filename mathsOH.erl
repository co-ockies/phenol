-module(mathsOH).
-export([entier/1, flottant/1, fraction/1, fraction/2, add/2, sub/2, mul/2, divis/2, pow/2, inf/2, sup/2, infegal/2, supegal/2, egal/2, int_dichotomie/4, int_sqrt/1, divis_euclid/2, pgcd/2, simpl_frac/1, prime/1, find_prime_sup/1]).



entier(X) when is_integer(X) ->
	X;
entier(X) when is_float(X) ->
	trunc(X);
entier({A, B}) when is_integer(A), is_integer(B) ->
	divis_euclid(A, B).

flottant(X) when is_integer(X) ->
	X * 1.0;
flottant(X) when is_float(X) ->
	X;
flottant({A,B}) when is_integer(A), is_integer(B) ->
	(A/B)*1.0 .

fraction(X) when is_integer(X) ->
	{X, 1};
fraction({A, B}) when is_integer(A), is_integer(B) ->
	{A, B}.

fraction(A, B) when is_integer(A), is_integer(B) ->
	{A, B}.

add(A, B) when is_number(A), is_number(B) ->
	A+B;
add(A, {B_Num, B_Den}) when is_integer(A), is_integer(B_Num), is_integer(B_Den) ->
	{A*B_Den + B_Num, B_Den};
add(A, {B_Num, B_Den}) when is_float(A), is_integer(B_Num), is_integer(B_Den) ->
	A+ B_Num/B_Den;
add({A_Num, A_Den}, {B_Num, B_Den}) when is_integer(A_Num), is_integer(A_Den), is_integer(B_Num), is_integer(B_Den) ->
	{A_Num*B_Den + B_Num*A_Den, A_Den*B_Den};
add({A_Num, A_Den}, B) ->
	add(B, {A_Num, A_Den}).

sub(A, B) when is_number(A), is_number(B) ->
	A-B;
sub(A, {B_Num, B_Den}) when is_integer(A), is_integer(B_Num), is_integer(B_Den) ->
	{A*B_Den - B_Num, B_Den};
sub(A, {B_Num, B_Den}) when is_float(A), is_integer(B_Num), is_integer(B_Den) ->
	A- B_Num/B_Den;
sub({A_Num, A_Den}, {B_Num, B_Den}) when is_integer(A_Num), is_integer(A_Den), is_integer(B_Num), is_integer(B_Den) ->
	{A_Num*B_Den - B_Num*A_Den, A_Den*B_Den};
sub({A_Num, A_Den}, B) when is_integer(A_Num), is_integer(A_Den), is_integer(B) ->
	{A_Num - B*A_Den, A_Den};
sub({A_Num, A_Den}, B) when is_integer(A_Num), is_integer(A_Den), is_float(B) ->
	A_Num/A_Den-B.

mul(A, B) when is_number(A), is_number(B) ->
	A*B;
mul(A, {B_Num, B_Den}) when is_integer(A), is_integer(B_Num), is_integer(B_Den) ->
	{A*B_Num, B_Den};
mul(A, {B_Num, B_Den}) when is_float(A), is_integer(B_Num), is_integer(B_Den) ->
	A* B_Num/B_Den;
mul({A_Num, A_Den}, {B_Num, B_Den}) when is_integer(A_Num), is_integer(A_Den), is_integer(B_Num), is_integer(B_Den) ->
	{A_Num*B_Num, A_Den*B_Den};
mul({A_Num, A_Den}, B) ->
	mul(B, {A_Num, A_Den}).

divis(A, B) when is_integer(A), is_integer(B) ->
	{A, B};
divis(A, B) when is_float(A), is_float(B) ->
	A/B;
divis(A, {B_Num, B_Den}) when is_integer(A), is_integer(B_Num), is_integer(B_Den) ->
	{A*B_Den, B_Num};
divis(A, {B_Num, B_Den}) when is_float(A), is_integer(B_Num), is_integer(B_Den) ->
	A*B_Den/B_Num;
divis({A_Num, A_Den}, {B_Num, B_Den}) when is_integer(A_Num), is_integer(A_Den), is_integer(B_Num), is_integer(B_Den) ->
	{A_Num*B_Den, A_Den*B_Num};
divis({A_Num, A_Den}, B) when is_integer(A_Num), is_integer(A_Den), is_integer(B) ->
	{A_Num, A_Den*B};
divis({A_Num, A_Den}, B) when is_integer(A_Num), is_integer(A_Den), is_float(B) ->
	A_Num/(A_Den*B).

pow(_, 0) ->
	1;
pow(A, N) when is_integer(N), N > 0 ->
	mul(A, pow(A, N-1)).

inf(A, B) when is_integer(A), is_integer(B) ->
	if
		A < B -> true;
		true -> false
	end;
inf({A_Num, A_Den}, {B_Num, B_Den}) when is_integer(A_Num), is_integer(B_Num), is_integer(A_Den), is_integer(B_Den) ->
	if
		A_Num * B_Den < B_Num * A_Den -> true;
		true -> false
	end;
inf(A, B)  when is_float(A), is_float(B) ->
	if
		A < B -> true;
		true -> false
    	end.

sup(A, B) when is_integer(A), is_integer(B) ->
	if
		A > B -> true;
		true -> false
	end;
sup({A_Num, A_Den}, {B_Num, B_Den}) when is_integer(A_Num), is_integer(A_Den), is_integer(B_Num), is_integer(B_Den) ->
	if
		A_Num * B_Den > B_Num * A_Den -> true;
		true -> false
	end;
sup(A, B) when is_float(A), is_float(B) ->
	if
		A > B -> true;
		true -> false
	end.

supegal(A, B) ->
	not inf(A, B).

infegal(A, B) ->
	not sup(A, B).

egal(A, B) ->
	supegal(A, B) and infegal(A, B).

int_dichotomie(Min, Max, Fun, Obj) when is_integer(Min), is_integer(Max), Max == Min + 1 ->
	Fun_Min = Fun(Min),
	Fun_Max = Fun(Max),
	if
		Fun_Min == Obj -> Min;
		Fun_Max == Obj -> Max;
		true -> {error, {Min, Max}}
	end;
int_dichotomie(Min, Max, Fun, Obj) when is_integer(Min), is_integer(Max), is_function(Fun), is_integer(Obj) ->
	Milieu = entier(divis(add(Min, Max), 2)),
	Fun_Milieu = Fun(Milieu),
	if
		Fun_Milieu == Obj -> Milieu;
		Fun_Milieu >= Obj -> int_dichotomie(Min, Milieu, Fun, Obj);
		Fun_Milieu =< Obj -> int_dichotomie(Milieu, Max, Fun, Obj)
	end.

int_sqrt(X) when is_integer(X), X == 0 ->
	0;
int_sqrt(X) when is_integer(X), X > 0 ->
	int_dichotomie(0, X, fun(U) -> mathsOH:pow(U, 2) end, X).

divis_euclid(A, B) when is_integer(A), is_integer(B), A < 0 ->
	divis_euclid(A, -B) * -1;
divis_euclid(A, B) when is_integer(A), is_integer(B), B < 0 ->
	divis_euclid(-A, B) * -1;
divis_euclid(A, B) when is_integer(A), is_integer(B), B == 1 ->
	{A,0};
divis_euclid(A, B) when is_integer(A), is_integer(B) ->
	divis_euclid(A, B, 0).

divis_euclid(A, B, I) when is_integer(A), is_integer(B), is_integer(I) ->
	if
		A >= B -> divis_euclid(A - B, B, I + 1);
		true -> {I, A}
	end.

pgcd(A, B) when is_integer(A), is_integer(B), A < 0 ->
	pgcd(-A, B);
pgcd(A, B) when is_integer(A), is_integer(B), B < 0 ->
	pgcd(A, -B);
pgcd(A, B) when is_integer(A), is_integer(B), B == 0 ->
	A;
pgcd(A, B) when is_integer(A), is_integer(B) ->
	{_I, R} = divis_euclid(A, B),
	pgcd(B, R).

simpl_frac({A, B}) when is_integer(A), is_integer(B), A == 0 ->
	0;
simpl_frac({A, B}) when is_integer(A), is_integer(B), B < 0 ->
	simpl_frac({-A, -B});
simpl_frac({A, B}) when is_integer(A), is_integer(B) ->
	PGCD = pgcd(A, B),
	Tempo_Num = entier(A / PGCD),
	Tempo_Den = entier(B / PGCD),
	if
		Tempo_Den == 1 -> Tempo_Num;
		true -> {Tempo_Num, Tempo_Den}
	end.

prime(P) when is_integer(P), P == 1 ->
	false;
prime(P) when is_integer(P), P == 2 ->
	true;
prime(P) when is_integer(P), P > 1 ->
	prime(P, 2).

prime(P, N) when is_integer(P), is_integer(N) ->
	{_, R} = divis_euclid(P, N),
	Pow = pow(N, 2),
	if
		R == 0 -> false;
		Pow >= P -> true;
		true -> prime(P, N + 1)
	end.

find_prime_sup(N) when is_integer(N), N > 0 ->
	Tempo = prime(N + 1),
	if
		Tempo -> N + 1;
		true -> find_prime_sup(N + 1)
	end.
