#!/bin/bash
set -e

# Variables
JFLEX_JAR=libs/jflex-full-1.9.1.jar
CUP_JAR=libs/java-cup-11b.jar

# Generar lexer
java -jar $JFLEX_JAR lexer.flex

# Generar parser
java -jar $CUP_JAR -parser Parser -symbols sym parser.cup

# Compilar todo
javac -cp "$JFLEX_JAR:$CUP_JAR:." *.java
echo "✅ Compilación completa"

# Ejecutar (opcional)
#java -cp "$JFLEX_JAR:$CUP_JAR:." Main

