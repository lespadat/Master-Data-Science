#!/bin/sh

# obtiene el número de modelos con un número concreto de motores 

echo El número de modelos con $2 motores es ... 

csvgrep -d'^' -c nb_engines -m $2 $1 | csvsort -c model | tail -n +2 | uniq -c | wc -l