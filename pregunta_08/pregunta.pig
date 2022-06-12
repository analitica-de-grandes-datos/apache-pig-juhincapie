/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

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

datos= FOREACH ejercicio GENERATE FLATTEN(TOKENIZE(conjunto)) AS conjunto_desagregado, FLATTEN(TOKENIZE(lista)) AS lista_desagregada;
datos = FOREACH datos GENERATE REPLACE(conjunto_desagregado, '([^a-zA-Z\\s]+)','') AS letra, REPLACE(lista_desagregada,'([^a-zA-Z\\s]+)','') AS clave;
datos = FOREACH datos GENERATE TOTUPLE(letra,clave) as tupla;
agrupacion = GROUP datos BY tupla;
contador = FOREACH agrupacion GENERATE group, COUNT(datos);
STORE contador INTO 'output' USING PigStorage(',');
