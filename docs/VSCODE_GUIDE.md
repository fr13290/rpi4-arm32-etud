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

### Navigation

**Linux/Windows :**
- `Ctrl+P` : Recherche rapide de fichiers
- `Ctrl+Shift+F` : Recherche dans tous les fichiers
- `Ctrl+\`` : Ouvrir/Fermer le terminal intégré

**macOS :**
- `Cmd+P` : Recherche rapide de fichiers
- `Cmd+Shift+F` : Recherche dans tous les fichiers
- `Cmd+\`` : Ouvrir/Fermer le terminal intégré

## Tâches de build

Les tâches sont accessibles via le menu **Terminal** → **Run Task**.

### Build
Compile le projet dans le répertoire courant. Cette tâche est définie comme tâche par défaut et s'exécute avec le raccourci de compilation.

### Clean
Supprime tous les fichiers générés (fichiers objets .o et exécutables).

### Build & Run
Compile le projet puis exécute immédiatement le programme généré.

### Clean & Build
Nettoie complètement le projet puis le recompile. Cette tâche est utile après des modifications importantes du code.

## Configurations de débogage

Deux configurations sont disponibles via le menu **Run** → **Start Debugging**.

### Debug ARM32
Configuration par défaut qui :
- Compile automatiquement le projet avant de lancer le débogueur
- Arrête l'exécution au point d'entrée (_start)
- Affiche les valeurs des registres en hexadécimal

### Debug ARM32 (no build)
Configuration alternative qui lance le débogueur sans recompiler. Utile lorsque le code n'a pas été modifié depuis la dernière compilation.

## Organisation du workspace

```
rpi4-arm32-etud/
├── .vscode/              Configuration VSCode
│   ├── tasks.json        Définition des tâches de build
│   ├── launch.json       Configurations de débogage
│   └── settings.json     Paramètres du projet
├── projects/             Répertoire des projets
│   ├── 01_hello/
│   ├── 02_addition/
│   └── ...
├── tools/
│   ├── Makefile.master   Makefile principal partagé
│   └── Makefile.project  Template pour nouveaux projets
└── lib/
    └── gpio/             Bibliothèque GPIO
```

## Procédures de travail

### Compiler un projet
1. Ouvrir un fichier source (.s ou .c) dans le projet à compiler
2. Utiliser le raccourci de compilation ou le menu Terminal → Run Build Task
3. Le fichier exécutable est généré dans le même répertoire

### Déboguer un programme
1. Ouvrir le fichier source principal (celui contenant le point d'entrée _start)
2. Placer des points d'arrêt si nécessaire
3. Utiliser le raccourci de débogage pour démarrer
4. Utiliser les raccourcis de navigation pour avancer instruction par instruction

### Visualisation pendant le débogage
Le panneau **Debug Console** en bas de l'écran affiche :
- Les valeurs des registres (format hexadécimal)
- Les sorties du programme
- Les commandes GDB disponibles

### Utilisation du terminal intégré
Le terminal intégré permet d'exécuter directement les commandes make :
```bash
make all    # Compiler
make run    # Compiler et exécuter
make clean  # Nettoyer
```

## Paramètres du projet

### Masquage des fichiers
Les fichiers objets (.o) sont automatiquement masqués dans l'explorateur de fichiers pour améliorer la lisibilité.

### Guides visuels
Des lignes verticales à 80 et 100 caractères aident à maintenir une largeur de code raisonnable.

### Association de fichiers
Les fichiers .s sont automatiquement reconnus comme du code ARM Assembly.

## Dépannage

### Commande make introuvable
Installer les outils de build sur le Raspberry Pi :
```bash
sudo apt install make
```

### Compilateur ARM introuvable
Installer la chaîne de compilation croisée sur le Raspberry Pi :
```bash
sudo apt install gcc-arm-linux-gnueabihf
```

### Débogueur non fonctionnel
Installer le débogueur multi-architecture sur le Raspberry Pi :
```bash
sudo apt install gdb-multiarch
```

### Erreur "cannot find -lgpiod"
Installer les bibliothèques GPIO 32 bits sur le Raspberry Pi :
```bash
sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install libgpiod-dev:armhf libgpiod2:armhf
```

### Fichiers .o visibles dans l'explorateur
Vérifier que le fichier `.vscode/settings.json` contient :
```json
"files.exclude": {
  "**/*.o": true
}
```

## Ressources complémentaires

- Documentation ARM Assembly : `docs/ARM32_REFERENCE.md`
- API GPIO : `docs/GPIO_API.md`
- Démarrage rapide : `docs/QUICKSTART.md`
- Guide d'installation : `GUIDE_INSTALLATION_ETUDIANTS.md`
