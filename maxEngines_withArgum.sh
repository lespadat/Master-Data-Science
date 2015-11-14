#!/bin/sh

# obtiene el nombre de la aerolinea con el avion con más motores

echo la aerolinea es ...

csvsort -d'^' -c nb_engines $1 -r | head -2 | csvcut -c manufacturer | tail -n +2 