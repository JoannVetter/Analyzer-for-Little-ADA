#include "structures.h"


struct filee {
    int i;
    line* ln;
};

//ce struct représente une ligne et stocke la suivante
struct line {
    line* next;
    int type;
    union {
        declaration* dec;
        expression* expr;
        instruction* def;
    } u;
};

//permet de gérer gracieusement les types
struct isRange
{
    identif* nom;
    tupleChoix theRange;
};

struct type
{
    int type;
    union {
        identif* nom;
        isRange theRange;
    } u;
};

struct declaration {
    int type;
    union {
        fonctionSpec* fctSpec; //spécification de fonction
        procedureSpec* prcSpec; //spécification de procédure
        fonctionDef* fctDef; //définition de fonction
        procedureDef* prcDef; //définition de fonction
        object* obj; //définition d'objet
        type* typeDec; //déclaration de type
        subtypeDec* subDec; //déclaration de sous type
    } u;
    declaration* next;
};

struct subtypeDec
{
        identif* nom;
        type* type;
};

struct object
{
    identif* nom;
    int constant; //0 si pas le mot clé et 1 sinon
    type* type;
    definition* def;
    
};

struct definition
{
    expression* expr;
};


struct expression {
    int type;
    union {
        identif* id;
        constante* cte;
        preExpression* preExp;
        symboleExpressions* symbolExp;
        procedureCall* convTypeOuFonctCall;
    } u;
    int paretheses; // joue le rôle d'un booléen qui définit si l'expression possède des parenthèses autour d'elle
};

struct preExpression {
    char* symbolePreExp;
    expression* expr;
};

struct symboleExpressions {
    char* symbole;
    expression* exprDroite;
    expression* exprGauche;
};

struct instruction {
    int type;
    union {
        void* empty;
        affectation* afct;
        procedureCall* procCall;
        loop* lp;
        whileLoop* whl;
        forLoop* fr;
        condition* cond;
        distCas* cases;
        identif* jmp_etiquette;
        sortie* out;
        void* procedret;
        expression* fonctret;
    } u;
    instruction* next;
};

struct constante {
    int type;
    union {
        double* cteDec;
        constanteBase* i;
        char* cteStr;
    } u;
};

struct constanteBase {
    int base;
    char* nb;
};

struct affectation {
    identif* id;
    constante* valeur;
};

struct procedureCall {
    identif* nom;
    expression args[100];
};

struct loop {
    identif* nom;
    instruction* inst;
};

struct whileLoop {
    identif* nom;
    instruction* inst;
    expression* cond;
};

struct forLoop {
    identif* nom;
    instruction* inst;
    expression* cond;
};

struct condition {
    expression* cond;
    instruction* trueCond;
    instruction* falseCond;
};

struct distCas {
    alternative alters[100];
};

struct alternative {
    expression choix[100];
    tupleChoix rangeChoix[100];
    int others; // joue le rôle de booléen indiquant si others fait partie des choix
};

struct tupleChoix {
    expression* expression1;
    expression* expression2;
};

struct sortie {
    identif* nom_boucle;
    expression* cond;
};

struct fonctionSpec {

    identif* nom;
    identif param[100];
    identif* returnType;
};

struct procedureSpec {
    identif* nom;
    identif param[100];
};

struct fonctionDef {
    identif* nom;
    identif param[100];
    identif* returnType;
    declaration* decla;
    instruction* inst;
};

struct procedureDef {
    identif* nom;
    identif param[100];
    declaration* decla;
    instruction* inst;
};

struct identif {
    char* name;
};
