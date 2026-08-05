%{
#include <stdio.h>
#include <stdlib.h>

int num1 = -1, num2 = -1;   // initialize to -1 so we know if they’re set
%}

%%

[0-9]+ {
    if (num1 == -1)
        num1 = atoi(yytext);
    else if (num2 == -1)
        num2 = atoi(yytext);
}

\n {
    if (num1 != -1 && num2 != -1) {
        printf("Sum = %d\n", num1 + num2);
        exit(0);   // terminate cleanly
    }
}

[ \t]   ;   /* ignore spaces/tabs */
.       ;   /* ignore other characters */

%%   /* <-- this was missing */

int yywrap(void)
{
    return 1;
}

int main(void)
{
    printf("Enter two numbers: ");
    yylex();
    return 0;
}
