;implementing functions to find string length and print it
section .data
output1 db `Hello, world!\n`, 0
output2 db `Goodbye, world!\n`, 0

section .text
global main

main:
    push output1 ;push output string to stack
    call print   ;call function - pushes return address on stack

    push output2
    call print

    mov rax, 60 ;system exit call
    mov rdi, 0  ;exit code
    syscall     ;exit

print:
    ;prints string pointed to by pointer on stack
    ;param output (rbp+16): pointer to null-terminated 8-bit character array

    push rbp        ;push base pointer to stack
    mov rbp, rsp    ;stores current top of stack in base pointer

    push qword [rbp+16]
    call strlen

    ;save register values
    push rdi
    push rsi

    mov rdx, rax            ;string length for system call
    mov rsi, qword [rbp+16] ;pointer to first char in output
    mov rdi, 1              ;file descriptor
    mov rax, 1              ;sys_write call
    syscall                 ;print

    ;restore register values
    pop rsi
    pop rdi

    leave   ;exit stack frame - same as mov rsp, rbp -> pop rbp
    ret     ;remove parameter from stack

strlen:
    ;gets string length pointed to by pointer on stack
    ;param string (rbp+16): pointer to null-terminated 8-bit character array
    ;returns: string length, held in rax

    push rbp
    mov rbp, rsp

    push r8 ;save register value

    mov rax, 0              ;string length
    mov r8, qword [rbp+16]  ;pointer to first character

loop:
    cmp byte [r8], 0    ;compare current character to null
    je end              ;exit if null character

    add r8, 1   ;move character address to next byte
    add rax, 1  ;increment character counter
    jmp loop

end:
    pop r8  ;restore register value
    leave
    ret
