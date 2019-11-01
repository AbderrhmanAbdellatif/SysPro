segment .text
global countingsort
; nasm -f elf32 csf.asm
; in C calling conventions
; ebx,esi,edi,ebp,cs,ds,ss,es should remain unchanged
;void countingsort(int *a,int n)
countingsort:
    push ebp
    mov  ebp,esp
    push ebx
    sub  esp,4              ; smallest will be here, ebp-8

    mov  eax,[ebp+12] 
    mov  ebx,[eax]   
    mov  [ebp-8],ebx        ; 1st no of array is the smallest

    mov edx,[ebp+8]    ;count
    mov ecx, [ebp+12]       ; ecx hold start address of array

loop:
    add ecx,4               ; ecx hold address of next element of array
    mov eax,[ecx]   
    cmp eax,[ebp-8]
    jle next
    mov [ebp-8],eax    

next:
    dec edx
    cmp edx,1
    jne loop

ending:
    mov  eax,[ebp-8]        ; [ebp-8] holds the smallest
    mov  esp,ebp
    sub  esp,4
    pop ebx
    pop  ebp
    ret