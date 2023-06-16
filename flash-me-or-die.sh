#!/bin/bash

disco_destino="$1"

bmaptool create disco > disco.bmap

[[ "$disco_destino" ]] && bmaptool copy --bmap disco.bmap disco $disco_destino
