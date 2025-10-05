.global init_gpio, write_gpio, read_gpio, clean_gpio
init_gpio:
    push {lr}
    mov r2, r0
    mov r3, r1
    bl gpio_init
    pop {pc}
write_gpio:
    push {lr}
    bl gpio_write
    pop {pc}
read_gpio:
    push {lr}
    bl gpio_read
    pop {pc}
clean_gpio:
    push {lr}
    bl gpio_cleanup
    pop {pc}
