// @ARCH: arm32
// @VERSION: pedagogique
// hello.s - Premier programme ARM32
// TP : Afficher "Hello from ARM32!" à l'écran

.section .data
msg:
    .ascii "Hello from ARM32!\n"
    .equ msg_len, . - msg

.section .text
.global _start

_start:
    // TODO: Utiliser le syscall write (n°4) pour afficher msg sur stdout
    // Arguments : r0 = fd (1 pour stdout), r1 = adresse buffer, r2 = longueur
    // N'oubliez pas de mettre le numéro syscall dans r7

    // TODO: Utiliser le syscall exit (n°1) pour terminer proprement
    // Argument : r0 = code retour (0 = succès)
