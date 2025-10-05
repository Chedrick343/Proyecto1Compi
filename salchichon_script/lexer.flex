package salchichon_script;

import java_cup.runtime.Symbol;
    import java.io.PrintWriter;
    import java.io.FileWriter;
    import java.io.IOException;
    import java.util.HashMap;

%%


%cup
%class Lexer
%public
%unicode
%line
%column
%state CADENA

%{  


    HashMap<String, String> tablaVariables = new HashMap<>();
    HashMap<String, String> tablaIdentificadores = new HashMap<>();
    HashMap<String, String> tablaConstantes = new HashMap<>();
    HashMap<String, String> tablaPalabrasReservadas = new HashMap<>();

    PrintWriter tokenWriter;

    {
        try {
            tokenWriter = new PrintWriter(new FileWriter("tokens.txt"));
        } catch (IOException e) {
            System.err.println("Error al abrir archivo tokens.txt");
        }
    }

    public void closeWriter() {
        if (tokenWriter != null) tokenWriter.close();
    }

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

<YYINITIAL> {INT1}      { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "TipoEntero");
                            }
                            tokenWriter.println("Token: INT1\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
                            return new Symbol(sym.INT1, yyline, yycolumn,"entero"); }


<YYINITIAL> {CHAR1}     { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "TipoChar");
                            }
                            tokenWriter.println("Token: CHAR1\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
                            return new Symbol(sym.CHAR1, yyline, yycolumn,"caracter"); }


<YYINITIAL> {STR1}      { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "TipoString");
                            }
                            tokenWriter.println("Token: STR1\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
                            
                            return new Symbol(sym.STR1, yyline, yycolumn,"string"); }


<YYINITIAL> {FLOAT1}    { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "TipoFloat");
                            }
                            tokenWriter.println("Token: FLOAT1\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
                            
                            return new Symbol(sym.FLOAT1, yyline, yycolumn,"privado"); }

<YYINITIAL> {BOOL1}     { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "TipoBool");
                            }
                            tokenWriter.println("Token: BOOL1\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
                            
                            return new Symbol(sym.BOOL1, yyline, yycolumn,"booleano"); }
<YYINITIAL> {LET}       { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "PalabraReservadaLet");
                            }
                            tokenWriter.println("Token: LET\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
                            return new Symbol(sym.LET, yyline, yycolumn,yytext()); }


<YYINITIAL> {PAR_A}     { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "abreParentesis");
                            }
                            tokenWriter.println("Token: PAR_A\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");

                            return new Symbol(sym.PAR_A, yyline, yycolumn,yytext()); }


<YYINITIAL> {PAR_C}     { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "cierraParentesis");
                            }
                            tokenWriter.println("Token: PAR_C\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
    
                            return new Symbol(sym.PAR_C, yyline, yycolumn,yytext()); }


<YYINITIAL> {BLO_A}     { 
    
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "abreBloque");
                            }
                            tokenWriter.println("Token: BLO_A\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
                            return new Symbol(sym.BLO_A, yyline, yycolumn,yytext()); }


<YYINITIAL> {BLO_C}     {   
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "cierraBloque");
                            }
                            tokenWriter.println("Token: BLO_C\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
    
                            return new Symbol(sym.BLO_C, yyline, yycolumn,yytext()); }

<YYINITIAL> {COMA}      { 

                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "coma");
                            }
                            tokenWriter.println("Token: COMA\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
    
                            return new Symbol(sym.COMA, yyline, yycolumn,yytext()); }
<YYINITIAL> {FIN_E}     { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "finalExpresion");
                            }
                            tokenWriter.println("Token: CHAR1\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
                            return new Symbol(sym.FIN_E, yyline, yycolumn,yytext()); }
<YYINITIAL> {ASIGN}     { 
                            if(!tablaPalabrasReservadas.containsKey(yytext())){
                                tablaPalabrasReservadas.put(yytext(), "asignacion");
                            }
                            tokenWriter.println("Token: ASIGN\tLexema: " + yytext() + "\tTabla: tablaPalabrasReservadas");
    
                            return new Symbol(sym.ASIGN, yyline, yycolumn,yytext()); }

<YYINITIAL> {ENTERO}    { 
    
                            if(!tablaConstantes.containsKey(yytext())){
                                tablaConstantes.put(yytext(), "constante");
                            }
                            tokenWriter.println("Token: ENTERO\tLexema: " + yytext() + "\tTabla: tablaConstantes");
                            return new Symbol(sym.ENTERO, yyline, yycolumn,yytext()); }


<YYINITIAL> {ID}        { 
    
                            if(!tablaIdentificadores.containsKey(yytext())){
                                tablaIdentificadores.put(yytext(), "identificador");
                                tokenWriter.println("Token: ID\tLexema: " + yytext() + "\tTabla: tablaIdentificadores");
                                return new Symbol(sym.ID, yyline, yycolumn,yytext());
                            }else{
                                System.out.println("El identificador: "+yytext()+". Ya existe en el programa");
                            }
                            }

<YYINITIAL> [\"]        { yybegin(CADENA); cadena = ""; }
<YYINITIAL> {SPACE}     { /* ignorar */ }
<YYINITIAL> {ENTER}     { /* ignorar */ }
<YYINITIAL> {COMENTARIO} { /* ignorar */ }

<YYINITIAL> . {
        String errLex = "Error léxico : '"+yytext()+"' en la línea: "+(yyline+1)+" y columna: "+(yycolumn+1);
        System.out.println(errLex);
}

<CADENA> {
        [\"] { 
            String tmp = cadena + "\""; 
            cadena = ""; 
            yybegin(YYINITIAL);
              
            if(!tablaConstantes.containsKey(yytext())){
                tablaConstantes.put(yytext(), "constante");
            }
            tokenWriter.println("Token: CADENA\tLexema: " + yytext() + "\tTabla: tablaConstantes");
            return new Symbol(sym.CADENA, yyline, yycolumn, tmp); 
        }
        [\n] {
            String tmp = cadena; 
            cadena = "";  
            System.out.println("Se esperaba cierre de cadena (\")."); 
            yybegin(YYINITIAL);
        }
        [^\"] { cadena += yytext(); }
}