segment .text
global final

final:
    
      push ebp
      mov ebp,esp
      sub  esp,4  ;max place 

  
      mov eax,[ebp+8] ; count= eax
      mov ecx,4  ; ecx = 4
      mul ecx     ; eax*ecx
      sub esp,[eax]  ; make a place in stack using count size 

      mov  eax,[ebp+12] ; count  
      mov  ebx,[eax]     ; ebx = count
      mov  [ebp-4],ebx    ; 1st no of array is the max

    mov edx,[ebp+8]          ;count
    mov ecx, [ebp+12]       ; ecx hold start address of array

loop:
    add ecx,4               ; ecx hold address of next element of array
    mov eax,[ecx]           ; value of index in array
    cmp eax,[ebp-4]         ;  max < a[i] 
    jle next                ; if false next 
    mov [ebp-4],eax         ; max=a[i]

next:
    dec edx                ; i-- 
    cmp edx,1              ; i!= 1 
    jne loop               ; go to loop 
      
