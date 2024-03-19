;---Etiquetas Principales---
    .model small
    .stack 100h 
    .386
    .data

;---MENSAJES---
    msg_Menu db 10, 13,'Menu', 10, 13, '$'
    msg_Suma db '   1. Suma $'
    msg_Resta db 10,13,'   2. Resta $'
    msg_Op_Multiplicacion db 10,13,'   3. Multiplicacion $'
    msg_Op_Division db 10,13,'   4. Division $'
    msg_Salir db 10,13,'   5. Salir $'
    msg_Opcion db 10,13,'   Escoge una opcion: $'
    msg_PrimerNumero db 0ah, 0dh, 10,13,10,13,'Ingresa el primer numero: $'
    msg_SegundoNumero db 0ah, 0dh, 10,13,'Ingresa el segundo numero: $'
    msg_Resultado db 0ah, 10,13,10,13,'El resultado es: $'
    msg_CerrarPrograma db 10,13,10,13,'Cerrando el programa... $'
    negativo db 0 ;Indicador de negatico 0 es no negativo, 1 es negativo


;APERTURA DEL PROGRAMA
    .code
start:
    mov ax,@data
    mov ds,ax




;---MOSTRAR MENU---
    menu:
        lea dx,msg_Menu
        mov ah,9
        int 21h

        lea dx,msg_Suma
        mov ah,9
        int 21h

        lea dx,msg_Resta 
        mov ah,9
        int 21h

        lea dx,msg_Op_Multiplicacion
        mov ah,9
        int 21h

        lea dx,msg_Op_Division 
        mov ah,9
        int 21h

        lea dx,msg_Salir 
        mov ah,9    
        int 21h

        lea dx,msg_Opcion 
        mov ah,9
        int 21h

        mov ah,1
        int 21h
        mov bh,al
        sub bh,48


;---SWITCH OPCIONES---
    mov byte [negativo], 0 ; Establece el indicador de negativo en 0 
    cmp bh,1
    je Op_Suma

    cmp bh,2
    je Op_Resta

    cmp bh,3
    je Op_Multiplicacion

    cmp bh,4
    je Op_Division

    cmp bh,5
    je exit_p


;SUMA
    Op_Suma:
    call obtener_numeros  ; Se obtienen los numeros ingresados por el usuario

    add bx, cx

    call mostrar_resultados ;Se muestra el resultado de la operaci?n
    
    jmp menu
    
;RESTA
    Op_Resta:
    call obtener_numeros ; Se obtienen los numeros ingresados por el usuario

    ; Realizar la resta
    sub bx, cx

    call mostrar_resultados ;Se muestra el resultado de la operaci?n

    jmp menu

;Multiplicacion
    Op_Multiplicacion:
    
    call obtener_numeros  ; Se obtienen los numeros ingresados por el usuario 
    
    mov ax, cx
    mul bx
    mov bx, ax
    
    call mostrar_resultados ;Se muestra el resultado de la operaci?n

    jmp menu


;Division
    Op_Division:
    call obtener_numeros ; Se obtienen los numeros ingresados por el usuario
    
    mov ax, bx
    div cx
    mov bx, ax
    
    call mostrar_resultados  ;Se muestra el resultado de la operaci?n

    jmp menu
    
obtener_numeros proc near

    lea dx, msg_PrimerNumero
    
    mov ah, 09h 
    int 21h   

    mov ah, 01h
    int 21h       ;Input del usuario

    sub al, 30h
    mov ah, 0     ; Limpia ah para quedarnos solo con el input del usuario
    mov dx, ax

    mov ax, 1000  
    mul dx
    mov bx, ax      ;Se multiplica por 1000 para guardalo en el registro bx

    mov ah, 01h
    int 21h

    sub al, 30h
    mov ah, 0     ; Limpia ah para quedarnos solo con el input del usuario
    mov dx, ax

    mov ax, 100   
    mul dx
    add bx, ax   ; Se multiplica por 100 para guardalo en el registro bx mas el valor previo

    mov ah, 01h
    int 21h

    sub al, 30h
    mov ah, 0     ; Limpia ah para quedarnos solo con el input del usuario
    mov dx, ax

    mov ax, 10    
    mul dx
    add bx, ax   ; Se multiplica por 10 para guardalo en el registro bx mas el valor previo

    mov ah, 01h
    int 21h

    sub al, 30h  
    mov ah, 0    ; Limpia ah para quedarnos solo con el input del usuario
    add bx, ax   ; Se agrega el ultimo digito al registro bx

    ; Solicitud del segundo n?mero
    lea dx, msg_SegundoNumero
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h

    sub al, 30h
    mov ah, 0    ; Limpia ah para quedarnos solo con el input del usuario
    mov dx, ax

    mov ax, 1000  
    mul dx
    mov cx, ax   ; Se multiplica por 1000 para guardalo en el registro cx

    mov ah, 01h
    int 21h

    sub al, 30h
    mov ah, 0    ; Limpia ah para quedarnos solo con el input del usuario
    mov dx, ax

    mov ax, 100  
    mul dx
    add cx, ax ; Se multiplica por 100 para guardalo en el registro cx mas el valor previo

    mov ah, 01h
    int 21h

    sub al, 30h
    mov ah, 0   ; Limpia ah para quedarnos solo con el input del usuario
    mov dx, ax

    mov ax, 10  
    mul dx
    add cx, ax ; Se multiplica por 10 para guardalo en el registro cx mas el valor previo

    mov ah, 01h
    int 21h

    sub al, 30h 
    mov ah, 0   ; Limpia ah para quedarnos solo con el input del usuario
    add cx, ax  ;Se agrega el ultimo digito al registro cx
     
    ret
obtener_numeros endp


mostrar_resultados proc near

; Comprobar si el resultado es negativo
        test bx, bx            ; Comprueba si bx (el resultado) es negativo
        jns mostrar_resultado  ; Si no es negativo, se continua a mostrar el resultado

        ; Si es negativo, establecer el indicador de negativo y tomar el valor absoluto
        neg bx                 ; Toma el valor absoluto del resultado
        mov byte [negativo], 1 ; Establece el indicador de negativo en 1

    mostrar_resultado:
            ; Mostrar el mensaje del resultado
            mov dx, offset msg_Resultado  ; Carga la direcci?n del mensaje del resultado
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

    convert_looptwo:
            xor dx, dx           ; Limpia DX para la divisi?n
            div bx               ; Divide AX por 10 y almacena el cociente en AX y el residuo en DX
            add dl, '0'          ; Convierte el d?gito en ASCII
            push dx              ; Empuja el d?gito en la pila
            inc cx               ; Incrementa el contador de d?gitos
            test ax, ax          ; Verifica si AX es 0 (fin del n?mero)
            jnz convert_looptwo     ; Si no es cero, contin?a el bucle

    display_looptwo:
            pop dx               ; Saca el d?gito de la pila
            mov ah, 02h          ; Servicio DOS para imprimir un car?cter
            int 21h              ; Llama al servicio de DOS para imprimir el d?gito
            dec cx               ; Decrementa el contador de d?gitos
            jnz display_looptwo     ; Repite hasta que todos los d?gitos se impriman
            
    ret
    
mostrar_resultados endp

;---CIERRA DEL PROGRAMA---
    exit_p:
    lea dx,msg_CerrarPrograma
    mov ah,9
    int 21h

    exit:
    mov ah, 4ch
    int 21h

    end start