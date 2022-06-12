/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
ejercicio = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letra:chararray,
            conjunto:chararray,
            lista:chararray
    );


data = FOREACH ejercicio GENERATE letra, TOKENIZE(conjunto,',') AS conjunto_desagregado, TOKENIZE(lista,',') AS lista_desagregada;
data = FOREACH data GENERATE letra, COUNT(conjunto_desagregado) AS numero_datos_conjunto, COUNT(lista_desagregada) AS numero_datos_lista;
data = ORDER data BY letra, numero_datos_conjunto, numero_datos_lista asc;
STORE data INTO 'output' USING PigStorage(',');