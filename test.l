
%{
#include <stdio.h>
%}

%%

[a-zA-Z]+   { printf("Found a word: %s\n", yytext); }
[0-9]+      { printf("Found a number: %s\n", yytext); }
.|\n        { /* Ignore all other characters */ }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter text: \n");
    yylex();
    return 0;
}