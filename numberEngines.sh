#!/bin/sh

# recibe dos parámetros: Fichero.csv y Número de motores
# el script devuelve Número de aviones que tienen ese número de motores

csvgrep -d'^' -c nb_engines -m $2 $1 | tail -n +2 | wc -l 