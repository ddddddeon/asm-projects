global start

section .text
bits 32

start:

.begin_loop:
        mov eax, 0xb8000            ; eax is the start of vga text buffer
        xor ebx, ebx                ; ebx is our counter

.kallisti:                          ; print "kallisti" to text buffer
        mov dword [eax], 0x2f612f6b ; 'a' 'k'
        add eax, 0x4                ; forward 4 bytes 
        mov dword [eax], 0x2f6c2f6c ; 'l' 'l'
        add eax, 0x4                ; forward
        mov dword [eax], 0x2f732f69 ; 's' 'i'
        add eax, 0x4                ; forward
        mov dword [eax], 0x2f692f74 ; 'i' 't'
        add eax, 0x4                ; forward
                                    ; 16 bytes total, 8 characters
        
        inc ebx                     ; increment counter
        cmp ebx, 250                ; is counter 250?
                                    ; (10 * "kallisti" per line) * (25 lines) = 250 * "kallisti"
        jne .kallisti               ; loop to 250

        mov eax, 0xb8000            ; back to start of vga text buffer
        xor ebx, ebx                ; reset counter

        xor ecx, ecx		    ; zero out ecx for use as a counter
        call pause		    ; by pause subroutine
        
.deon:                              ; print "deon" to text buffer
        mov dword [eax], 0x4f654f64 ; 'e' 'd'
        add eax, 0x4                ; forward 4 bytes 
        mov dword [eax], 0x4f6e4f6f ; 'n' 'o'
        add eax, 0x4                ; forward
                                    ; 8 bytes total, 4 characters
        
        inc ebx                     ; increment counter
        cmp ebx, 500                ; is counter 500?
                                    ; (20 * "deon" per line) * (25 lines) = 500 * "deon"
        jne .deon                   ; loop to 500

        xor ecx, ecx		    ; reset counter at ecx to 0
        call pause		    ; and pause for ~a sec
        
.repeat:
        jmp .begin_loop		    ; infinite loop
        

pause:   
.wait_start:
        nop			    ; no op
        inc ecx			    ; increment counter
        cmp ecx, 600000000	    ; do ~600 million no-ops
        jne .wait_start		    ; in a loop
        ret			    ; and return to caller
