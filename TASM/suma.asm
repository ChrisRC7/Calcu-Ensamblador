; Escribir un programa que sume dos cantidades.
; Solo logre sumar cantidades de dos digitos, tres digitos tenia bugs y de 4 digitos aun mas.
; Por lo que el programa esta limitado a dos digitos (00) para funcionar correctamente :).

.model small
.stack 100h
.data
    digit1 db 0ah, 0dh, "Escriba el primer valor: $"  ; solicita el primer valor al usuario
    digit2 db 0ah, 0dh, "Escriba el segundo valor: $" ; solicita el segundo valor al usuario
    result db 0ah, 0dh, "El resultado de la suma es: $" ; mensaje para mostrar el resultado
.code
    main:
        mov ax, @data ; carga el segmento de datos en AX y lo establece
        mov ds, ax  
        
        lea dx, digit1 ; carga la direccion del primer mensaje, lo imprime y llama al servicio DOS
        mov ah, 09h  
        int 21h       
        
        mov ah, 01h   ; lee un caracter y llama al servicio de DOS
        int 21h       
        
        sub al, 30h   ; convierte el caracter ASCII a numero y lo almacena
        mov bh, al   
        
        mov ah, 01h   ; lee otro caracter y llama al servicio de DOS
        int 21h       
        
        sub al, 30h   ; convierte el caracter ASCII a numero y almacena el segundo digito
        mov bl, al   
        
        lea dx, digit2 ; carga la direccion del primer mensaje, lo imprime y llama al servicio DOS
        mov ah, 09h    
        int 21h        
        
        mov ah, 01h    ; lee un caracter y llama al servicio de DOS
        int 21h        
        
        sub al, 30h    ; convierte el caracter ASCII a numero y almacena el primer digito
        mov ch, al    
        
        mov ah, 01h    ;  lee otro caracter y llama al servicio de DOS
        int 21h        
        
        sub al, 30h    ; convierte el caracter ASCII a numero y almacena el segundo digito
        mov cl, al    
        
        add bl, cl    ; suma los dos numeros
        
        mov al, bl    ; mueve el resultado a AL y limpia AH, ajusta el resultado en BCD
        mov ah, 00h   
        aaa           
        
        mov cl, al    ; obtiene el ultimo digito del resultado junto el acarreo
        mov bl, ah    
        
        add bl, bh    ; suma el acarreo al primer digito
        add bl, ch    ; suma el acarreo al segundo digito
        
        mov al, bl    ; mueve el resultado a AL y limpia AH, ajusta el resultado en BCD
        mov ah, 00h   
        aaa           
        
        mov bx, ax    ; almacena el resultado en BX
        
        mov dx, offset result ; carga la direccion del mensaje del resultado, imprime el msj y llama a DOS
        mov ah, 09h    
        int 21h        
        
        mov dl, bh    ; mueve el primer digito del resultado a DL
        add dl, 30h   ; convierte el digito a ASCII
        mov ah, 02h   ; imprime un caracter
        int 21h       ; llama al servicio de DOS para imprimir el primer digito del resultado
        
        mov dl, bl    ; Realiza lo mismo para el segundo digito del resultado
        add dl, 30h   
        mov ah, 02h   
        int 21h       
        
        mov dl, cl    ; Realiza lo mismo para el tercer digito del resultado
        add dl, 30h   
        mov ah, 02h   
        int 21h       
    exit:
        mov ah, 4ch   ; termina el programa
        int 21h       
    end main