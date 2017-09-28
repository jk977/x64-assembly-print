section .text
global main

main:
    times 10 call hello ;call function 10 times
    mov rax, 60         ;system exit call
    mov rdi, 0          ;exit code
    syscall             ;exit

hello:
    push rbp        ;store base pointer
    mov rbp, rsp    ;stores current top of stack in base pointer
    sub rsp, 64     ;reserve space for string to print

    push rdi        ;save register value (must be preserved across functions)
    push rsi        ;same as above
    push `hi!\n`    ;string to print (backticks to allow escape sequence)

    mov rax, 1      ;sys_write call
    mov rdi, 1      ;file descriptor
    mov rsi, rsp    ;pointer to first char in `hi!\n`
    mov rdx, 4      ;string length
    syscall         ;print

    add rsp, 64     ;frees space taken up by output string
    pop rsi         ;restore value
    pop rdi         ;see above
    leave           ;exit stack frame - same as mov rsp, rbp -> pop rbp
