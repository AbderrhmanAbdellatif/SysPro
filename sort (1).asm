segment .text
global _final

_final:
    push ebp    
    mov ebp,esp     
    push esi     
    sub  esp,20  ;(max= -8 , count=-12 , 4=-16 ) place
    
    mov eax, [ebp + 12]
    mov edx, [ebp + 8]
    
    mov ebx, [eax]
    push ebx
    
    ; initialize the stack values
    loop1:
        mov ebx, [eax + 4*edx]
        cmp ebx, [ebp - 8]
        jng next
        mov [ebp - 8], ebx
        next:
            dec edx
            jne loop1
          


    mov edx, [ebp - 8]  
    inc edx
    mov eax, 4
    mul edx
    sub esp, eax    
	
    mov edx, [ebp - 8]
    inc edx
    
    ; initialize the stack values
    loop2:
        mov dword [esp + 4*edx], 0
	dec edx
	jnz loop2
    
    mov eax, [ebp + 12]
    xor ecx, ecx
    ; increase the stack values by index
    loop3:
        mov edx, [eax + 4*ecx]
        mov ebx, [esp + 4*edx]
        inc ebx
        mov [esp + 4*edx], ebx
	inc ecx
	cmp ecx, [ebp + 8]
	jne loop3
    
    mov edx, [ebp - 8]
    inc edx

    mov eax, [ebp + 12]
    mov ecx, [ebp + 8]
    
    loop4:
        mov ebx, dword [esp + 4*edx]
        cmp ebx, 0
        je next2
        loop5:
            dec ecx
            mov [eax + 4*ecx], edx
            dec ebx
            jnz loop5
        next2: 
            dec edx
	    jnz loop4

    mov esp,ebp    
    sub esp,4      
    pop esi    
    pop ebp
    ret