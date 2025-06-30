%option noyywrap

%{
//Roll Number: 222115071
//
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
{digit}{digit}* {printf("%s -> NUMBER\n", yytext);}
"+" {printf("%s -> ADD\n", yytext);}
"-" {printf("%s -> SUB\n", yytext);}
"*" {printf("%s -> MUL\n", yytext);}
"/" {printf("%s -> DIV\n", yytext);}
"if" {printf("%s -> IF\n", yytext);}
"else" {printf("%s -> ELSE\n", yytext);}
"for" {printf("%s -> FOR\n", yytext);}
"return" {printf("%s -> RETURN\n", yytext);}
"int" {printf("%s -> INT\n", yytext);}
"float" {printf("%s -> FLOAT\n", yytext);}
"while" {printf("%s -> WHILE\n", yytext);}
"(" {printf("%s -> LP\n", yytext);}
")" {printf("%s -> RP\n", yytext);}
"{" {printf("%s -> LB\n", yytext);}
"}" {printf("%s -> RB\n", yytext);}
"=" {printf("%s -> ASSIGN\n", yytext);}
";" {printf("%s -> SEMI\n", yytext);}
{relop} {printf("%s -> REL_OP\n", yytext);}

{id} {printf("%s -> ID\n", yytext);}


{delim} {}
%%

int main()
{
  yylex();
  return 0;
}
