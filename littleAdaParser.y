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
            | structInstruction               {;}
            | expression                {;}
            ;


declaration :                           {;};

etiquettes  : '<<' identifiant '>>' etiquettes  {;}
            | '<<' identifiant '>>'             {;}
            ;

structInstruction   : etiquettes instruction    {;}
                    | instruction               {;}
                    ;

instruction : 'null' ';'                                            {;} 
            | identifiants ':=' expression ';'                      {;}
            | procedureCall                                         {;}
            | beginLoop instructions endLoop ';'                    {;}
            | beginWhile instructions endLoop ';'                   {;}
            | beginFor instructions endLoop ';'                     {;}
            | conditionnelle                                        {;}
            | 'case' expression 'is' alternatives 'end case' ';'    {;}
            | 'goto' identifiant ';'                                {;}
            | exitCase                                              {;}
            | 'return' ';'                                          {;}
            | 'return' expression ';'                               {;}
            ;

beginLoop   : identifiant ':' 'loop'    {;}
            | 'loop'                    {;}
            ;

endLoop     : 'end loop' identifiant    {;}
            | 'end loop'                {;}
            ;

beginWhile  : identifiant ':' 'while' expression 'loop'     {;}
            | 'while' expression 'loop'                     {;}
            ;

beginFor    : identifiant ':' 'for' forCondition 'loop'     {;}
            | 'for' forCondition 'loop'                     {;}
            ;

forCondition    : identifiant 'in' 'reverse' expression '..' expression {;}
                | identifiant 'in' expression '..' expression           {;}
                | identifiant 'in' 'reverse' identifiants               {;} // identifiants = type
                | identifiant 'in' identifiants                          {;} // identifiants = type
                ;

conditionnelle  : 'if' expression 'then' instructions elsifs 'else' instructions 'end if' ';'   {;}
                | 'if' expression 'then' instructions 'else' instructions 'end if' ';'          {;}
                | 'if' expression 'then' instructions elsifs 'end if' ';'                       {;}
                | 'if' expression 'then' instructions 'end if' ';'                              {;}
                ;

elsifs  : 'elsif' expression 'then' instructions elsifs {;}
        | 'elsif' expression 'then' instructions        {;}
        ;

alternatives    : 'when' multChoix '=>' instructions alternatives   {;}
                | 'when' multChoix '=>' instructions                {;}
                ;

multChoix   : choix '|' multChoix   {;}
            | choix                 {;}
            ;

choix   : expression                    {;}
        | expression '..' expression    {;}
        | 'others'                      {;}
        ;

exitCase    : 'exit' identifiant 'when' expression ';'  {;}
            | 'exit' identifiant ';'                    {;}
            | 'exit' 'when' expression ';'              {;}
            | 'exit' ';'                                {;}

instructions    : instruction instructions          {;}
                | instruction                       {;}
                ;

procedureCall   : identifiants ';'              {;}
                | identifiants '(' expressions ')' ';' {;}
                ;

identifiants    : identifiant           {;}
                | qualifIdentifiant     {;}

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