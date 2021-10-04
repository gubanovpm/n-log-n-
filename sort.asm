global main

extern exit
extern scanf
extern printf

section .text
main

; считывание размера массива
push dword n
push dword frmt_s
call scanf
add esp, 8
; конец считывания n

; считываем массив
mov ecx, [n]
xor rsi, rsi
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
push dword 0
call exit
 
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
