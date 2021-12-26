%{
    #include "littleAdaParser.tab.h"
    void yyerror (char *s);
    int yylex();
%}

%%

[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*     {return identifiant;}
[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*(\.[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*)+     {return qualifIdentifiant;}
[0-9](_[0-9]|[0-9])*#[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*(\.[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*)?#([eE][+-]?[0-9](_[0-9]|[0-9])*)?     {return baseConst;}
[0-9](_[0-9]|[0-9])*(.[0-9](_[0-9]|[0-9])*)?([eE][+-]?[0-9](_[0-9]|[0-9])*)?    {return decConst;}
\"(""|(\"\"|[^\n\"])*)\"   {return stringConst;}
[ \t\n]                    ;
.                          {ECHO; yyerror ("unexpected character");};


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