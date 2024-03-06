; CalcuTec.asm
.386
.model small
.stack 100h

.data
    mensajeBienvenida db 'Bienvenido a CalcuTec', '$'
    mensajeOperando db 'Por favor ingrese su primer operando: ', '$'
    mensajeOperacion db 'Por favor presione: 1. Para sumar.', '$'
    mensajeSegundoOperando db 'Por favor ingrese su segundo operando: ', '$'
    resultado db 'El resultado de su operaci?n es: ', '$'
    operando1 dd ?
    operando2 dd ?
    suma dd ?

.code
inicio:
    mov ax, @data
    mov ds, ax

    ; Imprimir mensaje de bienvenida
    mov ah, 09h
    lea dx, mensajeBienvenida
    int 21h

    ; Solicitar primer operando
    mov ah, 09h
    lea dx, mensajeOperando
    int 21h

    ; Leer primer operando
    mov ah, 01h
    int 21h
    sub al, 30h ; Convertir de ASCII a n?mero
    mov operando1, eax

    ; Solicitar operaci?n
    mov ah, 09h
    lea dx, mensajeOperacion
    int 21h

    ; Leer operaci?n (solo suma por ahora)
    mov ah, 01h
    int 21h

    ; Solicitar segundo operando
    mov ah, 09h
    lea dx, mensajeSegundoOperando
    int 21h

    ; Leer segundo operando
    mov ah, 01h
    int 21h
    sub al, 30h ; Convertir de ASCII a n?mero
    mov operando2, eax

    ; Realizar suma
    fild operando1
    fild operando2
    fadd
    fistp suma

    ; Imprimir resultado
    mov ah, 09h
    lea dx, resultado
    int 21h
    mov eax, suma
    add al, 30h ; Convertir de n?mero a ASCII
    mov ah, 02h
    int 21h

    ; Terminar programa
    mov ax, 4C00h
    int 21h
end inicio
