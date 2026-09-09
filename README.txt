LEX / FLEX LAB PROGRAMS
========================

All files are .l Lex/Flex source files.

Compile a file:
    flex filename.l
    gcc lex.yy.c -o program

For the calculator:
    flex 09_operator_precedence_calculator.l
    gcc lex.yy.c -o calculator -lm

Run:
    ./program

Windows:
    flex filename.l
    gcc lex.yy.c -o program.exe
    program.exe
