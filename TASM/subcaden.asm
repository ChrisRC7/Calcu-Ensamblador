;Escribir un codigo que verifique si una cadena es subcadena de otra 
;Se debe ingresar una cadena 1 que se verifica si es subcadena de una cadena 2.

.model small
.stack 64
.data

msj1 db 0ah,0dh, 'Cadena 1: ', '$'  ; entrada para la cadena 1
msj2 db 0ah,0dh, 'Cadena 2: ', '$'  ; entrada para la cadena 2
msj3 db 0ah,0dh, 'Verdadero ', '$'  ; mensaje de salida cuando la cadena 1 es subcadena de la cadena 2
msj4 db 0ah,0dh, 'Falso ', '$'  ; mensaje de salida cuando la cadena 1 no es subcadena de la cadena 2
cadena1 db 50 dup(' '), '$'  ; almacenar la cadena 1
cadena2 db 50 dup(' '), '$'  ; almacenar la cadena 2
.code 
inicio:
    mov ax, @data  ; carga el segmento de datos en AX y lo establece
    mov ds, ax  
    
    ; Imprimir mensaje 1
    mov ah, 09  ; cargar el numero de funcion de la interrupcion del servicio de DOS para imprimir una cadena
    mov dx, offset msj1  ; cargar la direccion del msj1 en DX
    int 21h  
    
    ; Leer cadena 1
    lea si, cadena1  ; cargar la direccion de cadena1 en SI y leer cadena 1
    call leer_cadena  
    
    ; Imprimir mensaje 2
    mov ah, 09  ; cargar el numero de funcion de la interrupcion del servicio de DOS para imprimir una cadena
    mov dx, offset msj2  ; cargar la direccion del msj2 en DX
    int 21h  
    
    ; Leer cadena 2
    lea si, cadena2  ; cargar la direccion de cadena1 en SI y leer cadena 2
    call leer_cadena  
    
    ; Comparar cadenas
    lea si, cadena1  ; cargar direccion de cadena1 en SI
    lea di, cadena2  ; cargar direccion de cadena2 en DI

cadena1_loop:
    mov al, [si]  ; cargar el byte de cadena1 en AL
    cmp al, '$'  ; verificar si es el final de cadena1
    je subcadena_found  ; Jump si se cumple
    mov bx, di  ; Mover la direccion de cadena2 a BX

cadena2_loop:
    cmp al, [bx]  ; comparar el byte de cadena1 con el byte de cadena2
    je next_element  ; Si son iguales, avanzar al siguiente byte de cadena1
    inc bx  ; Si no son iguales, avanzar al siguiente byte de cadena2
    cmp byte ptr [bx], '$'  ; verificar si es el final de cadena2
    je no_subcadena_found  ; Jump si se cumple
    jmp cadena2_loop  ; Si no hemos llegado al final de cadena2 jump para seguir comparando

next_element:
    inc si  ; Avanzar al siguiente byte de cadena1 y seguir comparando
    jmp cadena1_loop 

subcadena_found:
    ; Verdadero
    mov ah, 09  ; cargar numero de funcion en DOS para imprimir una cadena
    mov dx, offset msj3  ; cargar el msj 3 en DX
    int 21h  ; llamar a la interrupcion del servicio de DOS para imprimir el mensaje
    jmp fin  

no_subcadena_found:
    ; Falso
    mov ah, 09  ; cargar numero de funcion en DOS para imprimir un cadena
    mov dx, offset msj4  ; cargar el msj 4 en DX
    int 21h  ; llamar a la interrupcion del servicio de DOS para imprimir el mensaje
    jmp fin  

fin:
    mov ah, 4Ch  ; cargar el numero de funcion en DOS para terminar el programa
    int 21h  

leer_cadena:
    mov ah, 01h  ; cargar el numero de funcion de DOS para leer un caracter
    int 21h  
    mov [si], al  ; guardar el caracter leido en la posicion de memoria apuntada por SI
    inc si  ; avanzar al siguiente byte de cadena
    cmp al, 0dh  ; verificar si es el fin de linea
    jne leer_cadena  ; si no es el fin de linea, seguir leyendo caracteres
    ret  ; Retornar al loop

    end inicio  ; fin del programa
