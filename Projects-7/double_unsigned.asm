
section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

dNum1 dd 800000
dNum2 dd 60000
dNum3 dd 4000
dNum4 dd 200

dAns1 dd 0
dAns2 dd 0
dAns3 dd 0
dAns6 dd 0
dAns7 dd 0
dAns8 dd 0
dAns16 dd 0
dAns17 dd 0
dAns18 dd 0
dRem18 dd 0

qAns11 dq 0
qAns12 dq 0
qAns13 dq 0

qNum1 dq 7000000100

section .text
global _start
_start:

; 800000 + 60000 = 860000
mov eax, dword [dNum1]
add eax, dword [dNum2]
mov dword [dAns1], eax

; 800000 + 4000 = 804000
mov eax, dword [dNum1]
add eax, dword [dNum3]
mov dword [dAns2], eax

; 4000 + 200 = 4200
mov eax, dword [dNum3]
add eax, dword [dNum4]
mov dword [dAns3], eax

; 800000 - 60000 = 740000
mov eax, dword [dNum1]
sub eax, dword [dNum2]
mov dword [dAns6], eax

; 800000 - 4000 = 796000
mov eax, dword [dNum1]
sub eax, dword [dNum3]
mov dword [dAns7], eax

; 60000 - 200 = 59800
mov eax, dword [dNum2]
sub eax, dword [dNum4]
mov dword [dAns8], eax

; 800000 * 4000 = 3200000000
mov eax, dword [dNum1]
mul dword [dNum3]
mov dword [qAns11], eax
mov dword [qAns11 + 4], edx

; 60000 * 60000 = 3600000000
mov eax, dword [dNum2]
mul dword [dNum2]
mov dword [qAns12], eax
mov dword [qAns12 + 4], edx

; 60000 * 200 = 12000000
mov eax, dword [dNum2]
mul dword [dNum4]
mov dword [qAns13], eax
mov dword [qAns13 + 4], edx

; 800000 / 60000 = 13
mov edx, 0
mov eax, dword [dNum1]
div dword [dNum2]
mov dword [dAns16], eax

; 4000 / 200 = 20
mov edx, 0
mov eax, dword [dNum3]
div dword [dNum4]
mov dword [dAns17], eax

; 7000000100 / 200 = 35000000 (100)
mov eax, dword [qNum1]
mov edx, dword [qNum1 + 4]
div dword [dNum4]
mov dword [dAns18], eax
mov dword [dRem18], edx

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
