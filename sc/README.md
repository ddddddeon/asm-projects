#sc

An example of making system calls in x86 assembly, using the AT&T syntax.
Calls `setuid(0)`, then `execve("/bin/sh", [], [])`, comprising 45 bytes of machine code when assembled.
*DO NOT use this code to run a shell on any machine to which you don't have access!*
