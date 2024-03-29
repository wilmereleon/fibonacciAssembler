.data
    mensaje: .asciiz "Ingrese el número de términos para la serie de Fibonacci: "
    resultado: .asciiz "La serie de Fibonacci es: "
    coma: .asciiz ", "

.text
.globl main
main:
    # Pedir al usuario que ingrese el número de términos
    li $v0, 4
    la $a0, mensaje
    syscall

    # Leer el número de términos
    li $v0, 5
    syscall
    move $t0, $v0 # $t0 tiene el número de términos

    # Inicializar los dos primeros términos de la serie de Fibonacci
    li $t1, 0 # Primer término, f0
    li $t2, 1 # Segundo término, f1

    # Imprimir mensaje inicial
    li $v0, 4
    la $a0, resultado
    syscall

    # Verificar si el número de términos es 0
    beqz $t0, end

    # Imprimir el primer término
    li $v0, 1
    move $a0, $t1
    syscall

    # Decrementar el contador de términos
    addi $t0, $t0, -1
    # Verificar si el número de términos es 1
    beqz $t0, end

    # Imprimir la coma después del primer término
    li $v0, 4
    la $a0, coma
    syscall

    # Imprimir el segundo término
    li $v0, 1
    move $a0, $t2
    syscall

    # Decrementar el contador de términos
    addi $t0, $t0, -1
    # Verificar si aún quedan términos por imprimir
    blez $t0, end

    # Imprimir la coma después del segundo término
    li $v0, 4
    la $a0, coma
    syscall

loop:
    # Calcular el siguiente término de la serie
    add $t3, $t1, $t2 # f(n) = f(n-1) + f(n-2)

    # Decrementar el contador de términos
    addi $t0, $t0, -1
    # Verificar si aún quedan términos por imprimir
    blez $t0, print_last

    # Imprimir el término actual
    li $v0, 1
    move $a0, $t3
    syscall

    # Imprimir la coma
    li $v0, 4
    la $a0, coma
    syscall

    # Preparar para el siguiente ciclo
    move $t1, $t2
    move $t2, $t3

    # Saltar al inicio del bucle
    j loop

print_last:
    # Imprimir el último término
    li $v0, 1
    move $a0, $t3
    syscall

end:
    # Salir del programa
    li $v0, 10
    syscall