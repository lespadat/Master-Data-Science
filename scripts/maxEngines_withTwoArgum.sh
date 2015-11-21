#!/bin/sh

# obtiene el nombre de la aerolinea con el avion con más motores

echo El modelo de la compañía $2 con mayor número de motores es el ...


csvsort -d'^' -c nb_engines $1  -r | csvgrep -c manufacturer -m $2 | csvcut -c model | tail -n +2 | head -1