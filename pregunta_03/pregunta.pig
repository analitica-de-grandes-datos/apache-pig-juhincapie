/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
ejercicio = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letra:chararray,
            fecha:chararray,
            numer:int
    );

numeros = FOREACH ejercicio GENERATE numer;
data_ordenada = ORDER numeros By numer asc;
data_ordenada = LIMIT data_ordenada 5;
STORE data_ordenada INTO 'output' USING PigStorage(',');