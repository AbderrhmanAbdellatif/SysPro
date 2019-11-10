segment .text
global smallest

; in C calling conventions
; ebx,esi,edi,ebp,cs,ds,ss,es should remain unchanged


smallest:
    push ebp
    mov  ebp,esp
    sub  esp,4          ; smallest will be here

    mov  eax,[ebp+8]    
    mov  [ebp-4],eax    ; 1st no is the smallest

    mov edx,3 
    mov ecx, ebp
    add ecx,8             ; ecx is ebp+8


loop:
    add ecx,4              
    mov eax,[ecx]                                                            
    cmp eax,[ebp-4]
    jge next
    mov [ebp-4],eax    

next:
    dec edx
    cmp edx,0
    jne loop

ending:
    mov  eax,[ebp-4]    ; [ebp-4] holds the smallest
    mov  esp,ebp
    pop  ebp
    ret
