%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "cal.tab.h"

    int lineno = 1;
%}

alpha       [a-zA-Z]
digit       [0-9]
alnum       ({alpha}|{digit})

ID          {alpha}{alnum}*

CCONST      \'[ -~]\'

%%

"//".*          { /* skip single-line comments */ }

"int"           { return INT; }
"double"        { return DOUBLE; }
"char"          { return CHAR; }

"if"            { return IF; }
"else"          { return ELSE; }

"=="            { return EQ; }
">="            { return GE; }
"<="            { return LE; }
"!="            { return NE; }
">"             { return GT; }
"<"             { return LT; }

"="             { return ASSIGN; }

";"             { return SEMI; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }

{ID}            { yylval.sval = strdup(yytext); return ID; }
{digit}+        { yylval.ival = atoi(yytext); return NUMBER; }
{digit}+"."{digit}+ { return DOUBLE_NUM; }
{CCONST}        { yylval.cval = yytext[1]; return CHAR_CONST; }

[ \t\r\f]+      { /* skip whitespace */ }
\n              { lineno++; }

.               { printf("Unrecognized character %s at line %d\n", yytext, lineno); }

%%
