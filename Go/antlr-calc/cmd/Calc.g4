// Demo for parsing simple math expressions.

grammar Calc;

LPAREN: '(';
RPAREN: ')';
LBRACK: '[';
RBRACK: ']';
MUL: '*';
DIV: '/';
ADD: '+';
SUB: '-';
EXP: '**';
NUMBER: [0-9]+;
WHITESPACE: [ \r\n\t]+ -> skip;

start : expression EOF;

expression
   : LBRACK expression RBRACK
   | LPAREN expression RPAREN
   | expression EXP expression
   | expression op=(MUL | DIV) expression
   | expression op=('+'|'-') expression
   | NUMBER
   ;
