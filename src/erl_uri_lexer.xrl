Definitions.

Int       = [0-9]+
Word      = [a-zA-Z0-9\.+-]+
Path      = [a-zA-Z0-9\.+-=]+
Any       = [^@\s]+

Rules.

:         : {token, {':', TokenLine}}.
\?        : {token, {'?', TokenLine}}.
#         : {token, {'#', TokenLine}}.
@         : {token, {'@', TokenLine}}.
=         : {token, {'=', TokenLine}}.
&         : {token, {'&', TokenLine}}.
/         : {token, {'/', TokenLine}}.
\[        : {token, {'[', TokenLine}}.
\]        : {token, {']', TokenLine}}.
{Int}     : {token, {int, TokenLine, TokenChars}}.
{Word}    : {token, {word, TokenLine, TokenChars}}.
{Path}    : {token, {path, TokenLine, TokenChars}}.
{Any}     : {token, {any, TokenLine, TokenChars}}.

Erlang code.
