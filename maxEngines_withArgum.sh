#!/bin/sh

# obtiene el nombre de la aerolinea con el avion con más motores

echo La compañía con el modelo con más motores es ...

csvsort -d'^' -c nb_engines $1 -r | head -2 | csvcut -c manufacturer | tail -n +2 