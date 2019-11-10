segment .text
global smallest

smallest:
    push ebp
    mov  ebp,esp
    sub  esp,4          ; smallest will be here

    mov  eax,[ebp+8]    
    mov  [ebp-4],eax    ; 1st no is the smallest

    mov eax,[ebp+12]
    cmp eax,[ebp-4]
    jge next1
    mov  [ebp-4],eax    ; 2nd no is the smallest

next1: 
    mov eax,[ebp+16]
    cmp eax,[ebp-4]
    jge next2
    mov  [ebp-4],eax    ; 3rd no is the smallest

next2:
    mov eax,[ebp+20]
    cmp eax,[ebp-4]
    jge ending
    mov  [ebp-4],eax    ; 4th no is the smallest  

ending:
    mov  eax,[ebp-4]    ; [ebp-4] holds the smallest
    mov  esp,ebp
    pop  ebp
    ret
