# Démarrage rapide

## Compiler un projet

```bash
cd projects/01_hello
make
```

## Exécuter

```bash
make run      # compile puis exécute
./hello       # ou exécution directe
```

Les programmes GPIO (TP04 à TP06) s'exécutent **sans sudo** : l'utilisateur pi appartient au groupe gpio.

## Nettoyer

```bash
make clean
```

## Déboguer (VSCode)

1. Ouvrir le fichier .s du TP
2. F5 : compile, lance le programme et s'arrête sur `_start`
3. F10 : instruction suivante

## Déboguer en ligne de commande

```bash
gdb-multiarch ./hello
(gdb) break _start
(gdb) run
(gdb) stepi            # une instruction
(gdb) info registers   # tous les registres
(gdb) x/dw &result     # un mot mémoire
```
