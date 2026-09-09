%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

char s[200];
int p;

int E(void); int T(void); int F(void);

int F(void){
    if(s[p]=='i'){p++;return 1;}
    if(s[p]=='('){
        p++;
        if(E() && s[p]==')'){p++;return 1;}
    }
    return 0;
}
int T(void){
    if(!F()) return 0;
    while(s[p]=='*'||s[p]=='/'){
        p++;
        if(!F()) return 0;
    }
    return 1;
}
int E(void){
    if(!T()) return 0;
    while(s[p]=='+'||s[p]=='-'){
        p++;
        if(!T()) return 0;
    }
    return 1;
}
%}
%%
[+*/()i-]+ {
    strcpy(s,yytext);
    p=0;
    if(E() && s[p]=='\0') printf("Accepted by recursive descent parser\n");
    else printf("Rejected\n");
}
\n ;
. { printf("Invalid input\n"); }
%%
int yywrap(void){return 1;}
int main(void){
    printf("Enter expression using i,+,-,*,/,(,):\n");
    yylex();
    return 0;
}
