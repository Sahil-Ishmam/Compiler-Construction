%{
#include<stdio.h>
void yyerror(char *s);
int yylex();
%}

%token INT_TYPE INT_NUM FLOAT_NUM FLOAT_TYPE ASSIGN ADD SEMI IF LB RB CLB CRB GT ID
%start stmts

%%




stmts : stmts stmt | ;

stmt : cmp_stmt | ass_stmt;

cmp_stmt : IF BRACKET ID GT ID BRACKET BRACKET
         | BRACKET;


BRACKET : LB | RB | CLB | CRB

NUM : INT_NUM | FLOAT_NUM;


ass_stmt : ID ASSIGN ID ADD NUM SEMI;

%%

void yyerror(char *s)
{
    fprintf(stderr, "error: %s", s);
}

int main()
{
    yyparse();
    printf("Parsing Finished\n");
}
