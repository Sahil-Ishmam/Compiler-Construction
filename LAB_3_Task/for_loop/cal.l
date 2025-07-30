%option noyywrap

%{
    #include "cal.tab.h"
%}

letter [a-zA-Z]
digit [0-9]
delim [ \t\n]
under [_]
num {digit}{digit}*
float_num {num}*[.]{num}

%%

{delim} {}
"for" {return(FOR);}
"print" {return(PRINT);}
"int" {return(INT_TYPE);}
"float" {return(FLOAT_TYPE);}

"=" {return(ASSIGN);}
"+" {return(ADD);}
"-" {return(SUB);}
"*" {return(MUL);}
"/" {return(DIV);}
";" {return(SEMI);}
"(" {return(LB);}
")" {return(RB);}
"{" {return(CLB);}
"}" {return(CRB);}
">=" {return(GTE);}
"<=" {return(LTE);}
"==" {return(EQ);}
"!=" {return(NEQ);}
">" {return(GT);}
"<" {return(LT);}

{num} {yylval = atoi(yytext); return(INT_NUM);}
{float_num} {yylval = atof(yytext); return(FLOAT_NUM);}

\"[^\"]*\" {return(STRING);}

({under}|{letter})({under}|{letter}|{digit})* {return(ID);}
%%
