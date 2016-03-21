/*
 *  num.s
 *  prints "0123456789" over and over forever
 *  super useful
 */

.section .text
.global _start

_start:
        mov $1, %rax     # syscall 1 = write
        mov $1, %rdi     # 1 = stdout

_zero:
        xor %rcx, %rcx   # n = 0        
        
_print_num:
        push %rcx        # save n's original value
        add $0x30, %rcx  # ascii value of n
        push %rcx        # save ascii value of n
        mov %rsp, %rsi   # pointer to n = "n"
        mov $1, %rdx     # sizeof(char) = 1 byte
        syscall          # write(1, "n", 1)

        pop %rsi         # throw away ascii value of n
        pop %rcx         # pop %rcx back to its original value
        inc %rcx         # increment
        cmp $10, %rcx    # if n = 10,
        je  _zero        # reset n to 0 before looping again
        jmp _print_num   # loop back to print_num with incremented counter
        
_end:                    # will not be executed     
        mov $60, %rax    # syscall 50 = exit
        xor %rbx, %rbx   # 0
        syscall          # exit(0)
        
