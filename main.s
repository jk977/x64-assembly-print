;implementing functions to find string length and print it
section .rodata
output1 db `Hello, world!\n`
o1_length equ $-output1

output2 db `Goodbye, world!\n`
o2_length equ $-output2

section .text
global _start

_start:
    push output1 ;push output string to stack
    push o1_length
    call print   ;call function - pushes return address on stack

    push output2
    push o2_length
    call print

    mov rax, 60 ;system exit call
    mov rdi, 0  ;exit code
    syscall     ;exit

print:
    ;prints string pointed to by pointer on stack
    ;param length (rbp+16): length of string to print
    ;param output (rbp+24): pointer to null-terminated 8-bit character array

    push rbp                ;push base pointer to stack
    mov rbp, rsp            ;stores current top of stack in base pointer

    push rdi
    push rsi

    mov rdx, qword [rbp+16]     ;string length for system call
    mov rsi, qword [rbp+24]     ;pointer to first char in output
    mov rdi, 1                  ;file descriptor
    mov rax, 1                  ;sys_write call
    syscall                     ;print

    pop rsi
    pop rdi

    leave   ;exit stack frame - same as mov rsp, rbp -> pop rbp
    ret 16  ;frees qword parameter
