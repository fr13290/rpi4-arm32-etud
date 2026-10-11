# API GPIO (lib/gpio/gpio.c)

Les fonctions s'appellent depuis l'assembleur avec `bl`, selon la convention ARM (AAPCS) :
arguments dans r0 et r1, résultat dans r0. Chaque fonction utilisée doit être déclarée
avec `.extern` (exemple : `.extern init_gpio`).
Les numéros de broches sont ceux du processeur (GPIO 17 = broche physique 11).

| Fonction | Arguments | Retour | Rôle |
|---|---|---|---|
| `init_gpio` | r0 = broche LED (0 = aucune), r1 = broche bouton (0 = aucun) | r0 = 0 si OK, -1 si erreur | Réserve les broches |
| `set_gpio` | r0 = broche | - | Sortie à 1 (LED allumée) |
| `clear_gpio` | r0 = broche | - | Sortie à 0 (LED éteinte) |
| `get_gpio` | r0 = broche | r0 = 0 ou 1 (-1 si erreur) | Lit une entrée |
| `write_gpio` | r0 = 0 ou 1 | - | Écrit sur la LED déclarée dans `init_gpio` |
| `read_gpio` | - | r0 = 0 ou 1 | Lit le bouton déclaré dans `init_gpio` |
| `clean_gpio` | - | - | Libère les broches (à appeler avant de quitter) |

En cas d'erreur, un message est écrit sur la sortie d'erreur (exemple : broche déjà utilisée,
`Device or resource busy`).

## Câblage (TP04 à TP06)

```
LED    : GPIO 17 (broche 11) --[330 ohms]--[LED]-- GND (broche 6)
Bouton : 3,3 V (broche 1) --[bouton]-- GPIO 27 (broche 13)
                                          |
                                       [10 kohms] vers GND (pull-down)
```

Bouton relâché = 0, bouton appuyé = 1. La bibliothèque n'active aucune résistance interne.

## Sortir du programme

`_start` n'a pas d'appelant : on ne peut pas faire `ret`. Il faut appeler le syscall exit
(r7 = 1, code de retour dans r0, puis `svc #0`).
