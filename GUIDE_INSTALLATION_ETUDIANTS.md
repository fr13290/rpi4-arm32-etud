# Installation - Raspberry Pi ARM32

Ce guide complète le sujet de TP (TP-fin.pdf).

## Matériel

- Raspberry Pi 4 (2 Go minimum) ou Raspberry Pi 3B+
- Carte microSD 16 Go minimum
- PC Debian 13 (ou macOS)
- Câble Ethernet
- LED, résistances 330 ohms et 10 kohms, boutons poussoirs, breadboard

## 1. Graver la carte SD

Dans Raspberry Pi Imager (version 2.x) :

- **Appareil** : votre modèle de Raspberry Pi
- **Système** : `Raspberry Pi OS (other)` puis **`Raspberry Pi OS (Legacy, 64-bit) Lite`**
  (Debian 12 Bookworm, sans bureau).
  **Ne choisissez pas** l'image recommandée par défaut (Debian 13 Trixie) : la bibliothèque GPIO du TP utilise libgpiod 1.x.
- **Personnalisation** : nom d'hôte `rpi4-etudiant`, utilisateur `pi` avec un mot de passe,
  SSH activé avec authentification par mot de passe, fuseau Europe/Paris
- Écrire l'image, attendre la fin de l'écriture ET de la vérification, **ne pas retirer la carte**.

## 2. IP statique (avant le premier démarrage)

La partition `bootfs` est encore montée sur votre PC (par exemple `/media/VOTRE_USER/bootfs/`, repérez-la avec `lsblk`).
Éditer `cmdline.txt` et ajouter à la **fin de l'unique ligne** (sans retour à la ligne) :

```
ip=10.96.26.N::10.96.26.254:255.255.255.0:rpi4-etudiant:eth0:off:10.100.1.53:10.100.1.54
```

Remplacer **N par l'adresse attribuée à votre poste (entre 100 et 199)** : une adresse par poste.

| Paramètre | Valeur |
|---|---|
| Adresse IP | `10.96.26.N` (N entre 100 et 199) |
| Masque | `255.255.255.0` |
| Passerelle | `10.96.26.254` |
| DNS | `10.100.1.53` ou `10.100.1.54` |

Puis `sync` et démonter les deux partitions avant de retirer la carte.

## 3. Premier démarrage

Insérer la carte, brancher Ethernet puis l'alimentation, attendre 30 à 60 secondes, puis :

```bash
ping -c 4 10.96.26.N
ssh pi@10.96.26.N
```

## 4. Installer les outils (sur le Raspberry Pi)

Vérifier d'abord que les noms de domaine sont résolus :

```bash
ping -c 2 deb.debian.org
```

Si le message est `Temporary failure in name resolution`, le DNS n'est pas pris en compte.
Relever le nom de la connexion réseau, puis lui indiquer les serveurs DNS :

```bash
nmcli -t -f NAME,DEVICE connection show
sudo nmcli connection modify "NOM_AFFICHE" ipv4.dns "10.100.1.53 10.100.1.54"
sudo nmcli connection up "NOM_AFFICHE"
```

Puis installer les outils :

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential make git gcc-arm-linux-gnueabihf \
                    binutils-arm-linux-gnueabihf gdb-multiarch
sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install -y libgpiod-dev:armhf libgpiod2:armhf gpiod
```

## 5. Télécharger le dépôt (sur le Raspberry Pi)

```bash
cd ~
git clone https://github.com/fr13290/rpi4-arm32-etud.git
cd rpi4-arm32-etud
```

## 6. VSCode sur votre PC

### Debian

```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update && sudo apt install code
```

### macOS

```bash
brew install --cask visual-studio-code
```

### Extension Remote - SSH, profil `TP-Dev` et configuration

1. Installer l'extension **Remote - SSH**.
2. Télécharger le profil (sans cloner le dépôt sur le PC) :
   https://github.com/fr13290/rpi4-arm32-etud/blob/main/.vscode/profiles/TP-Dev.code-profile
   puis bouton **Download raw file**.
3. Dans VSCode : `F1` → **Profiles: Import Profile…** → **Select File** → `TP-Dev.code-profile` → **Create**.
   Vérifier que le profil actif est **TP-Dev** (engrenage en bas à gauche).
4. Ajouter dans `~/.ssh/config` :

```
Host rpi4-dev
    HostName 10.96.26.N
    User pi
    ServerAliveInterval 60
```

## 7. Connexion au Raspberry Pi

1. `F1` (ou `Cmd+Shift+P`) puis **Remote-SSH: Connect to Host** puis `rpi4-dev`
2. **File → Open Folder** puis `/home/pi/rpi4-arm32-etud`
3. Installer les extensions **côté Raspberry Pi** (VSCode ne les copie pas depuis le PC) :
   onglet Extensions (`Ctrl+Shift+X`), section **SSH: rpi4-dev** → **Install** sur **Native Debug**
   (`webfreak.debug`) et **Arm Assembly** (`dan-c-underwood.arm`).
4. `F1` → **Developer: Reload Window**, puis vérifier que Native Debug est listé dans « SSH: rpi4-dev ».

> Si VSCode affiche « Configured debug type 'gdb' is not supported » avec un bouton
> « Install gdb Extension » : ne pas cliquer, installer Native Debug (étape 3).
> Contrôle sur le Pi : `ls ~/.vscode-server/extensions | grep -i webfreak`

## 8. Vérifier la chaîne de compilation

```bash
cd ~/rpi4-arm32-etud/projects/01_hello
make
```

`make` doit afficher deux commandes (`as` puis `ld`) et créer l'exécutable `hello`.
Le squelette est vide : à vous de le compléter (voir le sujet de TP).

## Raccourcis

- `Ctrl+Shift+B` (`Cmd+Shift+B` sur Mac) : compiler
- `F5` (`Fn+F5` sur Mac) : déboguer
- `F10` (`Fn+F10` sur Mac) : instruction suivante

## Documentation

- `docs/QUICKSTART.md`
- `docs/VSCODE_GUIDE.md`
- `docs/REFERENCE_ARM32.md`
- `docs/GPIO_API.md`
