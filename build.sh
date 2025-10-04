#!/bin/bash
set -e

# ===== Variables =====
JFLEX_JAR="libs/jflex-full-1.9.1.jar"
CUP_JAR="libs/java-cup-11b.jar"
RUN_JAR="libs/java-cup-11b-runtime.jar"
SRC_DIR="salchichon_script"

rm -f salchichon_script/Lexer.java salchichon_script/parser.java salchichon_script/Parser.java salchichon_script/sym.java

# ===== Generar lexer =====
echo "Generando lexer..."
java -jar "$JFLEX_JAR" "$SRC_DIR/lexer.flex"

# ===== Generar parser =====
echo "Generando parser..."
java -jar "$CUP_JAR" -parser Parser -symbols Sym "$SRC_DIR/parser.cup"

# ===== Compilar todo =====
echo "Compilando fuentes..."
javac -cp ".:$JFLEX_JAR:$CUP_JAR:$RUN_JAR" "$SRC_DIR"/*.java

echo "Compilación completa."

echo "Ejecutando programa..."
java -cp ".:$JFLEX_JAR:$CUP_JAR:$RUN_JAR" salchichon_script.Main
