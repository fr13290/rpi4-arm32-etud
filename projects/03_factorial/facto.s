// @ARCH: arm32
// facto.s - Calcul de factorielle

.section .data
n: .word 5
result: .word 0

.section .text
.global _start

_start:
    // TODO: Charger n dans r0

    // TODO: Initialiser r1 = 1 (accumulateur du résultat)

loop:
    // TODO: Créer une boucle qui :
    // - Multiplie r1 par r0 (résultat dans r1)
    // - Décrémente r0
    // - Continue tant que r0 > 0

    // TODO: Sauvegarder r1 dans result

    // TODO: Sortir
