-module(arbreOH).
-export([valeur/1, fils/2, path/2]).

valeur({A, L}) when is_list(L) ->
	A.

fils({_A, L}, N) when is_list(L), is_integer(N) ->
	listOH:nth(L, N).

path({_A, []}, [_A|_B]) ->
	error;
path({A, L}, []) when is_list(L) ->
	{A, L};
path({C, L}, [A|B]) when is_list(L) ->
	path(fils({C, L}, A), B).
