#!/bin/sh

# obtiene el nombre de la aerolinea con el avion con más motores

csvsort -d'^' -c nb_engines optd_aircraft.csv -r | head -2 | csvcut -c manufacturer | tail -n +2 