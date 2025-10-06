package salchichon_script;

import java.io.FileReader;
import java_cup.runtime.Symbol;

public class Main {

    public static void main(String[] args) {
        generarCompilador();
        probarLexer("salchichon_script/test.ssc");
    }

    private static void generarCompilador() {
        try {
            String ruta = "salchichon_script/";
            String opcFlex[] = { ruta + "lexer.flex", "-d", ruta };
            //jflex.Main.generate(opcFlex);
            String opcCUP[] = { "-destdir", ruta, "-parser", "Parser", ruta + "parser.cup" };
            java_cup.Main.main(opcCUP);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void probarLexer(String archivo) {
        try {
            Lexer scan = new Lexer(new FileReader(archivo));
            Symbol s;
            
            // CORREGIR: Usar Sym (con mayúscula) que es la clase generada
            while ((s = scan.next_token()).sym != Sym.EOF) {
                System.out.println("Token: " + Sym.terminalNames[s.sym] + " → " + s.value);
            }
            scan.closeWriter();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}