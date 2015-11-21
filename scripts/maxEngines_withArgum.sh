#!/bin/sh

# obtiene el nombre de la aerolinea con el avion con más motores

echo El modelo con mayor número de motores es ...

csvsort -d'^' -c nb_engines $1 -r | head -2 | csvcut -c model | tail -n +2 