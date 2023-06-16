#!/bin/bash

TITULO="$1"
index=1
numero="${2}"
COR="\033[0;3${numero:=6}m"
NC='\033[0m' # No Color

while read line; do
    printf "${COR}${TITULO:=SAIDA}${NC} : ${line}\n"
    index=$(($index + 1))
done
