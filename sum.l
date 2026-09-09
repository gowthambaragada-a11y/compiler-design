%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int num1 = 0, num2 = 0;
bool has_num1 = false, has_num2 = false;
%}

%%

-?[0-9]+ {  /* Added optional minus sign */
    if (!has_num1) {
        num1 = atoi(yytext);
        has_num1 = true;
    } else if (!has_num2) {
        num2 = atoi(yytext);
        has_num2 = true;
    }
}

\n {
    if (has_num1 && has_num2) {
        printf("Sum = %d\n", num1 + num2);
        exit(0);
    }
}

[ \t]   ; 
.       ; 

%%

int yywrap(void) { return 1; }

int main(void) {
    printf("Enter two numbers: ");
    yylex();
    return 0;
}