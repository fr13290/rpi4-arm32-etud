# Référence ARM32

## Registres

| Registre | Rôle |
|---|---|
| r0-r3 | Arguments et valeur de retour. Peuvent être modifiés par tout appel de fonction (`bl`) |
| r4-r11 | Variables. Conservées par les fonctions appelées ; à sauvegarder avec `push`/`pop` si vous les utilisez dans une fonction |
| r12 | Registre temporaire |
| r13 (sp) | Pointeur de pile (aligné sur 8 octets lors d'un appel de fonction) |
| r14 (lr) | Adresse de retour |
| r15 (pc) | Compteur de programme |

## Commentaires

Utiliser `//` (ou `@`). Le caractère `;` sépare deux instructions : ne l'utilisez pas pour commenter.

## Instructions de base

| Instruction | Effet |
|---|---|
| `mov r0, #5` | r0 = 5 |
| `ldr r0, =label` | r0 = adresse de label |
| `ldr r0, [r1]` | r0 = mot mémoire à l'adresse r1 |
| `str r0, [r1]` | mot mémoire à l'adresse r1 = r0 |
| `add r0, r1, r2` | r0 = r1 + r2 |
| `sub r0, r1, r2` | r0 = r1 - r2 |
| `subs r0, r0, #1` | comme `sub`, et met à jour les indicateurs (Z, N...) |
| `mul r0, r1, r2` | r0 = r1 * r2 |
| `cmp r0, r1` | compare r0 et r1 (met à jour les indicateurs) |
| `b label` | saut |
| `beq label` / `bne label` | saut si égal / différent |
| `bl fonction` | appel de fonction (adresse de retour dans lr) |
| `bx lr` | retour de fonction |
| `push {r4, lr}` / `pop {r4, pc}` | sauvegarde / restauration de registres sur la pile |
| `svc #0` | appel système |

## Appels système (r7 = numéro, arguments dans r0-r2)

| r7 | Appel | Arguments |
|---|---|---|
| 1 | exit | r0 = code retour |
| 4 | write | r0 = descripteur (1 = stdout), r1 = adresse, r2 = longueur |

## Appeler une fonction de bibliothèque (GPIO, nanosleep...)

Arguments dans r0-r3, appel avec `bl nom`, résultat dans r0. Déclarer `.extern nom`.
Avant `bl`, sp doit être aligné sur 8 octets (`push {r4, lr}` conserve l'alignement).
