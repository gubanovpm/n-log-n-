global main

extern exit
extern scanf
extern printf

section .text
main:
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

heapSort:    
    

;-----------------------------------------------------------------------
;-----------------------------------------------------------------------
; вывод отсортированного массива
xor esi, esi
mov ecx, [n]
write_array:
    cmp esi, ecx
    je exit_write_array

    mov eax, [array1 + 8 * esi]

    push eax
    push dword frmt_p
    call printf
    add esp, 8

    inc rsi
exit_write_array:
; конец вывода отсортированного массива
;-----------------------------------------------------------------------
push dword 0
call exit

ret
;-----------------------------------------------------------------------
heapify:

    mov eax, [i]    ; rax = largest

    mov esi, [i]
    sal esi, 1
    inc esi         ; rsi - left
    mov edi, [i]
    sal edi, 1
    add edi, 2      ; rdi - right

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
    mov [array1 + 4 * eax], edx
    
    mov [i], eax
    call heapify

exit_heapify:
    ret
        
    

section .data
frmt_s : db '%d', 0
frmt_p : db '%d ', 0
array1 resd 255
array2 resd 255
    
a dd 0
b dd 0
i dd 0
n dd 0
