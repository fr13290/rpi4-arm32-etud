# Environnement ARM32 - Raspberry Pi

TP de programmation assembleur ARM32 sur Raspberry Pi 3B+ / 4.

**OS à utiliser : Raspberry Pi OS Lite (Legacy, 64-bit)**, basé sur Debian 12 Bookworm.
N'utilisez pas la version recommandée par défaut (Debian 13 Trixie) : la bibliothèque GPIO du TP utilise libgpiod 1.x.

## Installation des outils (sur le Raspberry Pi)

```bash
sudo apt update
sudo apt install -y build-essential make git gcc-arm-linux-gnueabihf \
                    binutils-arm-linux-gnueabihf gdb-multiarch
sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install -y libgpiod-dev:armhf libgpiod2:armhf gpiod
```

## Utilisation

```bash
git clone https://github.com/fr13290/rpi4-arm32-etud.git
cd rpi4-arm32-etud/projects/01_hello
make        # compiler
./hello     # exécuter
```

Guide complet : GUIDE_INSTALLATION_ETUDIANTS.md
Démarrage rapide : docs/QUICKSTART.md
