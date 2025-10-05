// TP1: Afficher "Hello ARM32"
.global _start
.data
msg: .ascii "Hello ARM32\n"
.text
_start:
    // TODO: Afficher le message avec syscall write (r7=#4)
    // r0 = 1 (stdout), r1 = adresse msg, r2 = longueur (12)
    
    // TODO: Terminer avec syscall exit (r7=#1)
    // r0 = 0 (code retour)
