%{
#include<stdio.h>
void yyerror(char *s);
int yylex();
%}

%token INT_TYPE INT_NUM FLOAT_NUM FLOAT_TYPE ASSIGN ADD SUB MUL DIV SEMI
%token FOR PRINT LB RB CLB CRB GT LT GTE LTE EQ NEQ ID STRING
%start stmts

%%

stmts : stmts stmt | ;

stmt : for_stmt | ass_stmt | decl_stmt | print_stmt;

for_stmt : FOR LB for_init SEMI for_cond SEMI for_update RB CLB stmts CRB;

for_init : ass_expr | decl_expr | /* empty */ ;

for_cond : condition | /* empty */ ;

for_update : ass_expr | /* empty */ ;

print_stmt : PRINT LB STRING RB SEMI;

condition : ID GT ID
          | ID LT ID
          | ID GTE ID
          | ID LTE ID
          | ID EQ ID
          | ID NEQ ID
          | ID GT INT_NUM
          | ID LT INT_NUM
          | ID GTE INT_NUM
          | ID LTE INT_NUM
          | ID EQ INT_NUM
          | ID NEQ INT_NUM;

ass_stmt : ID ASSIGN expr SEMI;

ass_expr : ID ASSIGN expr;

expr : expr ADD term
     | expr SUB term
     | term;

term : term MUL factor
     | term DIV factor
     | factor;

factor : ID
       | INT_NUM
       | FLOAT_NUM
       | LB expr RB;

decl_stmt : INT_TYPE ID SEMI
          | FLOAT_TYPE ID SEMI
          | INT_TYPE ID ASSIGN INT_NUM SEMI
          | FLOAT_TYPE ID ASSIGN FLOAT_NUM SEMI;

decl_expr : INT_TYPE ID
          | FLOAT_TYPE ID
          | INT_TYPE ID ASSIGN INT_NUM
          | FLOAT_TYPE ID ASSIGN FLOAT_NUM;

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
