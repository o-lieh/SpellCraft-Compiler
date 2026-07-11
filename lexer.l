%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "symbol_table.h"
#include "parser.tab.h"

%}

WS      [ \t\r\n]+


%%
"mana"          { return MANA; }
"elixir"        { return ELIXIR; }
"cast_if"       { return CAST_IF; }
"cast_else"     { return CAST_ELSE; }
"begin_spell"   { return BEGIN_SPELL; }
"end_spell"     { return END_SPELL; }
"=>"            { return ASSIGN; }
"=="            { return EQ; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"~"             { return END_STMT; }

[0-9]+\.[0-9]+  { return FLOAT; }
[0-9]+          { return INTEGER; }

\$[a-zA-Z0-9]+  { yylval.str = strdup(yytext); return ID; }

[ \t\r\n]+      ;

.               { printf("Unknown token: %s\n", yytext); }

%%


int yywrap(void)
{
    return 1;
}