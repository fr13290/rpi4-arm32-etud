# Installation - Raspberry Pi 4 ARM32

## Matériel
- Raspberry Pi 4 (2GB min)
- MicroSD 16GB
- PC Debian 13

## 1. Graver SD card

```bash
# PC Debian - Installer Imager
wget https://downloads.raspberrypi.org/imager/imager_latest_amd64.deb
sudo dpkg -i imager_latest_amd64.deb
rpi-imager
```

**Config Imager :**
- OS : Raspberry Pi OS Lite 64-bit
- Hostname : `rpi4-etudiant`
- User/Pass : `pi` / votre_mdp
- SSH : Activer
- IP fixe : `192.168.1.XXX`

## 2. Premier boot RPi

```bash
# Depuis PC - Se connecter
ssh pi@192.168.1.XXX

# Mise à jour
sudo apt update && sudo apt upgrade -y
sudo reboot
```

## 3. Installer outils (sur RPi)

```bash
ssh pi@192.168.1.XXX

sudo apt install -y gcc-arm-linux-gnueabihf \
                    gdb-multiarch \
                    gpiod libgpiod-dev \
                    git
```

## 4. Télécharger workspace

```bash
cd ~
git clone https://github.com/fr13290/rpi4-arm32-student.git
cd rpi4-arm32-student
```

## 5. VSCode sur PC

```bash
# Installer VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update && sudo apt install code

# Extensions
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension dan-c-underwood.arm
code --install-extension webfreak.debug

# Config SSH
cat >> ~/.ssh/config << 'SSHEOF'
Host rpi4
    HostName 192.168.1.XXX
    User pi
SSHEOF
```

## 6. Connexion Remote

1. VSCode → `Ctrl+Shift+P` → "Remote-SSH: Connect"
2. Sélectionner `rpi4`
3. `File` → `Open Folder` → `/home/pi/rpi4-arm32-student`

## 7. Test hello.s

```bash
# Compléter projects/01_hello/hello.s avec :
```

```arm
.global _start
.data
msg: .ascii "Hello ARM32\n"
.text
_start:
    mov r0, #1
    ldr r1, =msg
    mov r2, #12
    mov r7, #4
    svc #0
    mov r0, #0
    mov r7, #1
    svc #0
```

```bash
make all
make run
```

## Raccourcis
- `Ctrl+Shift+B` : Build
- `F5` : Debug
- `F10` : Step

## Docs
- `docs/QUICKSTART.md`
- `docs/ARM32_REFERENCE.md`
- `docs/GPIO_API.md`
