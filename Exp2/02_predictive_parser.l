%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

/* Grammar:
   E -> T R
   R -> + T R | epsilon
   T -> F S
   S -> * F S | epsilon
   F -> ( E ) | i
*/
char input[200];
int pos=0;
int E(void); int R(void); int T(void); int S(void); int F(void);

void skip(void){ while(isspace((unsigned char)input[pos])) pos++; }

int E(void){ return T() && R(); }
int R(void){
    skip();
    if(input[pos]=='+'){ pos++; return T() && R(); }
    return 1;
}
int T(void){ return F() && S(); }
int S(void){
    skip();
    if(input[pos]=='*'){ pos++; return F() && S(); }
    return 1;
}
int F(void){
    skip();
    if(input[pos]=='i'){ pos++; return 1; }
    if(input[pos]=='('){
        pos++;
        if(E()){
            skip();
            if(input[pos]==')'){ pos++; return 1; }
        }
    }
    return 0;
}
%}
%%
[^\n]+ {
    strncpy(input, yytext, sizeof(input)-1);
    input[sizeof(input)-1]='\0';
    pos=0;
    if(E()){
        skip();
        if(input[pos]=='\0') printf("Accepted\n");
        else printf("Rejected\n");
    }else printf("Rejected\n");
}
\n ;
%%
int yywrap(void){return 1;}
int main(void){
    printf("Enter expression using i,+,*,(,):\n");
    yylex();
    return 0;
}
