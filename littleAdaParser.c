#include <stdio.h>
#include "littleAdaParser.h"

extern int yylex();
extern yylineno;
extern char* yytext;

char *names[] = {"FILE"};

int main(void) {

    int ntoken, vtoken;

    ntoken = yylex();
    while(ntoken) {
        switch (ntoken) {
            case FILEE: 
                fprintf("%s ", names[FILEE]);
                break;
        }
    }
}