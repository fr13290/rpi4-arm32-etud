// TP2: Additionner deux nombres
.global _start
.data
val1: .word 42
val2: .word 58
result: .word 0
.text
_start:
    // TODO: Charger val1 dans r0
    // ldr r0, =val1
    // ldr r0, [r0]
    
    // TODO: Charger val2 dans r1
    
    // TODO: Additionner r0 + r1 → r2
    
    // TODO: Sauvegarder r2 dans result
    
    mov r0, #0
    mov r7, #1
    svc #0
