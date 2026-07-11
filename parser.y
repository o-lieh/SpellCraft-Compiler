%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#include "symbol_table.h"

int yylex();
void yyerror(const char *s);

%}

%union
{
    char *str;
    DataType type;
}

%token MANA
%token ELIXIR

%token CAST_IF
%token CAST_ELSE

%token BEGIN_SPELL
%token END_SPELL

%token ASSIGN
%token EQ

%token PLUS
%token MINUS
%token MUL
%token DIV

%token LPAREN
%token RPAREN

%token END_STMT

%token <str> ID
%token INTEGER
%token FLOAT

%type <type> type
%type <type> expression
%type <type> condition

%left PLUS MINUS
%left MUL DIV

%%

program
    :
      statements
    ;

statements
    :
      statements statement
    |
    ;

statement
    :
      declaration
    | assignment
    | block
    | if_statement
    ;

type
    :
      MANA
      {
          $$ = TYPE_MANA;
      }
    |
      ELIXIR
      {
          $$ = TYPE_ELIXIR;
      }
    ;

declaration
    :
      type ID END_STMT
      {
          if (!insertSymbol($2,$1))
          {
              printf("Error: Spell %s is already conjured!\n",$2);
          }
	 free($2);
      }

    |
      type ID ASSIGN expression END_STMT
      {
          if (!insertSymbol($2,$1))
          {
              printf("Error: Spell %s is already conjured!\n",$2);
          }
          else
          {
              if ($1 == TYPE_MANA && $4 == TYPE_ELIXIR)
              {
                  printf("Warning: Alchemy error! Pours elixir into a mana vessel.\n");
              }
          }
	free($2);
      }
    ;

assignment
    :
      ID ASSIGN expression END_STMT
      {
          int index;

          index = lookupSymbol($1);

          if (index == -1)
          {
              printf("Error: Undefined spell %s.\n",$1);
          }
          else
          {
              DataType t;

              t = getType($1);

              if (t == TYPE_MANA && $3 == TYPE_ELIXIR)
              {
                  printf("Warning: Alchemy error! Pours elixir into a mana vessel.\n");
              }
          }
   
    free($1);

      }
    ;

block
    :
      BEGIN_SPELL
      {
          enterScope();
      }

      statements

      END_SPELL
      {
          exitScope();
      }
    ;

if_statement
    :
      CAST_IF LPAREN condition RPAREN block
    |
      CAST_IF LPAREN condition RPAREN block CAST_ELSE block
    ;

condition
    :
      expression EQ expression
      {
          $$ = TYPE_MANA;
      }
    ;

expression
    :
      expression PLUS expression
      {
          if ($1 == TYPE_ELIXIR || $3 == TYPE_ELIXIR)
              $$ = TYPE_ELIXIR;
          else
              $$ = TYPE_MANA;
      }

    |
      expression MINUS expression
      {
          if ($1 == TYPE_ELIXIR || $3 == TYPE_ELIXIR)
              $$ = TYPE_ELIXIR;
          else
              $$ = TYPE_MANA;
      }

    |
      expression MUL expression
      {
          if ($1 == TYPE_ELIXIR || $3 == TYPE_ELIXIR)
              $$ = TYPE_ELIXIR;
          else
              $$ = TYPE_MANA;
      }

    |
      expression DIV expression
      {
          if ($1 == TYPE_ELIXIR || $3 == TYPE_ELIXIR)
              $$ = TYPE_ELIXIR;
          else
              $$ = TYPE_MANA;
      }

    |
      LPAREN expression RPAREN
      {
          $$ = $2;
      }

    |
      ID
      {
          int index;

          index = lookupSymbol($1);

          if (index == -1)
          {
              printf("Error: Undefined spell %s.\n",$1);
              $$ = TYPE_UNKNOWN;
          }
          else
          {
              $$ = getType($1);
          }
	
    free($1);

      }

   |
INTEGER
{
    $$ = TYPE_MANA;
}

|
FLOAT
{
    $$ = TYPE_ELIXIR;
}
    ;

%%

void yyerror(const char *s)
{
    printf("Syntax Error: %s\n",s);
}