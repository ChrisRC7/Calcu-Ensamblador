;Escribir un codigo que verifique si dos cadenas son iguales
;El programa pide que ingrese una cadena 1 y luego una cadena 2 y compara caracter por caracter para ver si son iguales.

.model small
.stack 64
.data

msj1 db 0ah,0dh, 'Cadena 1: ', '$'  ; entrada para la cadena 1
msj2 db 0ah,0dh, 'Cadena 2: ', '$'  ; entrada para la cadena 2
msj3 db 0ah,0dh, 'Son iguales ', '$'  ; mensaje de salida cuando las cadenas son iguales
msj4 db 0ah,0dh, 'Son diferentes ', '$'  ; mensaje de salida cuando las cadenas son diferentes
cadena1 db 50 dup(' '), '$'  ; almacenar la cadena 1
cadena2 db 50 dup(' '), '$'  ; almacenar la cadena 2
.code 
inicio:
    mov ax, @data  ; carga el segmento de datos en AX y lo establece
    mov ds, ax  
    
    ; Imprimir mensaje 1
    mov ah, 09  ; Cargar el numero de funcion de la interrupcion del servicio de DOS para imprimir una cadena
    mov dx, offset msj1  ; Cargar la direccion del msj1 en DX
    int 21h  
    
    ; Leer cadena 1
    lea si, cadena1  ; Cargar la direccion de cadena1 en SI
    call leer_cadena
    
    ; Imprimir mensaje 2
    mov ah, 09  ; cargar el numero de funcion de la interrupcion del servicio de DOS para imprimir una cadena
    mov dx, offset msj2  ; Cargar la direcci?n del msj2 en DX
    int 21h  
    
    ; Leer cadena 2
    lea si, cadena2  ; Cargar la direcci?n de cadena2 en SI
    call leer_cadena  
    
    ; Determinar la cantidad de datos a comparar
    
    mov cx, 50  ; cantidad maxima de datos a comparar
    mov ax, DS  ; mov el segmento de datos a AX
    mov es, ax  ; mov los datos al segmento extra

compara: 
    lea si, cadena1  ; cargar la direccion de cadena1 en SI y cadena 2 en DI
    lea di, cadena2  
    repe cmpsb  ; comparar los bytes de cadena1 y cadena2
    jne diferente  ; si no son iguales jump a "diferente"
    je iguales  ; si son iguales jump a "iguales"
 
iguales:
    ; Las cadenas son iguales
    mov ax, @data  ; carga el segmento de datos en AX y lo establece
    mov ds, ax  
    mov ah, 09  ; cargar el numero de funcion de la interrupcion del servicio de DOS para imprimir una cadena
    mov dx, offset msj3  ; cargar la direccion del msj3 en DX
    int 21h  ; Imprimir el msj 3
    jmp fin  

diferente:
    ; Las cadenas son diferentes
    mov ax, @data  ; carga el segmento de datos en AX y lo establece
    mov ds, ax  ; 
    mov ah, 09  ; cargar el numero de funcion de la interrupcion del servicio de DOS para imprimir una cadena
    mov dx, offset msj4  ; cargar la direccion del msj3 en DX
    int 21h  ; Imprimir el msj 4
    jmp fin  

fin:
    mov ah, 4Ch  ; cargar el numero de funcion de la interrupcion del servicio de DOS para terminar el programa
    int 21h  ; llamar a la interrupcion del servicio de DOS para terminar el programa

leer_cadena:
    mov ah, 01h  ; cargar el numero de funcion de la interrupci?n del servicio de DOS para leer un caracter y para leer un caracter
    int 21h  
    mov [si], al  ; guardar el caracter leido en la posicion de memoria apuntada por SI
    inc si  ; avanzar al siguiente byte de cadena
    cmp al, 0dh  ; verificar si es el fin de la cadena
    jne leer_cadena  ; jump si no es el final de la cadena
    ret  ; Retornar al loop

end inicio  ; fin del programa
