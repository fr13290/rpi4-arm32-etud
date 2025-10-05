# API GPIO

## init_gpio
Entrée: r0=pin LED (ou 0), r1=pin bouton (ou 0)
Sortie: r0=0 si OK, -1 si erreur

## write_gpio
Entrée: r0=0 (éteint) ou 1 (allumé)

## read_gpio
Sortie: r0=état bouton (0=appuyé, 1=relâché)

## clean_gpio
Libère les ressources (à appeler avant exit)
