package salchichon_script;

import jflex.anttask.JFlexTask;

/**
 * 
 * @author Eyden
 */

public class Main {

    public static void main(String[] args) {
        generarCompilador();
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
}