# Référence ARM32

## Registres
- r0-r3: Arguments et retour
- r4-r11: Variables (sauvegarder avec push/pop)
- r13 (sp): Stack pointer
- r14 (lr): Link register
- r15 (pc): Program counter

## Instructions basiques
- mov r0, #5          ; r0 = 5
- ldr r0, =label      ; r0 = adresse
- ldr r0, [r1]        ; r0 = valeur à adresse r1
- str r0, [r1]        ; Stocker r0 à adresse r1
- add r0, r1, r2      ; r0 = r1 + r2
- sub r0, r1, r2      ; r0 = r1 - r2
- mul r0, r1, r2      ; r0 = r1 * r2
- cmp r0, r1          ; Comparer
- b label             ; Saut
- beq label           ; Saut si égal
- bne label           ; Saut si différent
- bl fonction         ; Appel fonction
- bx lr               ; Retour fonction

## Syscalls
- r7 = numéro syscall
- r0-r2 = paramètres
- svc #0 = exécuter

Syscalls courants:
- r7=#1: exit (r0=code)
- r7=#4: write (r0=fd, r1=buf, r2=len)
