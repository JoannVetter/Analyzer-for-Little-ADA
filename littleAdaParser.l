%{
    #include "littleAdaParser.tab.h"
    void yyerror (char *s);
    int yylex();
%}

%%

range       {return rangeStr;}
\.\.        {return ptptStr;}
type        {return typeStr;}
subtype     {return subtypeStr;}
is          {return isStr;}
renames     {return renamesStr;}
procedure   {return procedureStr;}
function    {return functionStr;}
return      {return returnStr;}
begin       {return beginStr;}
null        {return nullStr;}
case        {return caseStr;}
goto        {return gotoStr;}
loop        {return loopStr;}
\<\<          {return moinsmoinsStr;}
\>\>          {return plusplusStr;}
while       {return whileStr;}
for         {return forStr;}
in          {return inStr;}
out         {return outStr;}
reversed    {return reverseStr;}
if          {return ifStr;}
then        {return thenStr;}
else        {return elseStr;}
elsif       {return elsifStr;}
when        {return whenStr;}
=>          {return flecheStr;}
others      {return othersStr;}
exit        {return exitStr;}
abs         {return absStr;}
not         {return notStr;}
:=          {return dpegalStr;}
constant    {return constantStr;}
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