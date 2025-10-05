// TP3: Calculer factorielle de 5
.global _start
.data
n: .word 5
result: .word 0
.text
_start:
    // TODO: Charger n dans r0
    
    // TODO: Initialiser r1 = 1 (résultat)
    
    // TODO: Boucle: r1 = r1 * r0, puis r0 = r0 - 1
    // Continuer tant que r0 > 0
    
loop:
    // TODO: Multiplier
    // TODO: Décrémenter
    // TODO: Tester si fini
    
    // TODO: Sauvegarder résultat
    
    mov r0, #0
    mov r7, #1
    svc #0
