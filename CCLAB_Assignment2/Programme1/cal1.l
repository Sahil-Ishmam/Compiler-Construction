%option noyywrap

%{
#include <stdio.h>

// Roll Number: 222115071

%}

digit       [0-9]
letter      [a-zA-Z]
ASSIGN      "="
semi        ";"
dot         "\."
quote       [\'\"]
lparen      "\("
rparen      "\)"
lbrace      "\{"
rbrace      "\}"
addop       "+"|"-"
mulop       "*"|"/"|"%"
relop       "=="|"!="|"<"|"<="|">"|">="
incop       "\+\+"
decop       "--"
comma       ","
amp         "&"
underscore  "_"
E           [eE]
sign        [+\\-]
exp         {E}{sign}?{digit}+
float_num   {digit}+{dot}{digit}+({exp})?
int_num     {digit}+
char_const  \'{letter}\'
string      \"[^\"]*\"

type_kw     "int"|"float"|"char"|"double"
return_kw   "return"
for_kw      "for"
if_kw       "if"
else_kw     "else"
while_kw    "while"
do_kw       "do"
switch_kw   "switch"
case_kw     "case"
break_kw    "break"
continue_kw "continue"
default_kw  "default"
printf_kw   "printf"
scanf_kw    "scanf"
main_kw     "main"

id          {letter}({letter}|{digit}|{underscore})*
delim       [ \t\n]

%%

{int_num} {printf("%s -> INT_NUM\n", yytext);}
{float_num} {printf("%s -> FLOAT_NUM\n", yytext);}

"+" {printf("%s -> ADD_OP\n", yytext);}
"-" {printf("%s -> SUB_OP\n", yytext);}
"*" {printf("%s -> MUL_OP\n", yytext);}
"/" {printf("%s -> DIV_OP\n", yytext);}
"%" {printf("%s -> MOD_OP\n", yytext);}

"=" {printf("%s -> ASSIGN_OP\n", yytext);}
{relop} {printf("%s -> REL_OP\n", yytext);}

"++" {printf("%s -> INC_OP\n", yytext);}
"--" {printf("%s -> DEC_OP\n", yytext);}

"if" {printf("%s -> IF\n", yytext);}
"else" {printf("%s -> ELSE\n", yytext);}
"for" {printf("%s -> FOR\n", yytext);}
"while" {printf("%s -> WHILE\n", yytext);}
"return" {printf("%s -> RETURN\n", yytext);}
"int" {printf("%s -> INT\n", yytext);}
"float" {printf("%s -> FLOAT\n", yytext);}

"(" {printf("%s -> LPAREN\n", yytext);}
")" {printf("%s -> RPAREN\n", yytext);}
"{" {printf("%s -> LBRACE\n", yytext);}
"}" {printf("%s -> RBRACE\n", yytext);}
";" {printf("%s -> SEMICOLON\n", yytext);}
"," {printf("%s -> COMMA\n", yytext);}

{id} {printf("%s -> ID\n", yytext);}
{string} {printf("%s -> STRING\n", yytext);}
{char_const} {printf("%s -> CHAR_CONST\n", yytext);}

{delim} {}

. {printf("%s -> UNKNOWN\n", yytext);}

%%

int main()
{
    yylex();
    return 0;
}
