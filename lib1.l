%{
#include <stdio.h>
#include <string.h>
%}

/* Definitions section */
KEYWORDS   auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|inline|int|long|register|restrict|return|short|signed|sizeof|static|struct|switch|typedef|union|void|volatile|while

%%

{KEYWORDS}                { printf("Reserved Keyword: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*    { printf("Identifier: %s\n", yytext); }
[ \t\n]+                  ;   /* ignore whitespace */
.                         ;   /* ignore other characters */

%%

int main(void)
{
    printf("Enter C code:\n");
    yylex();
    return 0;
}

int yywrap(void)
{
    return 1;
}
