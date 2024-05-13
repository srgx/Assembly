
section .data

NULL equ 0
EXIT_SUCCESS equ 0
SYS_exit equ 60

intNum dd 1498

section .bss

strNum resb 10

section .text
global _start
_start:

mov eax, dword [intNum]
mov rcx, 0
mov ebx, 10

divideLoop:
  mov edx, 0
  div ebx
  push rdx
  inc rcx
  cmp eax, 0
  jne divideLoop
  mov rbx, strNum
  mov rdi, 0

popLoop:
  pop rax
  add al, "0"
  mov byte [rbx + rdi], al
  inc rdi
  loop popLoop
  mov byte [rbx + rdi], NULL

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall

