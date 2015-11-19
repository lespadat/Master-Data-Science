#!/bin/sh

bzip2 -9 optd_por_public.csv

bzcat optd_por_public.csv.bz2 | grep "^MAD" 

