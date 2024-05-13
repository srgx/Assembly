
section .data

SUCCESS equ 0
SYS_exit equ 60

; Ten values
n dd 10

; Total
sumOfSquares dq 0

section .text

global _start
_start:

; First value
mov rbx, 1

; Loop control
mov ecx, dword [n]

sumLoop:

  ; Square number
  mov rax, rbx
  mul rax

  ; Add to sum
  add qword [sumOfSquares], rax

  ; Next value
  inc rbx

  loop sumLoop

last:
  mov rax, SYS_exit
  mov rdi, SUCCESS
  syscall

