Nonterminals uri absolute relative scheme authority path userinfo host port query queries fragment.

Terminals ':' '?' '#' '@' '=' '&' '/' '[' ']' int w_reg w_path w_any.

Rootsymbol uri.

uri -> absolute : {uri, '$1'}.
uri -> relative : {uri, '$1'}.

absolute -> scheme ':' '/' '/' authority '/' path '?' queries '#' fragment :
            {absolute, '$1', '$5', {path, '$7'}, {query, '$9'}, '$11'}.
absolute -> scheme ':' '/' '/' authority '/' path '?' queries :
            {absolute, '$1', '$5', {path, '$7'}, {query,'$9'}}.
absolute -> scheme ':' '/' '/' authority '/' path :
            {absolute, '$1', '$5', {path, '$7'}}.
absolute -> scheme ':' '/' '/' authority '?' queries :
            {absolute, '$1', '$5', {queries, '$7'}}.
absolute -> scheme ':' '/' '/' authority :
            {absolute, '$1', '$5'}.
absolute -> scheme ':' path :
            {absolute, '$1', {path, '$3'}}.

relative -> '/' path     : {relative, {path, '$2'}}.
relative -> '/' '/' path : {relative, {path, '$3'}}.
relative -> '#' fragment : {relative, '$1'}.

scheme -> word : {scheme, w('$1')}.

authority -> userinfo '@' host ':' port : {authority, ['$1', '$3', '$5']}.
authority -> userinfo '@' host          : {authority, ['$1', '$3']}.
authority -> host ':' port              : {authority, ['$1', '$3']}.
authority -> host                       : {authority, ['$1']}.

userinfo -> any ':' any :
    {userinfo, [{username, w('$1')}, {password, w('$3')}]}.
userinfo -> any : {userinfo, [{username, w('$1')}]}.

host -> '[' any ']' : {host, w('$2')}.
host -> word        : {host, w('$1')}.

port -> int      : {port, i('$1')}.

path -> word '/' path : concat([w('$1'), "/", '$3']).
path -> word ':' path : concat([w('$1'), ":", '$3']).
path -> word '/'      : concat([w('$1'), "/"]).
path -> word          : w('$1').

queries -> query '&' queries : ['$1'| '$3'].
queries -> query             : ['$1'].

% Wait an see if this is necessary
%query -> word '=' int.
query -> word '=' word : concat([w('$1'), "=", w('$3')]).

fragment -> word : {fragment, w('$1')}.

Erlang code.

i({int, _Line, Val}) ->
    Val.

w({word, _Line, Val}) ->
    Val.

concat(Strings) when is_list(Strings) ->
    unicode:characters_to_list(Strings).
