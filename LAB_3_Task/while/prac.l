
%option noyywrap

%{
    #include "prac.tab.h"
#include <string.h>
    int yylval;
%}

digit [0-9]
number ({digit}+)
delim [ \t\n]
ws {delim}+
alpha [A-Za-z]
undr [_]

%%
{ws} {}
"#include" {return(INCLUDE);}
"<iostream>" {return(IOSTREAM);}
"using" {return(USING);}
"namespace" {return(NAMESPACE);}
"std" {return(STD);}
"int" {return(INT);}
"main" {return(MAIN);}
"while" {return(WHILE);}
"return" {return(RETURN);}
"cout" {return(COUT);}
"endl" {return(ENDL);}
"=" {return(ASSIGN);}
"<<" {return(LSHIFT);}
"<" {return(LT);}
"++" {return(INC);}
"(" {return(LPAREN);}
")" {return(RPAREN);}
"{" {return(LBRACE);}
"}" {return(RBRACE);}
";" {return(SEMICOLON);}
{number} {yylval = atoi(yytext); return(NUMBER);}
"\"i = \"" {return(STRING);}
[a-zA-Z_][a-zA-Z0-9_]* {return(ID);}
"//".*        {/* ignore single-line comments */}
. {/* ignore any other character */}
%%