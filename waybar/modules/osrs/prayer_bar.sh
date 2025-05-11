#!/bin/bash

# Pegando os dados da API
DATA=$(curl -s http://127.0.0.1:5000/get_stats)

# Verifica se o JSON é válido
if ! echo "$DATA" | jq empty >/dev/null 2>&1; then
    echo -e "<span color='gray'>✦ No data</span>"
    exit 0
fi

# Pega o último item do array
PRAYER=$(echo "$DATA" | jq '.prayerpoints_history[-1].current_prayer')
MAX=$(echo "$DATA" | jq '.prayerpoints_history[-1].max_prayer')

# Verifica se os valores são válidos
if [[ -z "$PRAYER" || -z "$MAX" || "$MAX" -eq 0 ]]; then
    #echo -e "<span color='gray'>✦ -</span>"
    echo -e ""
    exit 0
fi

# Calcula proporção
PERCENT=$(echo "scale=2; $PRAYER / $MAX" | bc)

# Gera barra
BLOCKS=19
FILLED=$(printf "%.0f" "$(echo "$PERCENT * $BLOCKS" | bc)")
EMPTY=$((BLOCKS - FILLED))
BAR=$(printf "%0.s█" $(seq 1 $FILLED))
BAR+=$(printf "%0.s░" $(seq 1 $EMPTY))

# Mostra a barra em azul
echo -e "<span color='#7fbbff'>✦ $BAR $PRAYER</span>"

