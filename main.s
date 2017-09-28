section .data
output db `Hello, world!\n`
length dq $-output

section .text
global main

main:
    push length ;push second parameter to stack
    push output ;push first parameter to stack
    call print  ;call function - pushes return address on stack

    mov rax, 60 ;system exit call
    mov rdi, 0  ;exit code
    syscall     ;exit

print:
    ;param1: char pointer to output (accessed via rbp+16)
    ;param2: pointer to output length (accessed via rbp+24)

    push rbp        ;push base pointer to stack
    mov rbp, rsp    ;stores current top of stack in base pointer

    ;current stack layout:
    ;   Top
    ;       - Return address (rbp+0; pushed by call)
    ;       - Previous top of stack (rbp+8)
    ;       - output (rbp+16; parameter)
    ;       - length (rbp+24; parameter)
    ;   Bottom (start of unallocated memory)

    push rdi
    push rsi

    mov r8, qword [rbp+24]  ;stores address of string length in r8

    mov rax, 1              ;sys_write call
    mov rdi, 1              ;file descriptor
    mov rsi, qword [rbp+16] ;pointer to first char in `hi!\n`
    mov rdx, qword [r8]     ;string length
    syscall                 ;print

    pop rsi         ;restore value
    pop rdi         ;see above
    leave           ;exit stack frame - same as mov rsp, rbp -> pop rbp
