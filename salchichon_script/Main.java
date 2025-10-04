package salchichon_script;

import java.io.FileReader;
import java_cup.runtime.Symbol;

/**
 * 
 * @author Eyden
 */

public class Main {

    public static void main(String[] args) {
        generarCompilador();

        probarLexer("salchichon_script/test.ssc");

    }

    private static void generarCompilador() {
        try {
            String ruta = "salchichon_script/";
            String opcFlex[] = { ruta + "lexer.flex", "-d", ruta };
            jflex.Main.generate(opcFlex);
            String opcCUP[] = { "-destdir", ruta, "-parser", "parser", ruta + "parser.cup" };
            java_cup.Main.main(opcCUP);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void probarLexer(String archivo) {
        try {
            // Usa la clase correcta - Scanner (no scanner)
            Lexer scan = new Lexer(new FileReader(archivo));
            
            // Solo una de estas dos opciones:
            
            // OPCIÓN 1: Probar solo el lexer
            Symbol s;
            while ((s = scan.next_token()).sym != Sym.EOF) {
                System.out.println("Token: " + sym.terminalNames[s.sym] + " → " + s.value);
            }
            
            // OPCIÓN 2: Probar el parser completo (comenta la opción 1 si usas esta)
            // System.out.println("Finaliza el análisis...");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}