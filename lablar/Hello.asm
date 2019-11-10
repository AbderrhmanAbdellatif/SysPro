segment .data
msg db "HELLO ,world ! ", 10 
len equ $ - msg

segment .text
global _start

_start:
mov eax,4 ;systme call number
mov ebx,1 ; input 
mov ecx,msg
mov edx,len
int 80h

mov eax,1
mov ebx,0
int 80h
  
