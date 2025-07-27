%option noyywrap

%{
    #include "cal.tab.h"
%}

letter [a-zA-Z]
digit [0-9]
delim [ \t]
under [_]
num {digit}{digit}*
float_num {num}*[.]{num}

%%

{delim} {}
"if" {return(IF);}
"int" {return(INT_TYPE);}
"float" {return(FLOAT_TYPE);}

"=" {return(ASSIGN);}
"+" {return(ADD);}
";" {return(SEMI);}
"(" {return(LB);}
")" {return(RB);}
"{" {return(CLB);}
"}" {return(CRB);}
">" {return(GT);}

{num} {yylval = atoi(yytext); return(INT_NUM);}
{float_num} {yylval = atof(yytext); return(FLOAT_NUM);}

({under}|{letter})({under}|{letter}|{digit})* {return(ID);}
%%
