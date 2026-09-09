%{
#include <stdio.h>
#include <string.h>

/* LL(1) grammar:
   E -> T R
   R -> + T R | epsilon
   T -> F S
   S -> * F S | epsilon
   F -> ( E ) | i
*/
char stack[100];
int top, ip;
char in[100];

void pushstr(const char *s){
    for(int i=(int)strlen(s)-1;i>=0;i--) stack[++top]=s[i];
}
%}
%%
[+*()i]+ {
    strcpy(in,yytext);
    strcat(in,"$");
    top=-1; ip=0;
    stack[++top]='$'; stack[++top]='E';

    int ok=1;
    while(top>=0 && ok){
        char X=stack[top], a=in[ip];

        if(X=='$' && a=='$') break;

        if(X=='i'||X=='+'||X=='*'||X=='('||X==')'){
            if(X==a){top--;ip++;}
            else ok=0;
        }else{
            top--;
            if(X=='E') pushstr("TR");
            else if(X=='R'){
                if(a=='+') pushstr("TR+");
            }else if(X=='T') pushstr("FS");
            else if(X=='S'){
                if(a=='*') pushstr("FS*");
            }else if(X=='F'){
                if(a=='i') pushstr("i");
                else if(a=='(') pushstr(")E(");
                else ok=0;
            }else ok=0;
        }
    }

    if(ok && stack[top]=='$' && in[ip]=='$')
        printf("Accepted by LL(1) parser\n");
    else
        printf("Rejected by LL(1) parser\n");
}
\n ;
. { printf("Invalid input\n"); }
%%
int yywrap(void){return 1;}
int main(void){
    printf("Enter expression using i,+,*,(,):\n");
    yylex();
    return 0;
}
