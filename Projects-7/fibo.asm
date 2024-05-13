
section .data

SUCCESS equ 0
SYS_exit equ 60
n equ 30

a dd 0
result dd 1

section .text

global _start
_start:

mov eax, n
cmp eax, dword [a]
jne testOne
  mov dword [result], eax
  jmp last
testOne:
  cmp eax, dword [result]
  je last

mov ecx, n
dec ecx

mainLoop:
  mov eax, dword [a]
  mov ebx, dword [result]
  add dword [result], eax
  mov dword [a], ebx
  loop mainLoop

last:
  mov rax, SYS_exit
  mov rdi, SUCCESS
  syscall

