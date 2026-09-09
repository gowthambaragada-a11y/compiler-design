%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* Grammar:
   S -> CC
   C -> cC | d
   Precomputed SLR(1) table is used.
*/
int stack[100], top, ip;
char in[100];

const char *action[7][3]={
    {"s3","s4",""},
    {"","","acc"},
    {"s3","s4",""},
    {"s3","s4",""},
    {"r3","r3","r3"},
    {"","","r1"},
    {"r2","r2","r2"}
};

int col(char c){
    if(c=='c') return 0;
    if(c=='d') return 1;
    return 2;
}
%}
%%
[cd]+ {
    strcpy(in,yytext);
    strcat(in,"$");
    top=0; ip=0; stack[0]=0;

    while(1){
        int st=stack[top];
        const char *a=action[st][col(in[ip])];

        if(strcmp(a,"acc")==0){
            printf("Accepted by SLR(1) parser\n");
            break;
        }
        if(a[0]=='s'){
            stack[++top]=atoi(a+1);
            ip++;
        }else if(a[0]=='r'){
            int r=atoi(a+1);
            int pop=(r==1)?4:(r==2?3:1);
            top-=pop;
            stack[++top]=(r==1)?1:2;
        }else{
            printf("Rejected by SLR(1) parser\n");
            break;
        }
    }
}
\n ;
. { printf("Invalid input\n"); }
%%
int yywrap(void){return 1;}
int main(void){
    printf("Enter string using c and d:\n");
    yylex();
    return 0;
}
