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
        mov bx, ax   
        
        mov ah, 01h   ; lee otro caracter y llama al servicio de DOS
        int 21h       
        
        sub al, 30h   ; convierte el caracter ASCII a numero y almacena el segundo digito
        mov bl, al   
        
        mov ah, 01h   ; lee un caracter y llama al servicio de DOS
        int 21h       
        
        sub al, 30h   ; convierte el caracter ASCII a numero y almacena el tercer digito
        mov bh, al   
        
        mov ah, 01h   ;  lee otro caracter y llama al servicio de DOS
        int 21h       
        
        sub al, 30h   ; convierte el caracter ASCII a numero y almacena el cuarto digito
        mov cl, al   
        
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
        mov dh, al    
        
        mov ah, 01h    ;  lee otro caracter y llama al servicio de DOS
        int 21h        
        
        sub al, 30h    ; convierte el caracter ASCII a numero y almacena el tercer digito
        mov dh, al    
        
        mov ah, 01h    ;  lee otro caracter y llama al servicio de DOS
        int 21h        
        
        sub al, 30h    ; convierte el caracter ASCII a numero y almacena el cuarto digito
        mov dl, al    
        
        add bl, dh    ; suma los dos n?meros de dos d?gitos
        
        adc bh, dl    ; suma los dos n?meros de dos d?gitos y el acarreo de la suma anterior
        
        adc ch, dh    ; Suma el acarreo al tercer d?gito
        
        adc dh, dl    ; Suma el acarreo al cuarto d?gito
        
        mov bx, ax    ; almacena el resultado en BX
        
        mov dx, offset result ; carga la direcci?n del mensaje del resultado, imprime el msj y llama a DOS
        mov ah, 09h    
        int 21h        
        
        mov dl, bh    ; mueve el primer d?gito del resultado a DL
        add dl, 30h   ; convierte el d?gito a ASCII
        mov ah, 02h   ; imprime un caracter
        int 21h       ; llama al servicio de DOS para imprimir el primer d?gito del resultado
        
        mov dl, bl    ; Realiza lo mismo para el segundo d?gito del resultado
        add dl, 30h   
        mov ah, 02h   
        int 21h       
        
        mov dl, ch    ; Realiza lo mismo para el tercer d?gito del resultado
        add dl, 30h   
        mov ah, 02h   
        int 21h       
        
        mov dl, dh    ; Realiza lo mismo para el cuarto d?gito del resultado
        add dl, 30h   
        mov ah, 02h   
        int 21h       
    exit:
        mov ah, 4ch   ; termina el programa
        int 21h       
    end main
