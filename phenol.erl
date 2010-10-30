-module(phenol).
-export([request/1, request/2, traduc/1]).

request([Head | Rest]) ->
	request(Head, Rest).

request(Commande, Arguments) when is_list(Commande), is_list(Arguments) ->
	request(list_to_atom(Commande), Arguments);
%%% Caser les commandes ici : %%%

request(get, [Argument1, Argument2 | _AutresArgus]) ->
	{Argument1, Argument2};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
request(_Commande, _Arguments) ->
	error.


traduc(Texte) when is_list(Texte) ->
	case re:compile("^Qui est ([a-zA-Z ]+) \\?$") of
		{ok, MP} ->
			case re:run(Texte, MP) of
				{match, [_Total, {Debut, Taille}]} ->
					string:substr(Texte, Debut + 1, Taille);
				_Autre ->
					error
			end;
		{error, Raison} ->
			{error, Raison}
	end.