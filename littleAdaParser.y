%{
void yyerror (char *s);
int yylex();
int yydebug = 1;
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
%token outStr dpsautlinStr andStr orStr ptvirStr dpStr virStr barreStr pargStr
%token pardStr xorStr

%left symbole tiretStr notStr absStr andStr thenStr
%right orStr elseStr xorStr

%%

file        : lines                     {;};

lines       : line '\n' lines           {;}
            | line                      {;}
            ;

line        : declaration               {;}
            | structInstruction         {;}
            | expression                {;}
            ;

type : identifiants {;}
	 | identifiants rangeStr expression ptptStr expression {;}
	 ;

declarations : declaration declarations {;}
			 | declaration {;}
			 ;

declaration : declarationObjet                         {;}
			| typeStr identifiant isStr rangeStr expression ptptStr expression ptvirStr {;}
			| subtypeStr identifiant isStr type ptvirStr {;}
			| identifiantsVirgule dpStr type renamesStr qualifIdentifiant ptvirStr {;}
			| procedureStr identifiant ptvirStr {;}
			| procedureStr identifiant pargStr parametres_def pardStr ptvirStr {;}
			| procedureStr identifiant pargStr parametres_def pardStr isStr declarations beginStr instructionsSaut endStr ptvirStr{;}
			| procedureStr identifiant pargStr parametres_def pardStr isStr declarations beginStr instructionsSaut endStr identifiant ptvirStr{;}
			| procedureStr identifiant pargStr parametres_def pardStr isStr beginStr instructionsSaut endStr ptvirStr{;}
			| procedureStr identifiant pargStr parametres_def pardStr isStr beginStr instructionsSaut endStr identifiant ptvirStr{;}
			| functionStr identifiant returnStr identifiant ptvirStr {;}
			| functionStr identifiant returnStr qualifIdentifiant ptvirStr {;}
			| functionStr identifiant pargStr parametres pardStr returnStr identifiant ptvirStr {;}
			| functionStr identifiant pargStr parametres pardStr returnStr qualifIdentifiant ptvirStr {;}
			| functionStr identifiant pargStr parametres pardStr returnStr identifiant isStr beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant pargStr parametres pardStr returnStr qualifIdentifiant isStr beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant pargStr parametres pardStr returnStr identifiant isStr beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| definition {;}
			;

definition : procedureStr identifiant isStr declarations beginStr instructionsSaut endStr ptvirStr {;}
			| procedureStr identifiant isStr declarations beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| procedureStr identifiant parametres isStr declarations beginStr instructionsSaut endStr ptvirStr {;}
			| procedureStr identifiant parametres isStr declarations beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| functionStr identifiant returnStr identifiant isStr declarations beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant returnStr identifiant isStr declarations beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr declarations beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr declarations beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| functionStr identifiant parametres returnStr identifiant isStr declarations beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant parametres returnStr identifiant isStr declarations beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr declarations beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr declarations beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| procedureStr identifiant isStr beginStr instructionsSaut endStr ptvirStr {;}
			| procedureStr identifiant isStr beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| procedureStr identifiant parametres isStr beginStr instructionsSaut endStr ptvirStr {;}
			| procedureStr identifiant parametres isStr beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| functionStr identifiant returnStr identifiant isStr beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant returnStr identifiant isStr beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| functionStr identifiant parametres returnStr identifiant isStr beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant parametres returnStr identifiant isStr beginStr instructionsSaut endStr identifiant ptvirStr {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr beginStr instructionsSaut endStr ptvirStr {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr beginStr instructionsSaut endStr identifiant ptvirStr {;}
			;

parametre : identifiant {;}
		  | identifiant dpStr mode identifiants {;}
		  | identifiant dpStr identifiants {;}

          ;

parametres : parametre virStr parametres {;}
		   | parametre {;}
		   ;

parametres_def : parametre ptvirStr parametres_def {;}
				 | parametre {;}
				 ;

mode : inStr {;}
	 | inStr outStr {;}
	 | outStr {;}
	 ;

declarationObjet : identifiantsVirgule dpStr constantStr type dpegalStr expression ptvirStr {;}
				 | identifiantsVirgule dpStr constantStr dpegalStr expression ptvirStr {;}
				 | identifiantsVirgule dpStr constantStr type ptvirStr {;}
				 | identifiantsVirgule dpStr constantStr ptvirStr {;}
				 | identifiantsVirgule dpStr type dpegalStr expression ptvirStr {;}
				 | identifiantsVirgule dpStr type ptvirStr {;}				 
				 | identifiantsVirgule dpStr dpegalStr expression ptvirStr {;}
				 | identifiantsVirgule dpStr ptvirStr {;}
				 ;

etiquettes  : moinsmoinsStr identifiant plusplusStr etiquettes  {;}
            | moinsmoinsStr identifiant plusplusStr             {;}
            ;

structInstruction   : etiquettes instruction    {;}
                    | instruction               {;}
                    ;

instruction : nullStr ptvirStr                                            {;} 
            | identifiants dpegalStr expression ptvirStr                      {;}
            | procedureCall                                         {;}
            | beginLoop instructions endLoop ptvirStr                    {;}
            | beginWhile instructions endLoop ptvirStr                   {;}
            | beginFor instructions endLoop ptvirStr                     {;}
            | conditionnelle                                        {;}
            | caseStr expression isStr alternatives endStr caseStr ptvirStr    {;}
            | gotoStr identifiant ptvirStr                                {;}
            | exitCase                                              {;}
            | returnStr ptvirStr                                          {;}
            | returnStr expression ptvirStr                               {;}
            ;

beginLoop   : identifiant dpsautlinStr loopStr	{;}
            | loopStr                  		{;}
            ;

endLoop     : endStr loopStr identifiant    {;}
            | endStr loopStr                {;}
            ;

beginWhile  : identifiant dpsautlinStr whileStr expression loopStr     {;}
            | whileStr expression loopStr                     {;}
            ;

beginFor    : identifiant dpsautlinStr forStr forCondition loopStr     {;}
            | forStr forCondition loopStr                     {;}
            ;

forCondition    : identifiant inStr reverseStr expression ptptStr expression {;}
                | identifiant inStr expression ptptStr expression           {;}
                | identifiant inStr reverseStr type               {;}
                | identifiant inStr type                          {;} 
                ;

conditionnelle  : ifStr expression thenStr instructions elsifs elseStr instructions endStr ifStr ptvirStr   {;}
                | ifStr expression thenStr instructions elseStr instructions endStr ifStr ptvirStr          {;}
                | ifStr expression thenStr instructions elsifs endStr ifStr ptvirStr                       {;}
                | ifStr expression thenStr instructions endStr ifStr ptvirStr                              {;}
                ;

elsifs  : elsifStr expression thenStr instructions elsifs {;}
        | elsifStr expression thenStr instructions        {;}
        ;

alternatives    : whenStr multChoix flecheStr instructions alternatives   {;}
                | whenStr multChoix flecheStr instructions                {;}
                ;

multChoix   : choix barreStr multChoix   {;}
            | choix                 {;}
            ;

choix   : expression                    {;}
        | expression ptptStr expression    {;}
        | othersStr                      {;}
        ;

exitCase    : exitStr identifiant whenStr expression ptvirStr  {;}
            | exitStr identifiant ptvirStr                    {;}
            | exitStr whenStr expression ptvirStr              {;}
            | exitStr ptvirStr                                {;}

instructions    : structInstruction instructions          {;}
                | structInstruction                       {;}
                ;

procedureCall   : identifiants ptvirStr              {printf("procedureCall\n");}
                | identifiants pargStr expressions pardStr  ptvirStr {;}
                ;

identifiants    : identifiant           {;}
                | qualifIdentifiant     {;}

instructionsSaut : structInstruction instructions {;}
			 	 | structInstruction {;}
			 ;

expressions : expression virStr expressions {;}
			| expression				 {;}
			;

		
identifiantsVirgule : identifiant virStr identifiantsVirgule {;}
			| identifiant				 {;}
			;

expression  : absStr expression			{;}
			| notStr expression			{;}
			| tiretStr expression			{;}
			| expression symbole expression {;}
			| identifiants pargStr expressions pardStr  {;}
			| pargStr expression pardStr  {;}
			| expression andStr expression {;}
			| expression orStr elseStr expression {;}
			| expression orStr expression {;}
			| expression xorStr expression {;}
			| expression andStr thenStr expression {;}
			| expression tiretStr expression {;}
			| baseConst                 {;}
            | decConst                  {;}
            | stringConst               {;}
			| identifiants				{;}
			;



%%                     /* C code */

int main (void) {
	return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 