%{
#include <stdio.h>
%}

%%

[AEIOUaeiou]    { printf("%s : VOWEL\n", yytext); }
[A-Za-z]    { printf("%s : CONSONANT\n", yytext); }
[ \t\n]+        ;
.               { printf("%s : INVALID INPUT\n", yytext); }

%%

int main()
{
    printf("Enter alphabets:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}