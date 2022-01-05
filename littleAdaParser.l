%{
    #include "littleAdaParser.tab.h"
    void yyerror (char *s);
    int yylex();
    int line_num = 1;
%}

%%
\;               {printf ("ptVir "); return ptvirStr;}
\:               {printf ("dp "); return dpStr;}
,                {printf ("vir "); return virStr;}
\|               {printf ("barre ");return barreStr;}
\(               {printf ("parg "); return pargStr;}
\)               {printf ("pard "); return pardStr;}
-                {printf ("tiret "); return tiretStr;}
(?i:range)       {printf ("range ");return rangeStr;}
(?i:\.\.)        {printf (".. ");return ptptStr;}
(?i:type)        {printf ("type ");return typeStr;}
(?i:subtype)     {printf ("subtype ");return subtypeStr;}
(?i:is)          {printf ("is ");return isStr;}
(?i:renames)     {printf ("renames ");return renamesStr;}
(?i:procedure)   {printf ("procedure ");return procedureStr;}
(?i:function)    {printf ("function ");return functionStr;}
(?i:return)      {printf ("return ");return returnStr;}
(?i:begin)       {printf ("begin ");return beginStr;}
(?i:null)        {printf ("null ");return nullStr;}
(?i:case)        {printf ("case ");return caseStr;}
(?i:goto)        {printf ("goto ");return gotoStr;}
(?i:loop)        {printf ("loop ");return loopStr;}
\<\<             {printf ("<< ");return moinsmoinsStr;}
\>\>             {printf (">> ");return plusplusStr;}
(?i:while)       {printf ("while ");return whileStr;}
(?i:for)         {printf ("for ");return forStr;}
(?i:in)          {printf ("in ");return inStr;}
(?i:out)         {printf ("out ");return outStr;}
(?i:reverse)     {printf ("reverse ");return reverseStr;}
(?i:if)          {printf ("if ");return ifStr;}
(?i:then)        {printf ("then ");return thenStr;}
(?i:else)        {printf ("else ");return elseStr;}
(?i:elsif)       {printf ("elsif ");return elsifStr;}
(?i:when)        {printf ("when ");return whenStr;}
(?i:=>)          {printf ("=> ");return flecheStr;}
(?i:others)      {printf ("others ");return othersStr;}
(?i:exit)        {printf ("exit ");return exitStr;}
(?i:abs)         {printf ("abs ");return absStr;}
(?i:not)         {printf ("not ");return notStr;}
(?i::=)          {printf (":= ");return dpegalStr;}
(?i:constant)    {printf ("constant ");return constantStr;}
(?i::\n)         {printf ("saut_ligne ");return dpsautlinStr;}
(?i:and)         {printf ("and ");return andStr;}
(?i:or)          {printf ("or ");return orStr;}
(?i:end)         {printf ("end "); return endStr;}
(?i:xor)         {printf ("xor ");return xorStr;}
\/=              {printf ("symbole "); return symbole;}
\*\*             {printf ("symbole "); return symbole;}
\<=              {printf ("symbole "); return symbole;}
\>=              {printf ("symbole "); return symbole;}
mod              {printf ("symbole "); return symbole;}
rem              {printf ("symbole "); return symbole;}   
[+|*|/|=|<|>]    {printf ("symbole "); return symbole;}
[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*     {printf("identifiant "); return identifiant;}
[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*(\.[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*)+     {printf("identifiant_qualifie ");return qualifIdentifiant;}
[0-9](_[0-9]|[0-9])*#[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*(\.[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*)?#([eE][+-]?[0-9](_[0-9]|[0-9])*)?     {printf("baseConst ");return baseConst;}
[0-9](_[0-9]|[0-9])*(.[0-9](_[0-9]|[0-9])*)?([eE][+-]?[0-9](_[0-9]|[0-9])*)?    {printf("decConst ");return decConst;}
\"(""|(\"\"|[^\n\"])*)\"    {printf("stringConst ");return stringConst;}
--.*\n                      {line_num++; printf("\n%d : ", line_num);};
[ \t]                       ;
\n                          {line_num++; printf("\n%d : ", line_num);};
.                           {ECHO; yyerror ("error : unexpected character");};


%%
int yywrap() {}