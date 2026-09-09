%{
#include <stdio.h>
#include <string.h>

char st[200];
int top=-1;

void push(char c){st[++top]=c;st[top+1]='\0';}
void popn(int n){top-=n;st[top+1]='\0';}

int reduce_once(void){
    if(top>=0 && st[top]=='i'){popn(1);push('F');return 1;}
    if(top>=0 && st[top]=='F'){popn(1);push('T');return 1;}
    if(top>=2 && st[top-2]=='T'&&st[top-1]=='*'&&st[top]=='F'){
        popn(3);push('T');return 1;
    }
    if(top>=0 && st[top]=='T'){popn(1);push('E');return 1;}
    if(top>=2 && st[top-2]=='E'&&st[top-1]=='+'&&st[top]=='T'){
        popn(3);push('E');return 1;
    }
    if(top>=2 && st[top-2]=='('&&st[top-1]=='E'&&st[top]==')'){
        popn(3);push('F');return 1;
    }
    return 0;
}
%}
%%
[+*()i]+ {
    top=-1; st[0]='\0';
    for(int i=0; yytext[i]; i++){
        push(yytext[i]);
        while(reduce_once());
    }
    while(reduce_once());
    if(strcmp(st,"E")==0) printf("Accepted by bottom-up parser\n");
    else printf("Rejected\n");
}
\n ;
. { printf("Invalid character\n"); }
%%
int yywrap(void){return 1;}
int main(void){
    printf("Enter expression using i,+,*,(,):\n");
    yylex();
    return 0;
}
