;%include "io.inc"

global _start

extern exit
extern scanf
extern printf
        
section .data
frmt_s : db '%d', 0
frmt_p : db '%d ', 0
        
a dd 0
b dd 0
i dd 0
n dd 0

section .bss

array1 resd 255

section .text
_start:
    mov ebp, esp; for correct debugging
    push ebp
    
    xor eax, eax
;-----------------------------------------------------------------------
; считывание размера массива
push dword n
push dword frmt_s
call scanf
add esp, 8
; конец считывания n
;-----------------------------------------------------------------------
; считываем массив
mov ecx, [n]
xor esi, esi
read_array:
    cmp esi, ecx
    je exit_read_array

    lea eax, [array1 + 4 * esi] ; получим адресс на новый элемент

    push dword eax              ; считывание нового элемента
    push dword frmt_s
    call scanf
    add esp, 8
    
    inc esi
exit_read_array:
; конец считывания массива
;-----------------------------------------------------------------------
;-----------------------------------------------------------------------
; Heap Sort
mov eax, [n]
sar eax, 1
dec eax         ; eax = n / 2 - 1
heapSort_1:
    cmp eax, 0
    jl  exit_heapSort_1
    
    mov [i], eax
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    call heapify
    
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    
    dec eax
    jmp heapSort_1
exit_heapSort_1:

    mov eax, [n]
    dec eax         ; i = n - 1

heapSort_2:
    cmp eax, 0
    jl exit_heapSort_2  
    
    mov esi, [array1]
    mov edi, [array1 + 4 * eax]
    
    mov [array1], edi
    mov [array1 + 4 * eax], esi
    
    mov [i], dword 0h
    mov ebx, [n]
    mov [n], eax
    
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    call heapify
    
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    
    mov [n], ebx
    dec eax
    jmp heapSort_2
exit_heapSort_2:
;-----------------------------------------------------------------------
;-----------------------------------------------------------------------
; вывод отсортированного массива
xor esi, esi
mov ecx, [n]
write_array:
    cmp esi, ecx
    je exit_write_array

    mov eax, [array1 + 4 * esi]

    push eax
    push dword frmt_p
    call printf
    add esp, 8

    inc esi
exit_write_array:
; конец вывода отсортированного массива
;-----------------------------------------------------------------------
push dword 0
call exit
    pop ebp
    xor eax, eax
ret
;-----------------------------------------------------------------------
heapify:

    mov eax, [i]    ; eax = largest

    mov esi, [i]
    sal esi, 1
    inc esi         ; esi - left
    mov edi, [i]
    sal edi, 1
    add edi, 2      ; edi - right

    cmp esi, [n]
    jge heapify_1

    mov ebx, [array1 + 4 * esi] ; ebx = array1[left]
    mov ecx, [array1 + 4 * eax] ; ecx = array1[largest]

    cmp ebx, ecx
    jle heapify_1
    mov eax, esi    ; eax(= largest) = left

heapify_1:

    cmp edi, [n]
    jge heapify_2

    mov ecx, [array1 + 4 * eax] ; ecx = array1[largest]
    mov edx, [array1 + 4 * edi] ; edi = array1[right]

    cmp edx, ecx
    jle heapify_2
    mov eax, edi

heapify_2:
    mov ecx, [i]
    cmp eax, ecx
    je exit_heapify
    
    mov edi, [array1 + 4 * ecx]     ; edi = array1[i]
    mov esi, [array1 + 4 * eax]     ; esi = array1[largest]
    ; swap(array1[i], arr1[largest])
    mov [array1 + 4 * ecx], esi
    mov [array1 + 4 * eax], edi
    
    mov ecx, [i]
    push ecx
    
    mov [i], eax
    call heapify
    
    pop ecx
    mov [i], ecx

exit_heapify:
    ret

