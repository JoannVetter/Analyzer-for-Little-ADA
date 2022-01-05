%{
    #include "littleAdaParser.tab.h"
    void yyerror (char *s);
    int yylex();
%}

%%

(?i:range)       {return rangeStr;}
\.\.        {return ptptStr;}
(?:itype)        {return typeStr;}
(?i:subtype)     {return subtypeStr;}
(?i:is)          {return isStr;}
(?i:renames)     {return renamesStr;}
(?i:procedure)   {return procedureStr;}
(?i:function)    {return functionStr;}
(?i:return)      {return returnStr;}
(?i:begin)       {return beginStr;}
(?i:null)       {return nullStr;}
(?i:case)        {return caseStr;}
(?i:goto)        {return gotoStr;}
(?i:loop)        {return loopStr;}
\<\<        {return moinsmoinsStr;}
\>\>        {return plusplusStr;}
(?:iwhile)       {return whileStr;}
(?i:for)         {return forStr;}
(?i:in)          {return inStr;}
(?i:out)         {return outStr;}
(?i:reversed)    {return reverseStr;}
(?i:if)          {return ifStr;}
(?i:then)        {return thenStr;}
(?i:else)        {return elseStr;}
(?i:elsif)       {return elsifStr;}
(?i:when)        {return whenStr;}
=>          {return flecheStr;}
(?i:others)      {return othersStr;}
(?i:exit)        {return exitStr;}
(?i:abs)         {return absStr;}
(?i:not)         {return notStr;}
:=          {return dpegalStr;}
(?i:constant)    {return constantStr;}
:\n         {return dpsautlinStr;}
(?i:and)         {return andStr;}
(?i:or)          {return orStr;}
[+|-|*|/|**|=|/=|<=|>=|<|>|mod|rem|and|or|xor] {return symbole;}
[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*     {return identifiant;}
[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*(\.[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*)+     {return qualifIdentifiant;}
[0-9](_[0-9]|[0-9])*#[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*(\.[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*)?#([eE][+-]?[0-9](_[0-9]|[0-9])*)?     {return baseConst;}
[0-9](_[0-9]|[0-9])*(.[0-9](_[0-9]|[0-9])*)?([eE][+-]?[0-9](_[0-9]|[0-9])*)?    {return decConst;}
\"(""|(\"\"|[^\n\"])*)\"    {return stringConst;}
--.*\n                      ;
[ \t\n]                     ;
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