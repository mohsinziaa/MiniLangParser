%{
/* Definition section */
#include<stdio.h> 
#include<string.h>
#include "minilang.tab.h" 
extern int yylval; 
%} 

/* Rule Section */
%%
[0-9]+ {
        yylval = atoi(yytext); 
        return NUMBER; 
    }
[a-zA-Z][a-zA-Z0-9]* {
        yylval = yylval = yytext[0]; // Just store the first character for now
        return VARIABLE;
    }
[\t] ; 

[\n] { return 0; } 

. { return yytext[0]; } 

%% 

int yywrap() { 
    return 1; 
}
