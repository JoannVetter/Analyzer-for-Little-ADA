%{
void yyerror (char *s);
int yylex();
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "structures.h"
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

//le type file représente le fichier en entier
file        : lines                     {;};

// les lignes sont les parties du fichier
lines       : line '\n' lines           {;}
            | line                      {;}
            ;

// une ligne peut contenir une déclaration, un instruction ou une expression
line        : declaration               {;}
            | structInstruction         {;}
            | expression                {;}
            ;

// définition d'un type
type : identifiants 									   {;}
	 | identifiants rangeStr expression ptptStr expression {;}
	 ;

// règle récursive pour pouvoir avoir plusieurs déclarations
declarations : declaration declarations {;}
			 | declaration 				{;}
			 ;

declaration : declarationObjet                         																						   {;}
			//déclaration de type
			| typeStr identifiant isStr rangeStr expression ptptStr expression ptvirStr 												  	   {;}
			//déclaration de sous-type
			| subtypeStr identifiant isStr type ptvirStr 																				  	   {;}
			//renommage
			| identifiantsVirgule dpStr type renamesStr qualifIdentifiant ptvirStr 
			//les lignes ci dessous correspondent à la spécification de procédure														  	   {;}
			| procedureStr identifiant ptvirStr 																						       {;}
			| procedureStr identifiant pargStr parametres_def pardStr ptvirStr 															  	   {;}
			| procedureStr identifiant pargStr parametres_def pardStr isStr declarations beginStr instructions endStr ptvirStr			  	   {;}
			| procedureStr identifiant pargStr parametres_def pardStr isStr declarations beginStr instructions endStr identifiant ptvirStr	   {;}
			| procedureStr identifiant pargStr parametres_def pardStr isStr beginStr instructions endStr ptvirStr						  	   {;}
			| procedureStr identifiant pargStr parametres_def pardStr isStr beginStr instructions endStr identifiant ptvirStr  			  	   {;}
			//les lignes ci dessous correspondent à la spécification de fonction
			| functionStr identifiant returnStr identifiant ptvirStr 																	  	   {;}
			| functionStr identifiant returnStr qualifIdentifiant ptvirStr 																  	   {;}
			| functionStr identifiant pargStr parametres pardStr returnStr identifiant ptvirStr											  	   {;}
			| functionStr identifiant pargStr parametres pardStr returnStr qualifIdentifiant ptvirStr 									       {;}
			| functionStr identifiant pargStr parametres pardStr returnStr identifiant isStr beginStr instructions endStr ptvirStr 		       {;}
			| functionStr identifiant pargStr parametres pardStr returnStr qualifIdentifiant isStr beginStr instructions endStr ptvirStr       {;}
			| functionStr identifiant pargStr parametres pardStr returnStr identifiant isStr beginStr instructions endStr identifiant ptvirStr {;}
			| definition {;}
		;

definition : procedureStr identifiant isStr declarations beginStr instructions endStr ptvirStr 													  {;}
			| procedureStr identifiant isStr declarations beginStr instructions endStr identifiant ptvirStr 									  {;}
			| procedureStr identifiant parametres isStr declarations beginStr instructions endStr ptvirStr 										  {;}
			| procedureStr identifiant parametres isStr declarations beginStr instructions endStr identifiant ptvirStr 							  {;}
			| procedureStr identifiant isStr beginStr instructions endStr ptvirStr 																  {;}
			| procedureStr identifiant isStr beginStr instructions endStr identifiant ptvirStr 													  {;}
			| procedureStr identifiant parametres isStr beginStr instructions endStr ptvirStr 													  {;}
			| procedureStr identifiant parametres isStr beginStr instructions endStr identifiant ptvirStr										  {;}
			//le bloc au-dessus comporte toutes les définitions de procédure
			| functionStr identifiant returnStr identifiant isStr declarations beginStr instructions endStr ptvirStr 							  {;}
			| functionStr identifiant returnStr identifiant isStr declarations beginStr instructions endStr identifiant ptvirStr 				  {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr declarations beginStr instructions endStr ptvirStr 						  {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr declarations beginStr instructions endStr identifiant ptvirStr 			  {;}
			| functionStr identifiant parametres returnStr identifiant isStr declarations beginStr instructions endStr ptvirStr 				  {;}
			| functionStr identifiant parametres returnStr identifiant isStr declarations beginStr instructions endStr identifiant ptvirStr 	  {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr declarations beginStr instructions endStr ptvirStr 			  {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr declarations beginStr instructions endStr identifiant ptvirStr {;}
			| functionStr identifiant returnStr identifiant isStr beginStr instructions endStr ptvirStr 				 						  {;}
			| functionStr identifiant returnStr identifiant isStr beginStr instructions endStr identifiant ptvirStr 							  {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr beginStr instructions endStr ptvirStr 									  {;}
			| functionStr identifiant returnStr qualifIdentifiant isStr beginStr instructions endStr identifiant ptvirStr 						  {;}
			| functionStr identifiant parametres returnStr identifiant isStr beginStr instructions endStr ptvirStr 								  {;}
			| functionStr identifiant parametres returnStr identifiant isStr beginStr instructions endStr identifiant ptvirStr 					  {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr beginStr instructions endStr ptvirStr 						  {;}
			| functionStr identifiant parametres returnStr qualifIdentifiant isStr beginStr instructions endStr identifiant ptvirStr 			  {;}
			//le bloc au-dessus comporte toutes les définitions de fonction
			;

// définition d'un paramètre
parametre : identifiant 						{;}
		  | identifiant dpStr mode identifiants {;}
		  | identifiant dpStr identifiants 		{;}
          ;

parametres : parametre virStr parametres {;}
		   | parametre 					 {;}
		   //permet d'avoir plusieurs paramètres séparés par une virgule
		   ;

parametres_def : parametre ptvirStr parametres_def {;}
				 | parametre 					   {;}
				 //permet d'avoir plusieurs paramètres séparés pas des points virgules
				 ;

mode : inStr 		{;}
	 | inStr outStr {;}
	 | outStr 		{;}
	 ;

declarationObjet : identifiantsVirgule dpStr constantStr type dpegalStr expression ptvirStr {;}
				 | identifiantsVirgule dpStr constantStr dpegalStr expression ptvirStr 		{;}
				 | identifiantsVirgule dpStr constantStr type ptvirStr 						{;}
				 | identifiantsVirgule dpStr constantStr ptvirStr				      	    {;}
				 | identifiantsVirgule dpStr type dpegalStr expression ptvirStr 			{;}
				 | identifiantsVirgule dpStr type ptvirStr 									{;}				 
				 | identifiantsVirgule dpStr dpegalStr expression ptvirStr 					{;}
				 | identifiantsVirgule dpStr ptvirStr 										{;}
				 //ce bloc contient toutes les lignes possibles de déclarations d'objet
				 ;

// définition de une ou plusieurs étiquettes
etiquettes  : moinsmoinsStr identifiant plusplusStr etiquettes  {;}
            | moinsmoinsStr identifiant plusplusStr             {;}
            ;

// une instruction peut avoir ou non une étiquette devant elle
structInstruction   : etiquettes instruction    {;}
                    | instruction               {;}
                    ;

// définition d'une instruction
instruction : nullStr ptvirStr                                           	   {;} 
            | identifiants dpegalStr expression ptvirStr                 	   {;}
            | procedureCall                                         	 	   {;}
            | beginLoop instructions endLoop ptvirStr                    	   {;}
            | beginWhile instructions endLoop ptvirStr                   	   {;}
            | beginFor instructions endLoop ptvirStr                     	   {;}
            | conditionnelle                                        		   {;}
            | caseStr expression isStr alternatives endStr caseStr ptvirStr    {;}
            | gotoStr identifiant ptvirStr                                	   {;}
            | exitCase                                              		   {;}
            | returnStr ptvirStr                                          	   {;}
            | returnStr expression ptvirStr                               	   {;}
            ;

// début d'un boucle loop
beginLoop   : identifiant dpsautlinStr loopStr	{;}
            | loopStr                  			{;}
            ;

// fin d'un boucle, quelque soit le type de boucle
endLoop     : endStr loopStr identifiant    {;}
            | endStr loopStr                {;}
            ;
		
// début d'une boucle while
beginWhile  : identifiant dpsautlinStr whileStr expression loopStr     {;}
            | whileStr expression loopStr                     		   {;}
            ;

// début d'une boucle for
beginFor    : identifiant dpsautlinStr forStr forCondition loopStr     {;}
            | forStr forCondition loopStr                     		   {;}
            ;

// structure de la condition d'une boucle for
forCondition    : identifiant inStr reverseStr expression ptptStr expression {;}
                | identifiant inStr expression ptptStr expression            {;}
                | identifiant inStr reverseStr type               			 {;}
                | identifiant inStr type                          			 {;} 
                ;

// structure d'un bloc conditionnel
conditionnelle  : ifStr expression thenStr instructions elsifs elseStr instructions endStr ifStr ptvirStr   {;}
                | ifStr expression thenStr instructions elseStr instructions endStr ifStr ptvirStr          {;}
                | ifStr expression thenStr instructions elsifs endStr ifStr ptvirStr                        {;}
                | ifStr expression thenStr instructions endStr ifStr ptvirStr                               {;}
                ;

// structure des elsifs
elsifs  : elsifStr expression thenStr instructions elsifs {;}
        | elsifStr expression thenStr instructions        {;}
        ;

// définition des alternatives
alternatives    : whenStr multChoix flecheStr instructions alternatives   {;}
                | whenStr multChoix flecheStr instructions                {;}
                ;

// règle de récursion sur les choix
multChoix   : choix barreStr multChoix   {;}
            | choix                 	 {;}
            ;

// définition d'un choix
choix   : expression                    	{;}
        | expression ptptStr expression     {;}
        | othersStr                      	{;}
        ;

// définition d'un exit
exitCase    : exitStr identifiant whenStr expression ptvirStr  {;}
            | exitStr identifiant ptvirStr                     {;}
            | exitStr whenStr expression ptvirStr              {;}
            | exitStr ptvirStr                                 {;}

// permet d'avoir plusieurs instructions à la suite
instructions    : structInstruction instructions          {;}
                | structInstruction                       {;}
                ;

// définition de l'appel d'une fonction
procedureCall   : identifiants ptvirStr              			     {;}
                | identifiants pargStr expressions pardStr  ptvirStr {;}
                ;

// on représente les deux types d'identifiant pour factoriser le code
identifiants    : identifiant           {;}
                | qualifIdentifiant     {;}
			 	;

// permet d'avoir une liste d'expressions séparées par des virgules
expressions : expression virStr expressions {;}
			| expression				    {;}
			;

// Ce type permet d'avoir une liste d'identifiants séparés par des virgules		
identifiantsVirgule : identifiant virStr identifiantsVirgule {;}
			| identifiant				 					 {;}
			;

//dans ce type on représente toutes les expressions possibles
expression  : absStr expression						    {;}
			| notStr expression							{;}
			| tiretStr expression						{;}
			| expression symbole expression 			{;}
			| identifiants pargStr expressions pardStr  {;}
			| pargStr expression pardStr  				{;}
			| expression andStr expression 				{;}
			| expression orStr elseStr expression 		{;}
			| expression orStr expression 				{;}
			| expression xorStr expression 				{;}
			| expression andStr thenStr expression 		{;}
			| expression tiretStr expression 			{;}
			| baseConst                 				{;}
            | decConst                  				{;}
            | stringConst               				{;}
			| identifiants								{;}
			;



%%                     /* C code */

// fonction principale de lancement du programme
int main (void) {
	printf("1 : ");
	return yyparse();
}

// fonction d'erreur
void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 