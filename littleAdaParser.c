#include <stdio.h>
#include "littleAdaParser.h"

extern int yylex();
extern yylineno;
extern char* yytext;

char *names[] = {
    "this should not be displayed",
    "TEST"
 };

int ntoken;

int process() {
    ntoken = yylex();
    if (!ntoken) {
        switch (ntoken) {
            case TEST: 
                fprintf("%s ", names[TEST]);
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