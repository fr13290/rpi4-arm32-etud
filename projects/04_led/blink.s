// @ARCH: arm32
// @REQUIRES: gpio.c
// blink.s - LED clignotante

.section .text
.global _start

.extern init_gpio
.extern set_gpio
.extern clear_gpio
.extern clean_gpio
.extern nanosleep

.equ LED_PIN, 17
.equ BLINK_COUNT, 10

_start:
    // TODO: Sauvegarder registres selon convention AAPCS

    // TODO: Initialiser GPIO
    // Appeler init_gpio(LED_PIN, 0)
    // Tester le retour (0 = OK)

    // TODO: Créer une boucle qui répète BLINK_COUNT fois :
    // 1. Allumer LED avec set_gpio(LED_PIN)
    // 2. Attendre 500ms avec nanosleep(&timespec_on, NULL)
    // 3. Éteindre LED avec clear_gpio(LED_PIN)
    // 4. Attendre 300ms avec nanosleep(&timespec_off, NULL)

    // TODO: Nettoyer GPIO avec clean_gpio()

    // TODO: Restaurer registres et sortir avec le syscall exit
    // (_start n'a pas d'appelant : on ne peut pas faire ret)

error:
    // TODO: En cas d'erreur init_gpio, sortir avec code 1

// Structures timespec (données fournies)
.section .data
.align 4
timespec_on:
    .word 0             // 0 secondes
    .word 500000000     // 500 000 000 nanosecondes = 500 ms
timespec_off:
    .word 0
    .word 300000000     // 300 ms
