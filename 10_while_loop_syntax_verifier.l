%{
#include <stdio.h>
#include <string.h>
#include <regex.h>

/* Required syntax:
   while (condition) begin statement; end
*/
%}
%%
while[ \t]*\([^)]*\)[ \t]*begin[ \t]+[A-Za-z_][A-Za-z0-9_]*[ \t]*=[ \t]*[A-Za-z0-9_]+[ \t]*(\+|\-|\*|\/)[ \t]*[A-Za-z0-9_]+[ \t]*;[ \t]*end {
    printf("Valid while-loop syntax:\n%s\n",yytext);
}
[^\n]+ {
    printf("Invalid while-loop syntax:\n%s\n",yytext);
}
\n ;
%%
int yywrap(void){return 1;}
int main(void){
    printf("Enter while statement:\n");
    yylex();
    return 0;
}
