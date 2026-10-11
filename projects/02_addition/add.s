// @ARCH: arm32
// add.s - Addition de deux nombres

.section .data
val1: .word 42
val2: .word 58
result: .word 0

.section .text
.global _start

_start:
    // TODO: Charger val1 dans r0
    // Utiliser ldr pour charger l'adresse, puis ldr à nouveau pour la valeur

    // TODO: Charger val2 dans r1

    // TODO: Additionner r0 + r1, mettre le résultat dans r2

    // TODO: Sauvegarder r2 dans result

    // TODO: Sortir avec exit(0)
