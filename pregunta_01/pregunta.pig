/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

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

letras_agrupadas = GROUP ejercicio BY letra;
conteo_letras = FOREACH letras_agrupadas GENERATE group, COUNT(ejercicio);
STORE conteo_letras INTO 'output' USING PigStorage(',');