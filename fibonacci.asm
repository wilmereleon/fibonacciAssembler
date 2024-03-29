.data
    mensaje: .asciiz "Ingrese el n�mero de t�rminos para la serie de Fibonacci: "
    resultado: .asciiz "La serie de Fibonacci es: "
    coma: .asciiz ", "

.text
.globl main
main:
    # Pedir al usuario que ingrese el n�mero de t�rminos
    li $v0, 4
    la $a0, mensaje
    syscall

    # Leer el n�mero de t�rminos
    li $v0, 5
    syscall
    move $t0, $v0 # $t0 tiene el n�mero de t�rminos

    # Inicializar los dos primeros t�rminos de la serie de Fibonacci
    li $t1, 0 # Primer t�rmino, f0
    li $t2, 1 # Segundo t�rmino, f1

    # Imprimir mensaje inicial
    li $v0, 4
    la $a0, resultado
    syscall

    # Verificar si el n�mero de t�rminos es 0
    beqz $t0, end

    # Imprimir el primer t�rmino
    li $v0, 1
    move $a0, $t1
    syscall

    # Decrementar el contador de t�rminos
    addi $t0, $t0, -1
    # Verificar si el n�mero de t�rminos es 1
    beqz $t0, end

    # Imprimir la coma despu�s del primer t�rmino
    li $v0, 4
    la $a0, coma
    syscall

    # Imprimir el segundo t�rmino
    li $v0, 1
    move $a0, $t2
    syscall

    # Decrementar el contador de t�rminos
    addi $t0, $t0, -1
    # Verificar si a�n quedan t�rminos por imprimir
    blez $t0, end

    # Imprimir la coma despu�s del segundo t�rmino
    li $v0, 4
    la $a0, coma
    syscall

loop:
    # Calcular el siguiente t�rmino de la serie
    add $t3, $t1, $t2 # f(n) = f(n-1) + f(n-2)

    # Decrementar el contador de t�rminos
    addi $t0, $t0, -1
    # Verificar si a�n quedan t�rminos por imprimir
    blez $t0, print_last

    # Imprimir el t�rmino actual
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
    # Imprimir el �ltimo t�rmino
    li $v0, 1
    move $a0, $t3
    syscall

end:
    # Salir del programa
    li $v0, 10
    syscall