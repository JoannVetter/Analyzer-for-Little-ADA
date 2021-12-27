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

type : identifiant {;}
	 | qualifIdentifiant {;}
	 | identifiant 'range' expression '..' expression {;}
	 | qualifIdentifiant 'range' expression '..' expression {;}
	 ;

declarations : declaration '\n'declarations {;}
			 | declaration {;}
			 | '' {;}
			 ;

declaration : declarationObjet                         {;}
			| 'type' identifiant 'is range' expression '..' expression ';' {;}
			| 'subtype' identifiant 'is' type ';' {;}
			| identifiants ':' type 'renames' qualifIdentifiant ';' {;}
			| 'procedure' identifiant ';' {;}
			| 'procedure' identifiant parametres ';' {;}
			| 'function' identifiant 'return' identifiant ';' {;}
			| 'function' identifiant 'return' qualifIdentifiant ';' {;}
			| 'function' identifiant parametres 'return' identifiant ';' {;}
			| 'function' identifiant parametres 'return' qualifIdentifiant ';' {;}
			| definition {;}
			;

definition : 'procedure' identifiant 'is' declarations 'begin' instructions 'end;' {;}
			| 'procedure' identifiant 'is' declarations 'begin' instructions 'end' identifiant ';' {;}
			| 'procedure' identifiant parametres 'is' declarations 'begin' instructions 'end;' {;}
			| 'procedure' identifiant parametres 'is' declarations 'begin' instructions 'end' identifiant ';' {;}
			| 'function' identifiant 'return' identifiant 'is' declarations 'begin' instructions 'end;' {;}
			| 'function' identifiant 'return' identifiant 'is' declarations 'begin' instructions 'end' identifiant ';' {;}
			| 'function' identifiant 'return' qualifIdentifiant 'is' declarations 'begin' instructions 'end;' {;}
			| 'function' identifiant 'return' qualifIdentifiant 'is' declarations 'begin' instructions 'end' identifiant ';' {;}
			| 'function' identifiant parametres 'return' identifiant 'is' declarations 'begin' instructions 'end;' {;}
			| 'function' identifiant parametres 'return' identifiant 'is' declarations 'begin' instructions 'end' identifiant ';' {;}
			| 'function' identifiant parametres 'return' qualifIdentifiant 'is' declarations 'begin' instructions 'end;' {;}
			| 'function' identifiant parametres 'return' qualifIdentifiant 'is' declarations 'begin' instructions 'end' identifiant ';' {;}
			;

parametre : identifiant {;}
		  | identifiant ':' mode identifiant {;}
		  | identifiant ':' mode qualifIdentifiant {;} 
          ;

parametres : parametre ',' parametres {;}
		   | parametre {;}
		   ;

mode : 'in' {;}
	 | 'in out' {;}
	 | 'out' {;}
	 | '' {;}
	 ;

declarationObjet : identifiants ': constant' type ':=' expression ';' {;}
				 | identifiants type ':=' expression ';' {;}
				 | identifiants ':=' expression ';' {;}
				 | identifiants type ';' {;}
				 | identifiants ': constant' expression ';' {;}
				 | identifiants ': constant' type ';' {;}
				 | identifiants ': constant' ';' {;}
				 | identifiants ': ;' {;}
				 ;

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

instructions : instruction '\n' instructions {;}
			 | instruction {;}
			 ;

expressions : expression ',' expressions {;}
			| expression				 {;}
			;
		
identifiants : identifiant ',' identifiants {;}
			| identifiant				 {;}
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