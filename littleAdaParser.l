%{
    #include "littleAdaParser.h"
%}

%%

[a-zA-Z](_[a-zA-Z1-9]|[a-zA-Z1-9])*     return IDENTIFIANT;
.                                       printf("unexpected character\n");


%%

int yywrap() {}

const char const* names[] = {
    "this should not be displayed",
    "IDENTIFIANT"
 };

int ntoken;

int process() {
    ntoken = yylex();
    if (ntoken) {
        switch (ntoken) {
            case IDENTIFIANT: 
                printf(names[IDENTIFIANT]);
                break;
        }
        process();
    }
    else {
        return 0;
    }
}

int main(void) {
    return process();
}