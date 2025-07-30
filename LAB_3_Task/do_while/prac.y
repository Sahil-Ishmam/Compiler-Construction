%{
#include <stdio.h>
void yyerror(char *s);
int yylex();
%}

%token INCLUDE IOSTREAM USING NAMESPACE STD INT MAIN RETURN DO WHILE COUT ENDL ID NUMBER ASSIGN LSHIFT LT LPAREN RPAREN LBRACE RBRACE SEMICOLON INC STRING
%start program

%%
program:
    include_stmt using_stmt main_func
    ;

include_stmt:
    INCLUDE IOSTREAM
    ;

using_stmt:
    USING NAMESPACE STD SEMICOLON
    ;

main_func:
    INT MAIN LPAREN RPAREN LBRACE decl do_while_loop RETURN NUMBER SEMICOLON RBRACE
    ;

decl:
    INT ID ASSIGN NUMBER SEMICOLON
    ;

do_while_loop:
    DO LBRACE cout_stmt inc_stmt RBRACE WHILE LPAREN ID LT NUMBER RPAREN SEMICOLON
    ;

cout_stmt:
    COUT LSHIFT STRING LSHIFT ID LSHIFT ENDL SEMICOLON
    ;

inc_stmt:
    ID INC SEMICOLON
    ;

%%

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}

int main()
{
    yyparse();
    printf("Parsing Finished\n");
}