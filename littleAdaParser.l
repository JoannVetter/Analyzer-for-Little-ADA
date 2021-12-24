%{
    #include "littleAdaParser.h"
%}

%%

[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*     return IDENTIFIANT;
[0-9](_[0-9]|[0-9])*#[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*(\.[0-9a-fA-F](_[0-9a-fA-F]|[0-9a-fA-F])*)?#([eE][+-]?[0-9](_[0-9]|[0-9])*)?     return BASECONST;
.                                       printf("unexpected character\n");


%%

int yywrap() {}

const char const* names[] = {
    "this should not be displayed",
    "IDENTIFIANT",
    "BASECONST"
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
        }
        process();
    }
    else {
        printf("\n");
        return 0;
    }
}

int main(void) {
    return process();
}