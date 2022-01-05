%{
    #include "littleAdaParser.tab.h"
    void yyerror (char *s);
    int yylex();
    int line_num = 1;
%}

%%
\;               {printf ("ptVir \n"); return ptvirStr;}
\:               {printf ("dp \n"); return dpStr;}
,                {printf ("vir \n"); return virStr;}
\|                {printf ("barre \n");return barreStr;}
\(                {printf ("parg \n"); return pargStr;}
\)                {printf ("pard \n"); return pardStr;}
-                {printf ("tiret \n"); return tiretStr;}
(?i:range)       {printf ("range\n");return rangeStr;}
(?i:\.\.)        {printf ("..\n");return ptptStr;}
(?i:type)        {printf ("type\n");return typeStr;}
(?i:subtype)     {printf ("subtype\n");return subtypeStr;}
(?i:is)          {printf ("is\n");return isStr;}
(?i:renames)     {printf ("renames\n");return renamesStr;}
(?i:procedure)   {printf ("procedure\n");return procedureStr;}
(?i:function)    {printf ("function\n");return functionStr;}
(?i:return)      {printf ("return\n");return returnStr;}
(?i:begin)       {printf ("begin\n");return beginStr;}
(?i:null)        {printf ("null\n");return nullStr;}
(?i:case)        {printf ("case\n");return caseStr;}
(?i:goto)        {printf ("goto \n");return gotoStr;}
(?i:loop)        {printf ("loop \n");return loopStr;}
\<\<        {printf ("<< \n");return moinsmoinsStr;}
\>\>        {printf (">> \n");return plusplusStr;}
(?i:while)       {printf ("while \n");return whileStr;}
(?i:for)         {printf ("for\n");return forStr;}
(?i:in)          {printf ("in \n");return inStr;}
(?i:out)         {printf ("out \n");return outStr;}
(?i:reverse)    {printf ("reverse \n");return reverseStr;}
(?i:if)          {printf ("if \n");return ifStr;}
(?i:then)        {printf ("then \n");return thenStr;}
(?i:else)        {printf ("else \n");return elseStr;}
(?i:elsif)       {printf ("elsif \n");return elsifStr;}
(?i:when)        {printf ("when \n");return whenStr;}
(?i:=>)          {printf (" => \n");return flecheStr;}
(?i:others)      {printf ("others \n");return othersStr;}
(?i:exit)        {printf ("exit \n");return exitStr;}
(?i:abs)         {printf ("abs \n");return absStr;}
(?i:not)         {printf ("not \n");return notStr;}
(?i::=)          {printf (":= \n");return dpegalStr;}
(?i:constant)    {printf ("constant\n");return constantStr;}
(?i::\n)         {printf (":saut de ligne\n");return dpsautlinStr;}
(?i:and)         {printf ("and \n");return andStr;}
(?i:or)          {printf ("or \n");return orStr;}
(?i:end)         {printf ("end \n"); return endStr;}
(?i:xor)         {printf ("xor \n");return xorStr;}
\/=              {printf ("symbole \n"); return symbole;}
\*\*             {printf ("symbole \n"); return symbole;}
\<=              {printf ("symbole \n"); return symbole;}
\>=              {printf ("symbole \n"); return symbole;}
mod              {printf ("symbole \n"); return symbole;}
rem              {printf ("symbole \n"); return symbole;}   
[+|*|/|=|<|>]  {printf ("symbole\n");return symbole;}
[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*     {printf("identifiant\n");return identifiant;}
[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*(\.[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*)+     {printf("identifiant qualifié\n");return qualifIdentifiant;}
[0-9](_[0-9]|[0-9])*#[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*(\.[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*)?#([eE][+-]?[0-9](_[0-9]|[0-9])*)?     {printf("baseConst \n");return baseConst;}
[0-9](_[0-9]|[0-9])*(.[0-9](_[0-9]|[0-9])*)?([eE][+-]?[0-9](_[0-9]|[0-9])*)?    {printf("decConst \n");return decConst;}
\"(""|(\"\"|[^\n\"])*)\"    {printf("stringConst \n");return stringConst;}
--.*\n                      {line_num++; printf("%d ", line_num);};
[ \t]                       ;
\n                          {line_num++; printf("%d ", line_num);};
.                           {ECHO; yyerror ("unexpected character");};


%%

int yywrap() {}

/* const char const* names[] = {
    "this should not be displayed",
    "IDENTIFIANT",
    "BASECONST",
    "DECCONST",
    "STRINGCONST",
    "IDENTIFIANT_QUALIFIE"
 };

int ntoken;

int process() {
    ntoken = yylex();
    if (ntoken) {
        switch (ntoken) {
            case IDENTIFIANT:
                printf(names[IDENTIFIANT]);
                break;
            case BASECONST:
                printf(names[BASECONST]);
                break;
            case IDENTIFIANT_QUALIFIE:
                printf(names[IDENTIFIANT_QUALIFIE]);
                break;
            case DECCONST:
                printf(names[DECCONST]);
                break;
            case STRINGCONST:
                printf(names[STRINGCONST]);
                break;
        }
        process();
    }
    else {
        printf("\n");
        return 0;
    }
} */