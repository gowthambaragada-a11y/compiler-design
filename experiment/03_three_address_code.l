%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

char expr[200];
int temp=1;

void generate_tac(char *s){
    char a[200];
    strcpy(a,s);

    printf("Three Address Code:\n");

    /* Handle multiplication/division first. */
    for(int i=1; a[i+1]; i++){
        if(a[i]=='*' || a[i]=='/'){
            printf("t%d = %c %c %c\n",temp,a[i-1],a[i],a[i+1]);
            a[i-1]='T'; a[i]=' '; a[i+1]=' ';
            temp++;
        }
    }

    /* Handle remaining + and -. */
    for(int i=1; a[i+1]; i++){
        if(a[i]=='+' || a[i]=='-'){
            printf("t%d = %c %c %c\n",temp,a[i-1],a[i],a[i+1]);
            temp++;
        }
    }
}
%}
%%
[ \t]+ ;
[^\n]+ { generate_tac(yytext); }
\n ;
%%
int yywrap(void){return 1;}
int main(void){
    printf("Enter expression such as a+b*c:\n");
    yylex();
    return 0;
}
