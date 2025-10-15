# Guide Makefile Tools

## Installation

1. Ouvrir VSCode
2. `Ctrl+Shift+X` (Extensions)
3. Chercher "Makefile Tools"
4. Installer l'extension Microsoft

## Interface

Après installation, une nouvelle icône apparaît dans la barre latérale gauche (icône d'engrenage avec marteau).

### Panneau Makefile Tools

Le panneau affiche :
- **Configuration** : Profil de build actif
- **Build target** : Cible à compiler (all, clean, run)
- **Launch target** : Binaire à exécuter/déboguer

## Utilisation

### Méthode 1 : Via le panneau Makefile

1. Cliquer sur l'icône Makefile Tools (barre latérale gauche)
2. Sélectionner **Build target** : `all`, `clean`, ou `run`
3. Cliquer sur l'icône ▶️ "Build" en haut du panneau

### Méthode 2 : Via la barre d'état

En bas de VSCode, la barre d'état affiche :
- **Makefile: Default** : Configuration active
- **all** : Target de build (cliquer pour changer)
- Icône 🔨 : Compiler rapidement

### Méthode 3 : Raccourcis clavier

**Linux/Windows :**
- `Ctrl+Shift+B` : Build (utilise la target sélectionnée)

**macOS :**
- `Cmd+Shift+B` : Build

## Configuration

### Sélection du répertoire de build

Par défaut, Makefile Tools compile dans le répertoire du fichier ouvert :
- Ouvrir un fichier `.s` dans un projet
- Le Makefile du même dossier sera utilisé automatiquement

### Changement de target

**Via la barre d'état :**
1. Cliquer sur la target actuelle (ex: "all")
2. Sélectionner : `all`, `clean`, ou `run`

**Via le panneau :**
1. Ouvrir le panneau Makefile Tools
2. Build target → Cliquer sur "Configure"
3. Choisir la target

## Fonctionnalités avancées

### Voir la sortie de compilation

1. Menu **View** → **Output**
2. Dans le menu déroulant : sélectionner "Makefile Tools"
3. Affiche les commandes make et leurs sorties

### Problèmes de compilation

Les erreurs apparaissent automatiquement dans :
- Panneau **Problems** (en bas)
- Surlignage dans l'éditeur

### Debug depuis Makefile Tools

1. Sélectionner **Launch target** dans le panneau
2. Cliquer sur l'icône 🐛 "Debug"
3. Lance automatiquement le débogueur sur le binaire

## Workflow complet

### Développement normal

```
1. Ouvrir facto.s
2. Barre d'état : vérifier target = "all"
3. Cliquer sur 🔨 ou Ctrl+Shift+B
4. Voir les erreurs dans le panneau Problems
5. Corriger et recompiler
```

### Nettoyage et recompilation

```
1. Barre d'état : cliquer sur "all"
2. Sélectionner "clean"
3. Cliquer sur 🔨
4. Barre d'état : sélectionner "all"
5. Cliquer sur 🔨
```

### Exécution

```
1. Barre d'état : sélectionner "run"
2. Cliquer sur 🔨
3. Le programme se compile et s'exécute
4. Sortie visible dans le terminal
```

## Paramètres personnalisés

Les paramètres sont configurés dans `.vscode/settings.json` :

```json
{
  "makefile.configurations": [
    {
      "name": "Default",
      "makeDirectory": "${fileDirname}",
      "makeArgs": [],
      "problemMatchers": ["$gcc"]
    }
  ]
}
```

### Options importantes

- `makeDirectory` : Où chercher le Makefile
- `makeArgs` : Arguments supplémentaires pour make
- `problemMatchers` : Détection des erreurs de compilation

## Avantages vs Tasks

### Makefile Tools
- ✅ Interface graphique intuitive
- ✅ Changement rapide de target (barre d'état)
- ✅ Détection automatique des Makefiles
- ✅ Panneau dédié

### Tasks (Ctrl+Shift+P → Run Task)
- ✅ Plus configurable
- ✅ Tâches composées (Clean & Build)
- ✅ Scripts personnalisés

**Les deux méthodes coexistent !** Utilise celle que tu préfères.

## Dépannage

### "No Makefile found"
- Ouvrir un fichier dans un projet avec un Makefile
- Ou configurer `makefile.makeDirectory` manuellement

### Targets non détectées
- Vérifier que les targets sont déclarées en `.PHONY` dans le Makefile
- Ajouter dans settings.json : `"makefile.phony": ["all", "clean", "run"]`

### Build échoue sans erreur visible
- Menu **View** → **Output** → "Makefile Tools"
- Voir les commandes exactes exécutées

### Panneau Makefile Tools invisible
- Cliquer sur l'icône engrenage+marteau dans la barre latérale gauche
- Ou **View** → **Open View** → "Makefile"

## Ressources

- Documentation officielle : https://github.com/microsoft/vscode-makefile-tools
- Guide VSCode : `docs/VSCODE_GUIDE.md`
