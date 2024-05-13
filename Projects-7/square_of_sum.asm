
section .data

SUCCESS equ 0
SYS_exit equ 60

n dd 10
sumOfNumbers dd 0
result dq 0

section .text

global _start
_start:

mov eax, 1
mov ecx, dword [n]

sumLoop:
  add dword [sumOfNumbers], eax
  inc eax
  loop sumLoop

mov eax, dword [sumOfNumbers]
mul dword [sumOfNumbers]
mov dword [result], eax
mov dword [result + 4], edx

last:
  mov rax, SYS_exit
  mov rdi, SUCCESS
  syscall

