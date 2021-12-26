%{
void yyerror (char *s);
int yylex();
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
%}

%union {int num; char id;}
%start file
%token identifiant qualifIdentifiant baseConst decConst stringConst symbole

%%

file        : lines                     {;};

lines       : line '\n' lines           {;}
            | line                      {;}
            ;

line        : declaration               {;}
            | instruction               {;}
            | expression                {;}
            ;


declaration :                           {;};

instruction :                           {;};

expressions : expression ',' expressions {;}
			| expression				 {;}
			;

expression  : term                      {;}
			| 'abs ' expression			{;}
			| 'not ' expression			{;}
			| '- ' expression			{;}
			| expression symbole expression {;}
			| identifiant '('expressions')' {;}
			| qualifIdentifiant '('expressions')' {;}
			| '('expression')' {;}
			//et et ou coupe circuit pas compris mdr du coup il reste le then et le else
			;

term        : identifiant               {printf("identifiant");}
            | qualifIdentifiant         {printf("qualifIdentifiant");}
            | baseConst                 {printf("baseConst");}
            | decConst                  {printf("decConst");}
            | stringConst               {printf("stringConst");}
            ;


/* line    : assignment ';'		{;}
		| exit_command ';'		{exit(EXIT_SUCCESS);}
		| print exp ';'			{printf("Printing %d\n", $2);}
		| line assignment ';'	{;}
		| line print exp ';'	{printf("Printing %d\n", $3);}
		| line exit_command ';'	{exit(EXIT_SUCCESS);}
        ;

assignment : identifier '=' exp  { updateSymbolVal($1,$3); }
			;
exp    	: term                  {$$ = $1;}
       	| exp '+' term          {$$ = $1 + $3;}
       	| exp '-' term          {$$ = $1 - $3;}
       	;
term   	: number                {$$ = $1;}
		| identifier			{$$ = symbolVal($1);} 
        ; */

%%                     /* C code */

int main (void) {
	return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 