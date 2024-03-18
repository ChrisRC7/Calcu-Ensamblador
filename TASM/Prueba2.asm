;---Etiquetas Principales---
    .model small
    .stack 100h 
    .386
    .data
    .code
    
.code    
start:
    nop
    mov ebp, 0
    mov esp, 0
    mov eax, dword [esp]
    add edx, esp, 8
    mov esi, esp
    lea edi, [ehdr_start + 5B4h]
    mov ebx, 0
    mov ecx, 0
    call __libc_start_main
    call abor
end start