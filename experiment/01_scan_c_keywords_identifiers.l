%{
#include <stdio.h>
%}
%%
"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" { printf("KEYWORD: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("IDENTIFIER: %s\n", yytext); }
[0-9]+ { printf("NUMBER: %s\n", yytext); }
[ \t\n]+ ;
. { printf("SYMBOL: %s\n", yytext); }
%%
int yywrap(void){ return 1; }
int main(void){ yylex(); return 0; }
