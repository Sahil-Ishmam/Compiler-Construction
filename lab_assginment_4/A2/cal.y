%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.c"

extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern int lineno;

void yyerror(const char *s);
%}

%union {
    int num;
    char *str;
}

%left '+'
%right UPLUS

%token <str> ID
%token <num> NUM
%token INT WHILE RETURN

%type <num> expr condition

%%

program:
    INT ID '(' ')' compound_stmt
    ;

compound_stmt:
    '{' stmt_list '}'
    ;

stmt_list:
    /* empty */
    | stmt_list stmt
    ;

stmt:
      INT ID ';' {
        insert($2, INT_TYPE);
        free($2);
      }
    | WHILE '(' condition ')' compound_stmt
    | ID '=' expr ';' {
        if(idcheck($1)) {
            printf("Assigning value to %s\n", $1);
        }
        free($1);
      }
    | RETURN expr ';' {
        printf("Return %d\n", $2);
      }
    ;

condition:
    expr '>' expr { $$ = ($1 > $3); }
    ;

expr:
      NUM { $$ = $1; }
    | ID {
        if(idcheck($1)) { $$ = 0; } /* placeholder */
        free($1);
      }
    | expr '+' expr { $$ = $1 + $3; }
    | '+' expr %prec UPLUS { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, lineno);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) {
            perror("fopen");
            return 1;
        }
        yyin = f;
    }
    return yyparse();
}
