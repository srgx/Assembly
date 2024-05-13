
section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

bNum1 db 40
bNum2 db 12
bNum3 db 8
bNum4 db 6
wNum1 dw 101

bAns1 db 0
bAns2 db 0
bAns3 db 0
bAns6 db 0
bAns7 db 0
bAns8 db 0
bAns16 db 0
bAns17 db 0
bAns18 db 0
bRem18 db 0

wAns11 dw 0
wAns12 dw 0
wAns13 dw 0

section .text
global _start
_start:

; 40 + 12 = 52
mov al, byte [bNum1]
add al, byte [bNum2]
mov byte [bAns1], al

; 40 + 8 = 48
mov al, byte [bNum1]
add al, byte [bNum3]
mov byte [bAns2], al

; 8 + 6 = 14
mov al, byte [bNum3]
add al, byte [bNum4]
mov byte [bAns3], al

; 40 - 12 = 28
mov al, byte [bNum1]
sub al, byte [bNum2]
mov byte [bAns6], al

; 40 - 8 = 32
mov al, byte [bNum1]
sub al, byte [bNum3]
mov byte [bAns7], al

; 12 - 6 = 6
mov al, byte [bNum2]
sub al, byte [bNum4]
mov byte [bAns8], al

; 40 * 8 = 320
mov al, byte [bNum1]
mul byte [bNum3]
mov word [wAns11], ax

; 12 * 12 = 144
mov al, byte [bNum2]
mul al
mov word [wAns12], ax

; 12 * 6 = 72
mov al, byte [bNum2]
mul byte [bNum4]
mov word [wAns13], ax

; 40 / 12 = 3
mov ax, 0
mov al, byte [bNum1]
div byte [bNum2]
mov byte [bAns16], al

; 8 / 6 = 1
mov ax, 0
mov al, byte [bNum3]
div byte [bNum4]
mov byte [bAns17], al

; 101 / 6 = 16
mov ax, word [wNum1]
div byte [bNum4]
mov byte [bAns18], al

; 101 % 6 = 5
mov byte [bRem18], ah

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
