%{
#include "cal.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lineno = 1;
%}

%%

"int"       { return INT; }
"while"     { return WHILE; }
"return"    { return RETURN; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }
[0-9]+      { yylval.num = atoi(yytext); return NUM; }
">"         { return '>'; }
"+"         { return '+'; }
"("         { return '('; }
")"         { return ')'; }
"{"         { return '{'; }
"}"         { return '}'; }
";"         { return ';'; }
"="         { return '='; }
\n          { lineno++; }
[ \t\r]+    { /* skip */ }
.           { return yytext[0]; }

%%

int yywrap() { return 1; }
