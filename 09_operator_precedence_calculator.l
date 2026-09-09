%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>

double val[100];
char op[100];
int vt=-1, ot=-1;

int prec(char c){
    if(c=='+'||c=='-')return 1;
    if(c=='*'||c=='/')return 2;
    if(c=='^')return 3;
    return 0;
}
double apply(double a,double b,char c){
    if(c=='+')return a+b;
    if(c=='-')return a-b;
    if(c=='*')return a*b;
    if(c=='/')return a/b;
    if(c=='^')return pow(a,b);
    return 0;
}
%}
%%
[0-9]+(\.[0-9]+)? {
    val[++vt]=atof(yytext);
}
[()+\-*/^] {
    char c=yytext[0];
    if(c=='(') op[++ot]=c;
    else if(c==')'){
        while(ot>=0&&op[ot]!='('){
            double b=val[vt--],a=val[vt--];
            val[++vt]=apply(a,b,op[ot--]);
        }
        if(ot>=0)ot--;
    }else{
        while(ot>=0&&op[ot]!='('&&prec(op[ot])>=prec(c)){
            double b=val[vt--],a=val[vt--];
            val[++vt]=apply(a,b,op[ot--]);
        }
        op[++ot]=c;
    }
}
\n {
    while(ot>=0){
        double b=val[vt--],a=val[vt--];
        val[++vt]=apply(a,b,op[ot--]);
    }
    if(vt>=0) printf("Result = %.2f\n",val[vt]);
    vt=ot=-1;
}
[ \t]+ ;
. { printf("Invalid character: %s\n",yytext); }
%%
int yywrap(void){return 1;}
int main(void){
    printf("Enter arithmetic expression:\n");
    yylex();
    return 0;
}
