segment .text
global countingsort
; nasm -f elf32 csf.asm
; in C calling conventions
; ebx,esi,edi,ebp,cs,ds,ss,es should remain unchanged

countingsort:
   push ebp
   mov ebp,esp 
   sub esp,4

   mov edx,[ebp+12] ; int max =a[0]
   mov ecx,[ebp+8]  ; count 
  
   ; for (i = 1; i < n; i++) 
   ;      if (a[i] > max) 
   ;         max = a[i]; 

MXloop:   
   mov eax,8  ; int i = 1
   cmp eax,ecx ; i < n n is counter 
   jge  L1      ; end of loop one 
   jl  MXloop      ; end of loop one 
 

   cmp [ebp+eax],edx ; a[i] > max      
   jl  maxim

maxim  mov edx,[ebp+eax] ; max = a[i]

   add eax,4 ; i++  

L1:   

    ; INVENTORY TIMES 50 DW 0 ;    int count[50]={0}
   mov eax,[ebp-4]
   mov esp,ebp 
   pop ebp 
   ret 
   
