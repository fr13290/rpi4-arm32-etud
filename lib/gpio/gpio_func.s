// gpio_func.s - Adaptateurs entre l assembleur des étudiants et la bibliothèque C (gpio.c)
//
// Pourquoi ce fichier ? La convention d appel ARM (AAPCS) exige une pile alignée
// sur 8 octets à chaque appel de fonction C. Un programme qui a fait push {lr}
// (4 octets) casserait cet alignement. Chaque adaptateur :
//   1. sauvegarde r4 et lr,
//   2. aligne sp sur 8 octets,
//   3. appelle la fonction C (r0-r3 non modifiés : arguments transmis tels quels),
//   4. restaure la pile et revient au code appelant (résultat dans r0).

    .syntax unified
    .arch armv7-a
    .text

    .macro adaptateur nom, cible
    .global \nom
    .type   \nom, %function
\nom:
    push    {r4, lr}
    mov     r4, sp
    bic     sp, sp, #7
    bl      \cible
    mov     sp, r4
    pop     {r4, pc}
    .size   \nom, . - \nom
    .endm

    adaptateur init_gpio,  gpio_init
    adaptateur set_gpio,   gpio_set
    adaptateur clear_gpio, gpio_clear
    adaptateur get_gpio,   gpio_get
    adaptateur write_gpio, gpio_write
    adaptateur read_gpio,  gpio_read
    adaptateur clean_gpio, gpio_cleanup

    .section .note.GNU-stack,"",%progbits
