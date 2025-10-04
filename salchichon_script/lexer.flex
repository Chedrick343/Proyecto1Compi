package salchichon_script;

import java_cup.runtime.Symbol;


// cambio de sección 
%%


%cup                // Integracion de cup
%class Lexer      // Nombre de la clase generada
%public
%unicode            // UTF-8
%line               // Guarda el numero de linea
%column             // Guarda la columna
%state CADENA          

%{
    String cadena = "";

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}


// Lexemas - simbolos
PAR_A   =   "є"
PAR_C   =   "э"
BLO_A   =   "¿"
BLO_C   =   "?"
COMA    =   ","
FIN_E   =   "$"
ASIGN   =   "="

// Palabras reservadas
INT1    =   "int"
CHAR1   =   "char"
STR1    =   "string"
FLOAT1  =   "float"
BOOL1   =   "boolean"
LET     =   "let"

// Regex
ENTERO  =   (0)|(-?[1-9][0-9]*)
ID      =   [_a-zA-ZñÑ][_0-9a-zA-ZñÑ]*
SPACE   =   [ \t\f\r]
ENTER   =   [\n]


// Comentarios
FIN_L   =   \r|\n|\r\n
INPUT1  =   [^\r\n]

COM_S   =   \| {INPUT1}* {FIN_L}?
COM_C   =   "¡" ([^!]|(\n|\r))* "!"

COMENTARIO = {COM_S} | {COM_C}

%%

<YYINITIAL> {INT1}      { return new Symbol(sym.INT1, yyline, yycolumn,"entero"); }
<YYINITIAL> {CHAR1}     { return new Symbol(sym.CHAR1, yyline, yycolumn,"caracter"); }
<YYINITIAL> {STR1}      { return new Symbol(sym.STR1, yyline, yycolumn,"string"); }
<YYINITIAL> {FLOAT1}    { return new Symbol(sym.FLOAT1, yyline, yycolumn,"privado"); }
<YYINITIAL> {BOOL1}     { return new Symbol(sym.BOOL1, yyline, yycolumn,"booleano"); }
<YYINITIAL> {LET}       { return new Symbol(sym.LET, yyline, yycolumn,yytext()); }


<YYINITIAL> {PAR_A}     { return new Symbol(sym.PAR_A, yyline, yycolumn,yytext()); }
<YYINITIAL> {PAR_C}     { return new Symbol(sym.PAR_C, yyline, yycolumn,yytext()); }
<YYINITIAL> {BLO_A}     { return new Symbol(sym.BLO_A, yyline, yycolumn,yytext()); }
<YYINITIAL> {BLO_C}     { return new Symbol(sym.BLO_C, yyline, yycolumn,yytext()); }
<YYINITIAL> {COMA}      { return new Symbol(sym.COMA, yyline, yycolumn,yytext()); }
<YYINITIAL> {FIN_E}     { return new Symbol(sym.FIN_E, yyline, yycolumn,yytext()); }
<YYINITIAL> {ASIGN}     { return new Symbol(sym.ASIGN, yyline, yycolumn,yytext()); }


<YYINITIAL> {ENTERO}    { return new Symbol(sym.ENTERO, yyline, yycolumn,yytext()); }


// ID VA DESPUES DE LAS PALABRAS RESERVADAS PARA QUE NO LAS AGARRE COMO ID
<YYINITIAL> {ID}        { return new Symbol(sym.ID, yyline, yycolumn,yytext()); }


<YYINITIAL> [\"]        { yybegin(CADENA); cadena = ""; }
<YYINITIAL> {SPACE}     { /*Espacios en blanco, ignorados*/ }
<YYINITIAL> {ENTER}     { /*Saltos de linea, ignorados*/ }
<YYINITIAL> {COMENTARIO} { /* ignorar comentarios */ }


// TODO LO QUE NO RECONOZCA LO MANDA AQUI
<YYINITIAL> . {
        String errLex = "Error léxico : '"+yytext()+"' en la línea: "+(yyline+1)+" y columna: "+(yycolumn+1);
        System.out.println(errLex);
}

<CADENA> {
        [\"] { String tmp=cadena+"\""; cadena=""; yybegin(YYINITIAL);  return new Symbol(sym.CADENA,yyline, yycolumn, tmp); }
        [\n] {String tmp=cadena; cadena="";  
                System.out.println("Se esperaba cierre de cadena (\")."); 
                yybegin(YYINITIAL);
            }
        [^\"] { cadena+=yytext();}
}