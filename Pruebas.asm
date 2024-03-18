.model small
.stack 100h
.data
    digit1 db 0ah, 0dh, "Escriba el primer valor: $"  ; solicita el primer valor al usuario
    digit2 db 0ah, 0dh, "Escriba el segundo valor: $" ; solicita el segundo valor al usuario
    result db 0ah, 0dh, "El resultado de la suma es: $" ; mensaje para mostrar el resultado
    numero1 dw ?  ; Variable para almacenar el primer n?mero ingresado (hasta 4 d?gitos)
    numero2 dw ?  ; Variable para almacenar el segundo n?mero ingresado (hasta 4 d?gitos)
    suma dw ?     ; Variable para almacenar la suma de los dos n?meros (hasta 4 d?gitos)
    negativo db 0 ; Indicador de si el resultado es negativo (0 = no negativo, 1 = negativo)
.code
    main:
        mov ax, @data ; carga el segmento de datos en AX y lo establece
        mov ds, ax  

        ; Solicitud del primer n?mero
        lea dx, digit1
        mov ah, 09h
        int 21h
        
        mov ah, 01h
        int 21h
        
        sub al, 30h
        mov ah, 0     ; Limpia AH
        mov dx, ax
        
        mov ax, 1000
        mul dx
        mov bx, ax
        
        mov ah, 01h
        int 21h
        
        sub al, 30h
        mov ah, 0
        mov dx, ax
        
        mov ax, 100
        mul dx
        add bx, ax
        
        mov ah, 01h
        int 21h
        
        sub al, 30h
        mov ah, 0
        mov dx, ax
        
        mov ax, 10
        mul dx
        add bx, ax
        
        mov ah, 01h
        int 21h
        
        sub al, 30h
        mov ah, 0
        add bx, ax

        ; Solicitud del segundo n?mero
        lea dx, digit2
        mov ah, 09h
        int 21h
        
        mov ah, 01h
        int 21h
        
        sub al, 30h
        mov ah, 0     ; Limpia AH
        mov dx, ax
        
        mov ax, 1000
        mul dx
        mov cx, ax
        
        mov ah, 01h
        int 21h
        
        sub al, 30h
        mov ah, 0
        mov dx, ax
        
        mov ax, 100
        mul dx
        add cx, ax
        
        mov ah, 01h
        int 21h
        
        sub al, 30h
        mov ah, 0
        mov dx, ax
        
        mov ax, 10
        mul dx
        add cx, ax
        
        mov ah, 01h
        int 21h
        
        sub al, 30h
        mov ah, 0
        add cx, ax

        ; Realizar la resta
        sub bx, cx

        ; Comprobar si el resultado es negativo
        test bx, bx            ; Comprueba si BX (el resultado) es negativo
        jns mostrar_resultado  ; Si no es negativo, saltar a mostrar el resultado

        ; Si es negativo, establecer el indicador de negativo y tomar el valor absoluto
        neg bx                 ; Toma el valor absoluto del resultado
        mov byte [negativo], 1 ; Establece el indicador de negativo en 1

mostrar_resultado:
        ; Mostrar el mensaje del resultado
        mov dx, offset result ; Carga la direcci?n del mensaje del resultado
        mov ah, 09h           ; Servicio DOS para imprimir una cadena
        int 21h               ; Llama al servicio de DOS

        ; Mostrar el signo "-" si el resultado es negativo
        cmp byte [negativo], 1 ; Comprueba si el resultado es negativo
        jne convertir_mostrar ; Si no es negativo, contin?a con la conversi?n y muestra el resultado

        ; Si es negativo, imprime el signo "-"
        mov dl, '-'           ; Carga el signo negativo "-" en DL
        mov ah, 02h           ; Servicio DOS para imprimir un car?cter
        int 21h               ; Llama al servicio de DOS para imprimir el signo negativo

convertir_mostrar:
        mov ax, bx 
        ; Convertir y mostrar el n?mero almacenado en BX (resultado) como una cadena ASCII
        mov cx, 0             ; Inicializa el contador de d?gitos
        mov bx, 10            ; Prepara BX para la divisi?n

convert_loop:
        xor dx, dx           ; Limpia DX para la divisi?n
        div bx               ; Divide AX por 10 y almacena el cociente en AX y el residuo en DX
        add dl, '0'          ; Convierte el d?gito en ASCII
        push dx              ; Empuja el d?gito en la pila
        inc cx               ; Incrementa el contador de d?gitos
        test ax, ax          ; Verifica si AX es 0 (fin del n?mero)
        jnz convert_loop     ; Si no es cero, contin?a el bucle

display_loop:
        pop dx               ; Saca el d?gito de la pila
        mov ah, 02h          ; Servicio DOS para imprimir un car?cter
        int 21h              ; Llama al servicio de DOS para imprimir el d?gito
        dec cx               ; Decrementa el contador de d?gitos
        jnz display_loop     ; Repite hasta que todos los d?gitos se impriman

        ; Fin del programa
        mov ah, 4ch          ; Servicio DOS para terminar el programa
        int 21h              ; Llama al servicio de DOS

        end main
