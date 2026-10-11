// @ARCH: arm32
// @REQUIRES: gpio.c
// combo.s - LED contrôlée par bouton

.section .text
.global _start

.extern init_gpio
.extern set_gpio
.extern clear_gpio
.extern get_gpio
.extern clean_gpio
.extern nanosleep

.equ LED_PIN, 17
.equ BUTTON_PIN, 27

_start:
    // TODO: Sauvegarder registres

    // TODO: Initialiser GPIO (LED + bouton)
    // Appeler init_gpio(LED_PIN, BUTTON_PIN)

main_loop:
    // TODO: Lire l'état du bouton
    // Appeler get_gpio(BUTTON_PIN), résultat dans r0

    // TODO: Tester r0
    // Si 0 (bouton relâché), éteindre LED
    // Si 1 (bouton appuyé), allumer LED

    // TODO: Petit délai anti-rebond (50ms)

    // TODO: Revenir à main_loop

error:
    // TODO: Gérer erreur

// Données
.section .data
.align 4
timespec_delay:
    .word 0
    .word 50000000      // 50 ms
