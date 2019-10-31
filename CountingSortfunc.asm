segment .text
global countingsort

; in C calling conventions
; ebx,esi,edi,ebp,cs,ds,ss,es should remain unchanged

countingsort:
   push ebp
   mov ebp,esp 
   sub esp,4

   mov edx,[ebp+12] ; int max =a[0]
   mov ecx,[ebp+8]  ; count 