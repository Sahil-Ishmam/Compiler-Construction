%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.c"   // symbol table implementation

extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern int lineno;

void yyerror(const char *s);
%}

%union {
    int ival;     // for numbers and type codes
    char *sval;   // for identifiers
    char cval;    // for char constants
}

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%token <sval> ID
%token <ival> NUMBER
%token <cval> CHAR_CONST
%token INT CHAR DOUBLE IF ELSE

%token ASSIGN GT LT GE LE EQ NE SEMI LBRACE RBRACE LPAREN RPAREN

%type <ival> type expr

%token DOUBLE_NUM

%%

program:
    statements { printf("Parsing finished!\n"); }
    ;

declaration:
    type ID SEMI {
        if (is_declared($2)) {
            printf("In line no %d, Same variable %s is declared more than once.\n", lineno, $2);
        } else {
            insert($2, $1, lineno);
        }
        free($2);
    };

type:
    INT    { $$ = INT_TYPE; }
    | CHAR { $$ = CHAR_TYPE; }
    | DOUBLE { $$ = DOUBLE_TYPE; }
    ;

statements:
    /* empty */
    | statements statement
    ;

statement:
    assignment
    | if_statement
    | declaration      /* allow declarations in blocks */
    | LBRACE statements RBRACE /* allow blocks as statements */
    | SEMI             /* allow empty statements */
    ;

assignment:
    ID ASSIGN expr SEMI {
        if (!is_declared($1)) {
            printf("In line no %d, ID %s is not declared.\n", lineno, $1);
        } else {
            int id_type = get_type($1);
            int expr_type = $3; /* expr returns the type code */
            if (id_type != UNDEF_TYPE && expr_type != UNDEF_TYPE && id_type != expr_type) {
                printf("In line no %d, Data type %s is not matched with Data type %s.\n",
                       lineno, typename[expr_type], typename[id_type]);
            }
        }
        free($1);
    };

expr:
    NUMBER       { $$ = INT_TYPE; }         /* integer literal */
  | DOUBLE_NUM   { $$ = DOUBLE_TYPE; }      /* double literal */
  | CHAR_CONST   { $$ = CHAR_TYPE; }
  | ID {
        if (!is_declared($1)) {
            printf("In line no %d, ID %s is not declared.\n", lineno, $1);
            $$ = UNDEF_TYPE;
        } else {
            $$ = get_type($1);
        }
        free($1);
    }
    ;


if_statement:
    IF LPAREN condition RPAREN LBRACE statements RBRACE %prec LOWER_THAN_ELSE
    | IF LPAREN condition RPAREN LBRACE statements RBRACE ELSE if_statement
    | IF LPAREN condition RPAREN LBRACE statements RBRACE ELSE LBRACE statements RBRACE
    ;



condition:
    ID GT NUMBER
    | ID LT NUMBER
    | ID GE NUMBER
    | ID LE NUMBER
    | ID EQ NUMBER
    | ID NE NUMBER
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, lineno);
}

int main(void) {
    yyparse();
    return 0;
}
