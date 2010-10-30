-module(listOH).
-export([appliquer/2, filtre/2, max/1, max/2, min/1, tri_rapide/1, tri_rapide/2, gen_lin/2, gen_recur/3, nth/2, taille/1]).

appliquer([], _) ->
	[];
appliquer([A| B], Fun) when is_function(Fun) ->
	[Fun(A) | appliquer(B, Fun)].

filtre([], _) ->
	[];
filtre([A|B], Fun) when is_function(Fun) ->
	Cond = Fun(A),
	if
		Cond -> [A | filtre(B, Fun) ];
		true -> filtre(B, Fun)
	end.

max([A|B]) ->
	max([A|B], fun(X, Y) -> if X > Y -> true; true -> false end end).

max([A|B], Fun) when is_function(Fun) ->
	max(B, Fun, A).

max([], _, X) ->
	X;
max([A|B], Fun, X) when is_function(Fun) ->
	Cond = Fun(A, X),
	if
		Cond -> max(B, Fun, A);
		true -> max(B, Fun, X)
	end.

min([A|B]) ->
	max([A|B], fun(X, Y) -> if X < Y -> true; true -> false end end).

tri_rapide(L) when is_list(L) ->
	tri_rapide(L, fun(X, Y) -> if X > Y -> true; true -> false end end).

tri_rapide([], _Comparer) ->
	[];
tri_rapide([A|B], Comparer) when is_function(Comparer) ->
	tri_rapide(B, Comparer, [], [], A).

tri_rapide([], Comparer, C, D, Pivot) when is_function(Comparer), is_list(C), is_list(D) ->
	Gauche = tri_rapide(C, Comparer),
	Droite = tri_rapide(D, Comparer),
	Gauche ++ [Pivot] ++ Droite;
tri_rapide([A|B], Comparer, C, D, Pivot) when is_function(Comparer), is_list(C), is_list(D) ->
	Cond = Comparer(A, Pivot),
	if
		Cond -> tri_rapide(B, Comparer, C, [A|D], Pivot);
		true -> tri_rapide(B, Comparer, [A|C], D, Pivot)
	end.

gen_lin(Fun, N) when is_function(Fun), is_integer(N), N > 0 ->
	gen_lin(Fun, N, 0).

gen_lin(Fun, N, M) when is_function(Fun), is_integer(N), is_integer(M), N > 0, M >= N ->
	[];
gen_lin(Fun, N, M) when is_function(Fun), is_integer(N), is_integer(M), N > 0, M >= 0 ->
	[Fun(M) | gen_lin(Fun, N, M + 1)].

gen_recur(Fun, N, O) when is_function(Fun), is_integer(N), N > 0 ->
	gen_recur(Fun, N, 0, O).

gen_recur(Fun, N, M, _O) when is_function(Fun), is_integer(N), is_integer(M), N > 0, M >=N ->
	[];
gen_recur(Fun, N, M, O) when is_function(Fun), is_integer(N), is_integer(M), N > 0, M >=0 ->
	Tempo = Fun(O),
	[Tempo | gen_recur(Fun, N, M + 1, Tempo)].

nth([], N) when is_integer(N), N >= 0 ->
	error;
nth([A|_B], N) when is_integer(N), N == 0 ->
	A;
nth([_A|B], N) when is_integer(N), N > 0 ->
	nth(B, N - 1).

taille(L) when is_list(L) ->
	taille(L, 0).

taille([], N) when is_integer(N) ->
	N;
taille([_A|B], N) when is_integer(N) ->
	taille(B, N + 1).
