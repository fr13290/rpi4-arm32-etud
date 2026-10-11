// @ARCH: arm32
// @REQUIRES: gpio.c
// button.s - Lecture bouton

.section .text
.global _start

.extern init_gpio
.extern get_gpio
.extern clean_gpio

.equ BUTTON_PIN, 27

_start:
    // TODO: Sauvegarder registres

    // TODO: Initialiser GPIO
    // Appeler init_gpio(0, BUTTON_PIN) - pas de LED, seulement bouton

    // TODO: Lire l'état du bouton avec get_gpio(BUTTON_PIN)
    // Retour dans r0 : 0 = LOW (non appuyé), 1 = HIGH (appuyé)

    // TODO: Tester r0
    // Si 0, aller à not_pressed
    // Si 1, aller à pressed

not_pressed:
    // TODO: Nettoyer et sortir avec code 0

pressed:
    // TODO: Nettoyer et sortir avec code 1 (pour distinguer)

error:
    // TODO: Erreur init, sortir avec code 2
