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

%token rangeStr ptptStr typeStr subtypeStr isStr renamesStr procedureStr functionStr 
%token returnStr beginStr nullStr caseStr gotoStr loopStr moinsmoinsStr plusplusStr 
%token whileStr forStr inStr reverseStr endStr ifStr thenStr elseStr elsifStr
%token whenStr flecheStr othersStr exitStr absStr notStr dpegalStr constantStr
%token outStr

%%

file        : lines                     {;};

lines       : line '\n' lines           {;}
            | line                      {;}
            ;

line        : declaration               {;}
            | structInstruction         {;}
            | expression                {;}
            ;

type : identifiant {;}
	 | qualifIdentifiant {;}
	 | identifiant rangeStr expression ptptStr expression {;}
	 | qualifIdentifiant rangeStr expression ptptStr expression {;}
	 ;

declarations : declaration '\n'declarations {;}
			 | declaration {;}
			 ;

declaration : declarationObjet                         {;}
			| typeStr identifiant isStr rangeStr  expression ptptStr expression ';' {;}
			| subtypeStr identifiant isStr type ';' {;}
			| identifiantsVirgule ':' type renamesStr qualifIdentifiant ';' {;}
			| procedureStr identifiant ';' {;}
			| procedureStr identifiant parametres ';' {;}
			| functionStr identifiant returnStr identifiant ';' {;}
			| functionStr identifiant returnStr qualifIdentifiant ';' {;}
			| functionStr identifiant parametres returnStr identifiant ';' {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant ';' {;}
			| definition {;}
			;

definition : procedureStr identifiant isStr declarations beginStr instructionsSaut endStr ';' {;}
			| procedureStr identifiant isStr declarations beginStr instructionsSaut endStr identifiant ';' {;}
			| procedureStr identifiant parametres isStr declarations beginStr instructionsSaut endStr ';' {;}
			| procedureStr identifiant parametres isStr declarations beginStr instructionsSaut endStr identifiant ';' {;}
			| functionStr identifiant returnStr identifiant isStr declarations beginStr instructionsSaut endStr ';' {;}
			| functionStr identifiant returnStr identifiant isStr declarations beginStr instructionsSaut endStr identifiant ';' {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr declarations beginStr instructionsSaut endStr ';' {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr declarations beginStr instructionsSaut endStr identifiant ';' {;}
			| functionStr identifiant parametres returnStr identifiant isStr declarations beginStr instructionsSaut endStr ';' {;}
			| functionStr identifiant parametres returnStr identifiant isStr declarations beginStr instructionsSaut endStr identifiant ';' {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr declarations beginStr instructionsSaut endStr ';' {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr declarations beginStr instructionsSaut endStr identifiant ';' {;}
			| procedureStr identifiant isStr beginStr instructionsSaut endStr ';' {;}
			| procedureStr identifiant isStr beginStr instructionsSaut endStr identifiant ';' {;}
			| procedureStr identifiant parametres isStr beginStr instructionsSaut endStr ';' {;}
			| procedureStr identifiant parametres isStr beginStr instructionsSaut endStr identifiant ';' {;}
			| functionStr identifiant returnStr identifiant isStr beginStr instructionsSaut endStr ';' {;}
			| functionStr identifiant returnStr identifiant isStr beginStr instructionsSaut endStr identifiant ';' {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr beginStr instructionsSaut endStr ';' {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr beginStr instructionsSaut endStr identifiant ';' {;}
			| functionStr identifiant parametres returnStr identifiant isStr beginStr instructionsSaut endStr ';' {;}
			| functionStr identifiant parametres returnStr identifiant isStr beginStr instructionsSaut endStr identifiant ';' {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr beginStr instructionsSaut endStr ';' {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr beginStr instructionsSaut endStr identifiant ';' {;}
			;

parametre : identifiant {;}
		  | identifiant ':' mode identifiants {;}
		  | identifiant ':' identifiants {;}

          ;

parametres : parametre ',' parametres {;}
		   | parametre {;}
		   ;

mode : inStr {;}
	 | inStr outStr {;}
	 | outStr {;}
	 ;

declarationObjet : identifiantsVirgule ':' constantStr type dpegalStr expression ';' {;}
				 | identifiantsVirgule type dpegalStr expression ';' {;}
				 | identifiantsVirgule dpegalStr expression ';' {;}
				 | identifiantsVirgule type ';' {;}
				 | identifiantsVirgule ':' constantStr expression ';' {;}
				 | identifiantsVirgule ':' constantStr type ';' {;}
				 | identifiantsVirgule ':' constantStr ';' {;}
				 | identifiantsVirgule ':' ';' {;}
				 ;

etiquettes  : moinsmoinsStr identifiant plusplusStr etiquettes  {;}
            | moinsmoinsStr identifiant plusplusStr             {;}
            ;

structInstruction   : etiquettes instruction    {;}
                    | instruction               {;}
                    ;

instruction : nullStr ';'                                            {;} 
            | identifiants dpegalStr expression ';'                      {;}
            | procedureCall                                         {;}
            | beginLoop instructions endLoop ';'                    {;}
            | beginWhile instructions endLoop ';'                   {;}
            | beginFor instructions endLoop ';'                     {;}
            | conditionnelle                                        {;}
            | caseStr expression isStr alternatives endStr caseStr ';'    {;}
            | gotoStr identifiant ';'                                {;}
            | exitCase                                              {;}
            | returnStr ';'                                          {;}
            | returnStr expression ';'                               {;}
            ;

beginLoop   : identifiant ':' loopStr    {;}
            | loopStr                    {;}
            ;

endLoop     : endStr loopStr identifiant    {;}
            | endStr loopStr                {;}
            ;

beginWhile  : identifiant ':' whileStr expression loopStr     {;}
            | whileStr expression loopStr                     {;}
            ;

beginFor    : identifiant ':' forStr forCondition loopStr     {;}
            | forStr forCondition loopStr                     {;}
            ;

forCondition    : identifiant inStr reverseStr expression ptptStr expression {;}
                | identifiant inStr expression ptptStr expression           {;}
                | identifiant inStr reverseStr identifiants               {;} // identifiants = type
                | identifiant inStr identifiants                          {;} // identifiants = type
                ;

conditionnelle  : ifStr expression thenStr instructions elsifs elseStr instructions endStr ifStr ';'   {;}
                | ifStr expression thenStr instructions elseStr instructions endStr ifStr ';'          {;}
                | ifStr expression thenStr instructions elsifs endStr ifStr ';'                       {;}
                | ifStr expression thenStr instructions endStr ifStr ';'                              {;}
                ;

elsifs  : elsifStr expression thenStr instructions elsifs {;}
        | elsifStr expression thenStr instructions        {;}
        ;

alternatives    : whenStr multChoix flecheStr instructions alternatives   {;}
                | whenStr multChoix flecheStr instructions                {;}
                ;

multChoix   : choix '|' multChoix   {;}
            | choix                 {;}
            ;

choix   : expression                    {;}
        | expression ptptStr expression    {;}
        | othersStr                      {;}
        ;

exitCase    : exitStr identifiant whenStr expression ';'  {;}
            | exitStr identifiant ';'                    {;}
            | exitStr whenStr expression ';'              {;}
            | exitStr ';'                                {;}

instructions    : instruction instructions          {;}
                | instruction                       {;}
                ;

procedureCall   : identifiants ';'              {;}
                | identifiants '(' expressions ')' ';' {;}
                ;

identifiants    : identifiant           {;}
                | qualifIdentifiant     {;}

instructionsSaut : instruction '\n' instructions {;}
			 | instruction {;}
			 ;

expressions : expression ',' expressions {;}
			| expression				 {;}
			;
		
identifiantsVirgule : identifiant ',' identifiantsVirgule {;}
			| identifiant				 {;}
			;

expression  : absStr expression			{;}
			| notStr expression			{;}
			| '-' expression			{;}
			| expression symbole expression {;}
			| identifiants '('expressions')' {;}
			| '('expression')' {;}
			| baseConst                 {printf("baseConst");}
            | decConst                  {printf("decConst");}
            | stringConst               {printf("stringConst");}
			//et et ou coupe circuit pas compris mdr du coup il reste le then et le else
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