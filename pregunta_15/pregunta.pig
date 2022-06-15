/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/
ejercicio = LOAD 'data.csv' USING PigStorage(',')
    AS (
            id: int,
            nombre:chararray,
            apellido:chararray,
            fecha:chararray,
            color:chararray,
            numer:chararray
    );

sub_conjunto= FOREACH ejercicio GENERATE nombre, color;
filtro_B= FILTER sub_conjunto BY (nombre MATCHES '.*^[zZ].*') AND (color == 'blue');
STORE filtro_B INTO 'output' USING PigStorage(' ');
