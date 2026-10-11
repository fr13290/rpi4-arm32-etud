/*
 * gpio.c - Bibliothèque GPIO des TP ARM32
 * (libgpiod 1.x : Raspberry Pi OS Bookworm, paquet libgpiod-dev:armhf)
 *
 * Fonctions appelables depuis le code assembleur (voir docs/GPIO_API.md) :
 *   int  init_gpio(int led, int bouton)  0 = OK, -1 = erreur ; une broche à 0 = inutilisée
 *   void set_gpio(int pin)               met la sortie pin à 1
 *   void clear_gpio(int pin)             met la sortie pin à 0
 *   int  get_gpio(int pin)               lit la broche pin en entrée (0 ou 1, -1 si erreur)
 *   void write_gpio(int v)               écrit v sur la LED déclarée dans init_gpio
 *   int  read_gpio(void)                 lit le bouton déclaré dans init_gpio
 *   void clean_gpio(void)                libère toutes les broches
 *
 * Les numéros sont ceux du processeur (GPIO 17 = broche physique 11).
 * Les noms exportés vers l assembleur sont définis dans gpio_func.s (adaptateurs
 * qui alignent la pile) ; ici les fonctions s appellent gpio_*.
 */
#include <errno.h>
#include <gpiod.h>
#include <stdio.h>
#include <string.h>

#define NB_PINS      64
#define CONSOMMATEUR "tp-arm32"

enum { LIBRE = 0, SORTIE = 1, ENTREE = 2 };

static struct gpiod_chip *chip = NULL;
static struct gpiod_line *lines[NB_PINS];
static int sens[NB_PINS];
static int pin_led = 0, pin_bouton = 0;

static void erreur(const char *contexte, int pin)
{
    fprintf(stderr, "gpio: %s (broche %d) : %s\n", contexte, pin, strerror(errno));
}

/* Ouvre le contrôleur GPIO (gpiochip0 sur Pi 3/4, gpiochip4 sur Pi 5) */
static int ouvrir_chip(void)
{
    if (chip)
        return 0;
    chip = gpiod_chip_open_by_name("gpiochip0");
    if (!chip)
        chip = gpiod_chip_open_by_name("gpiochip4");
    if (!chip) {
        erreur("ouverture du contrôleur GPIO", -1);
        return -1;
    }
    return 0;
}

/* Configure pin en SORTIE ou ENTREE (la redemande si le sens change) */
static int configurer(int pin, int voulu)
{
    int r;

    if (pin < 0 || pin >= NB_PINS) {
        fprintf(stderr, "gpio: numéro de broche invalide : %d\n", pin);
        return -1;
    }
    if (ouvrir_chip() < 0)
        return -1;
    if (sens[pin] == voulu)
        return 0;
    if (!lines[pin]) {
        lines[pin] = gpiod_chip_get_line(chip, pin);
        if (!lines[pin]) {
            erreur("accès à la broche", pin);
            return -1;
        }
    } else if (sens[pin] != LIBRE) {
        gpiod_line_release(lines[pin]);
        sens[pin] = LIBRE;
    }
    if (voulu == SORTIE)
        r = gpiod_line_request_output(lines[pin], CONSOMMATEUR, 0);
    else
        r = gpiod_line_request_input_flags(lines[pin], CONSOMMATEUR,
                                           GPIOD_LINE_REQUEST_FLAG_BIAS_DISABLE);
    if (r < 0) {
        erreur("réservation de la broche", pin);
        return -1;
    }
    sens[pin] = voulu;
    return 0;
}

int gpio_init(int led, int bouton)
{
    if (led > 0 && configurer(led, SORTIE) < 0)
        return -1;
    if (bouton > 0 && configurer(bouton, ENTREE) < 0)
        return -1;
    pin_led = led;
    pin_bouton = bouton;
    return 0;
}

void gpio_set(int pin)
{
    if (configurer(pin, SORTIE) == 0)
        gpiod_line_set_value(lines[pin], 1);
}

void gpio_clear(int pin)
{
    if (configurer(pin, SORTIE) == 0)
        gpiod_line_set_value(lines[pin], 0);
}

int gpio_get(int pin)
{
    if (configurer(pin, ENTREE) < 0)
        return -1;
    return gpiod_line_get_value(lines[pin]);
}

void gpio_write(int v)
{
    if (pin_led > 0)
        gpiod_line_set_value(lines[pin_led], v ? 1 : 0);
}

int gpio_read(void)
{
    return pin_bouton > 0 ? gpiod_line_get_value(lines[pin_bouton]) : -1;
}

void gpio_cleanup(void)
{
    int i;

    for (i = 0; i < NB_PINS; i++) {
        if (lines[i] && sens[i] != LIBRE)
            gpiod_line_release(lines[i]);
        lines[i] = NULL;
        sens[i] = LIBRE;
    }
    if (chip) {
        gpiod_chip_close(chip);
        chip = NULL;
    }
    pin_led = pin_bouton = 0;
}
