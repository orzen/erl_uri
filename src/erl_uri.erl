-module(erl_uri).

%% API exports
-export([
         build/0,
         parse/1
        ]).

-include_lib("eunit/include/eunit.hrl").

%%====================================================================
%% API functions
%%====================================================================

build() ->
    leex:file(erl_uri_lexer, [dfa_graph, {verbose, true}]),
    yecc:file(erl_uri_parser, [{verbose, true}]),
    compile:file(erl_uri_lexer),
    compile:file(erl_uri_parser).

parse(Str) ->
    {ok, Tokens, _Endline} = erl_uri_lexer:string(Str),
    {ok, Tree} = erl_uri_parser:parse(Tokens),
    Tree.

-ifdef(EUNIT).

absolute_p0_test() ->
    I = "https://john.doe@www.example.com:123/forum/questions/?tag=networking&order=newest#top",
    E = {absolute, [
                    {scheme, "https"},
                    {authority, [
                                 {userinfo, [{username, "john.doe"}]},
                                 {host, "www.example.com"},
                                 {port, "123"}
                                ]},
                    {path, "forum/questions/"},
                    {queries, ["tag=network", "order=newest"]},
                    {fragment, "top"}
                   ]},
    {uri, {absolute, A}} = parse(I),
    ?assertEqual(E, A).

absolute_p0_test() ->
    I = "https://john.doe@www.example.com:123/forum/questions/?tag=networking&order=newest#top",
    E = {absolute, [
                    {scheme, "https"},
                    {authority, [
                                 {userinfo, [{username, "john.doe"}]},
                                 {host, "www.example.com"},
                                 {port, "123"}
                                ]},
                    {path, "forum/questions/"},
                    {queries, ["tag=network", "order=newest"]},
                    {fragment, "top"}
                   ]},
    {uri, {absolute, A}} = parse(I),
    ?assertEqual(E, A).

-endif.
%%====================================================================
%% Internal functions
%%====================================================================
