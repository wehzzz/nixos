#!/bin/sh

# Vérifier que l'utilisateur passe un argument (up/down)
if [ "$1" != "up" ] && [ "$1" != "down" ]; then
    echo "Usage: $0 {up|down}"
    exit 1
fi

# Récupérer le volume actuel
current_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')

# Définir l'incrément/décrément
step=0.05

# Calculer le nouveau volume
if [ "$1" = "up" ]; then
    new_volume=$(echo "$current_volume + $step" | bc)
    # S'assurer que le volume ne dépasse pas 1.0
    if (( $(echo "$new_volume > 1.0" | bc -l) )); then
        new_volume=1.0
    fi
else
    new_volume=$(echo "$current_volume - $step" | bc)
    # S'assurer que le volume ne passe pas en dessous de 0.0
    if (( $(echo "$new_volume < 0.0" | bc -l) )); then
        new_volume=0.0
    fi
fi

# Appliquer le nouveau volume
wpctl set-volume @DEFAULT_AUDIO_SINK@ "$new_volume"

