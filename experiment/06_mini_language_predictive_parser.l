%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

/* Mini-language:
   statement -> identifier = value ;
*/
%}
%%
[ \t]+ ;
[A-Za-z_][A-Za-z0-9_]*[ \t]*=[ \t]*[A-Za-z0-9_]+[ \t]*; {
    printf("Valid mini-language assignment statement: %s\n",yytext);
}
[^ \t\n]+ {
    printf("Invalid statement/token: %s\n",yytext);
}
\n ;
%%
int yywrap(void){return 1;}
int main(void){
    printf("Enter statement such as x = 25 ;\n");
    yylex();
    return 0;
}
