# Guide VSCode - Développement ARM32

## 🎯 Raccourcis clavier essentiels

### Compilation
- **`Ctrl+Shift+B`** : Compiler le projet courant (Build)
- **`Ctrl+Shift+P`** → "Run Task" → "Clean" : Nettoyer les fichiers objets
- **`Ctrl+Shift+P`** → "Run Task" → "Build & Run" : Compiler et exécuter
- **`Ctrl+Shift+P`** → "Run Task" → "Clean & Build" : Nettoyer et recompiler

### Débogage
- **`F5`** : Lancer le débogage (compile automatiquement avant)
- **`F10`** : Exécuter l'instruction suivante (Step Over)
- **`F11`** : Entrer dans une fonction (Step Into)
- **`Shift+F11`** : Sortir d'une fonction (Step Out)
- **`F9`** : Placer/Retirer un point d'arrêt
- **`Shift+F5`** : Arrêter le débogage

### Navigation
- **`Ctrl+P`** : Recherche rapide de fichiers
- **`Ctrl+Shift+F`** : Rechercher dans tous les fichiers
- **`Ctrl+\``** : Ouvrir/Fermer le terminal intégré

## 📋 Tâches disponibles

Accès : Menu **Terminal** → **Run Task** ou `Ctrl+Shift+P` → "Tasks: Run Task"

### 1. Build (par défaut)
Compile le projet dans le répertoire courant
```bash
make all
```

### 2. Clean
Nettoie tous les fichiers générés (.o et exécutables)
```bash
make clean
```

### 3. Build & Run
Compile et exécute immédiatement le programme
```bash
make run
```

### 4. Clean & Build
Nettoie complètement puis recompile (utile après modifications importantes)
```bash
make clean && make all
```

## 🐛 Configurations de debug

Accès : Menu **Run** → **Start Debugging** ou `F5`

### Debug ARM32 (recommandé)
- Compile automatiquement avant de lancer le débogueur
- S'arrête au point d'entrée (`_start`)
- Affiche les registres en hexadécimal

### Debug ARM32 (no build)
- Lance le débogueur sans recompiler
- Utile pour déboguer rapidement après une première compilation
- Plus rapide si le code n'a pas changé

## 📁 Organisation du workspace

```
rpi4-arm32-etud/
├── .vscode/              # Configuration VSCode
│   ├── tasks.json        # Tâches de build
│   ├── launch.json       # Configurations debug
│   └── settings.json     # Paramètres du projet
├── projects/             # Vos projets
│   ├── 01_hello/
│   ├── 02_addition/
│   └── ...
├── tools/
│   └── Makefile.master   # Makefile commun
└── lib/
    └── gpio/             # Bibliothèque GPIO
```

## 💡 Conseils d'utilisation

### Pour compiler un projet
1. Ouvrir un fichier `.s` dans le projet
2. Appuyer sur `Ctrl+Shift+B`
3. Le binaire est créé dans le même dossier

### Pour déboguer
1. Ouvrir le fichier principal (celui avec `_start`)
2. Placer des points d'arrêt avec `F9`
3. Appuyer sur `F5` pour lancer le debug
4. Utiliser `F10` pour avancer pas à pas

### Visualiser les registres
Pendant le débogage :
- Ouvrir **Debug Console** (bas de l'écran)
- Les registres s'affichent automatiquement
- Format hexadécimal par défaut

### Terminal intégré
- Ouvrir avec ``Ctrl+` ``
- Utiliser les commandes make directement :
  ```bash
  make all
  make run
  make clean
  ```

## 🔧 Personnalisation

### Modifier les tâches
Éditer `.vscode/tasks.json` pour ajouter vos propres commandes

### Changer les raccourcis
`Ctrl+K Ctrl+S` → **Keyboard Shortcuts**

### Thèmes et apparence
`Ctrl+K Ctrl+T` → Choisir un thème

## 🆘 Dépannage

### "make: command not found"
```bash
sudo apt install make
```

### "arm-linux-gnueabihf-gcc: command not found"
```bash
sudo apt install gcc-arm-linux-gnueabihf
```

### Le debug ne fonctionne pas
Vérifier que `gdb-multiarch` est installé :
```bash
sudo apt install gdb-multiarch
```

### Les fichiers .o apparaissent dans l'explorateur
Ils sont normalement masqués. Si ce n'est pas le cas :
1. Ouvrir `.vscode/settings.json`
2. Vérifier la présence de :
   ```json
   "files.exclude": {
     "**/*.o": true
   }
   ```

## 📚 Ressources

- [Documentation ARM Assembly](docs/ARM32_REFERENCE.md)
- [API GPIO](docs/GPIO_API.md)
- [Quick Start](docs/QUICKSTART.md)
- [Guide installation](GUIDE_INSTALLATION_ETUDIANTS.md)

---

**Questions ?** Consultez d'abord ce guide et la documentation dans `docs/`
