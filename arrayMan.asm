segment .text
global arryret
; nasm -f elf32 csf.asm
; in C calling conventions
; ebx,esi,edi,ebp,cs,ds,ss,es should remain unchanged
;void countingsort(int *a,int n)
arryret:
    push ebp
    mov  ebp,esp
    push ebx
    sub  esp,4              ; smallest will be here, ebp-8

    mov  eax,[ebp+12] 
    mov  ebx,[eax]   
    mov  [ebp-8],ebx        ; 1st no of array is the smallest

    mov edx,[ebp+8] 
    mov ecx, [ebp+12]       ; ecx hold start address of array
    inc DWORD  [ecx]
loop:
    add ecx,4               ; ecx hold address of next element of array
    inc DWORD  [ecx]

    dec edx
    cmp edx,1
    jne loop

ending:
    mov  eax,[ebp+12]        ; [ebp-8] holds the smallest
    mov  esp,ebp
    sub  esp,4
    pop ebx
    pop  ebp
    ret