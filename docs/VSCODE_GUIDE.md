# Guide d'utilisation de VSCode

Ce document décrit les fonctionnalités de développement disponibles dans l'environnement VSCode pour la programmation ARM32 sur Raspberry Pi.

## Raccourcis clavier

### Compilation

**Linux/Windows :**
- `Ctrl+Shift+B` : Compiler le projet actuel
- `Ctrl+Shift+P` puis "Run Task" : Accéder aux tâches

**macOS :**
- `Cmd+Shift+B` : Compiler le projet actuel
- `Cmd+Shift+P` puis "Run Task" : Accéder aux tâches

### Débogage

**Linux/Windows :**
- `F5` : Démarrer le débogage
- `F10` : Exécuter l'instruction suivante
- `F11` : Entrer dans une fonction
- `Shift+F11` : Sortir d'une fonction
- `F9` : Placer ou retirer un point d'arrêt
- `Shift+F5` : Arrêter le débogage

**macOS :**
- `Fn+F5` : Démarrer le débogage
- `Fn+F10` : Exécuter l'instruction suivante
- `Fn+F11` : Entrer dans une fonction
- `Fn+Shift+F11` : Sortir d'une fonction
- `Fn+F9` : Placer ou retirer un point d'arrêt
- `Fn+Shift+F5` : Arrêter le débogage

## Tâches de build

Les tâches sont accessibles via le menu **Terminal** → **Run Task**.

- **Build** : compile le projet du fichier ouvert (tâche par défaut, raccourci de compilation).
- **Clean** : supprime les fichiers générés (objets `.o` et exécutable).
- **Build & Run** : compile puis exécute le programme.
- **Clean & Build** : nettoie puis recompile.

## Configurations de débogage

Deux configurations sont disponibles via le menu **Run** → **Start Debugging**.

### Debug ARM32
- Compile automatiquement le projet avant de lancer le débogueur
- S'arrête sur l'étiquette `_start`
- Affiche les valeurs en hexadécimal

### Debug ARM32 (no build)
Même chose sans recompiler. Utile lorsque le code n'a pas été modifié depuis la dernière compilation.

## Organisation du workspace

```
rpi4-arm32-etud/
├── .vscode/              Configuration VSCode (tasks, launch, settings)
├── projects/             Un dossier par TP, chacun avec son Makefile
│   ├── 01_hello/
│   ├── 02_addition/
│   └── ...
├── scripts/
│   └── Makefile.master   Makefile partagé par tous les TP
├── lib/
│   └── gpio/             Bibliothèque GPIO (gpio.c, gpio_func.s)
└── docs/                 Documentation
```

Le Makefile d'un TP ne contient que `include ../../scripts/Makefile.master`.
Pour les TP qui utilisent le GPIO, la bibliothèque `lib/gpio` est compilée et liée automatiquement.

## Procédures de travail

### Compiler un projet
1. Ouvrir un fichier source (.s) dans le projet à compiler
2. Utiliser le raccourci de compilation ou le menu Terminal → Run Build Task
3. L'exécutable est généré dans le même dossier

### Déboguer un programme
1. Ouvrir le fichier source principal (celui qui contient `_start`)
2. Placer des points d'arrêt si nécessaire
3. Démarrer le débogage (F5)
4. Avancer instruction par instruction (F10)

### Visualisation pendant le débogage
La **Debug Console** permet de saisir des commandes GDB, par exemple :
- `info registers` : valeurs des registres (hexadécimal)
- `x/dw &result` : contenu d'un mot mémoire

### Utilisation du terminal intégré

```bash
make        # Compiler
make run    # Compiler et exécuter
make clean  # Nettoyer
```

## Dépannage

### Commande make introuvable
```bash
sudo apt install make
```

### Compilateur ARM introuvable
```bash
sudo apt install gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabihf
```

### Débogueur non fonctionnel
```bash
sudo apt install gdb-multiarch
```

### Erreur "cannot find -lgpiod"
Installer les bibliothèques GPIO 32 bits :
```bash
sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install libgpiod-dev:armhf libgpiod2:armhf
```

### Erreur "Device or resource busy" au lancement d'un programme GPIO
Une autre instance du programme utilise déjà la broche. Attendre sa fin ou l'arrêter.

## Ressources complémentaires

- Référence ARM32 : `docs/REFERENCE_ARM32.md`
- API GPIO : `docs/GPIO_API.md`
- Démarrage rapide : `docs/QUICKSTART.md`
- Guide d'installation : `GUIDE_INSTALLATION_ETUDIANTS.md`
