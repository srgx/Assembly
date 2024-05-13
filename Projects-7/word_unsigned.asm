
section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

wNum1 dw 1000
wNum2 dw 500
wNum3 dw 200
wNum4 dw 100

wAns1 dw 0
wAns2 dw 0
wAns3 dw 0
wAns6 dw 0
wAns7 dw 0
wAns8 dw 0
wAns16 dw 0
wAns17 dw 0
wAns18 dw 0
wRem18 dw 0

dNum1 dd 750

dAns11 dd 0
dAns12 dd 0
dAns13 dd 0

section .text
global _start
_start:

; 1000 + 500 = 1500
mov ax, word [wNum1]
add ax, word [wNum2]
mov word [wAns1], ax

; 1000 + 200 = 1200
mov ax, word [wNum1]
add ax, word [wNum3]
mov word [wAns2], ax

; 200 + 100 = 300
mov ax, word [wNum3]
add ax, word [wNum4]
mov word [wAns3], ax

; 1000 - 500 = 500
mov ax, word [wNum1]
sub ax, word [wNum2]
mov word [wAns6], ax

; 1000 - 200 = 800
mov ax, word [wNum1]
sub ax, word [wNum3]
mov word [wAns7], ax

; 500 - 100 = 400
mov ax, word [wNum2]
sub ax, word [wNum4]
mov word [wAns8], ax

; 1000 * 200 = 200000
mov ax, word [wNum1]
mul word [wNum3]
mov word [dAns11], ax
mov word [dAns11 + 2], dx

; 500 * 500 = 250000
mov ax, word [wNum2]
mul word [wNum2]
mov word [dAns12], ax
mov word [dAns12 + 2], dx

; 500 * 100 = 50000
mov ax, word [wNum2]
mul word [wNum4]
mov word [dAns13], ax
mov word [dAns13 + 2], dx

; 1000 / 500 = 2
mov dx, 0
mov ax, word [wNum1]
div word [wNum2]
mov word [wAns16], ax

; 200 / 100 = 2
mov dx, 0
mov ax, word [wNum3]
div word [wNum4]
mov word [wAns17], ax

; 750 / 100 = 7 (50)
mov ax, word [dNum1]
mov dx, word [dNum1 + 2]
div word [wNum4]
mov word [wAns18], ax
mov word [wRem18], dx

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
