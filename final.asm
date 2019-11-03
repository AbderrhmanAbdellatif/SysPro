segment .text
global final
; ebx,esi,edi,ebp,cs,ds,ss,es should remain unchanged
final:
    
      push ebp
      mov ebp,esp 
      push esi 
      sub  esp,12  ;(max= -8 , count=-12 , 4=-16 )place 
      
      mov esi,4  ; esi = 4
      mov [ebp-16],esi ; [ebp-16] = 4 
      mov eax,[ebp+8] ;  eax= count
    ;mov ecx,4  ; ecx = 4
     mul esi;ecx     ; eax*ecx
    add eax,16  ; move eax count 4 index to up becouse of line 9  
    sub esp,[eax]  ; make a place in stack using count size 

    mov  eax,[ebp+12] ;  array first element 
    mov  edx,[eax]     ; first element = max
    mov  [ebp-8],edx    ; 1st no of array is the max

      mov edx,[ebp+8]          ;count
      mov ecx, [ebp+12]       ; ecx hold start address of array

loop:
      add ecx,4               ; ecx hold address of next element of array
      mov eax,[ecx]           ; value of index in array
      cmp eax,[ebp-8]         ;  max < a[i] 
      jle next                ; if false next 
      mov [ebp-8],eax         ; max=a[i]

next:
      dec edx                ; i-- 
      cmp edx,1              ; i!= 1 
      jne loop               ; go to loop 
      
    
      mov ecx, [ebp+12]       ; ecx hold start address of array
      mov edx,[ebp-16]          ;count array first element
      ;mov [ebp-12],edx     ; hold count array adderess for future change

loop2:                     ;  count[a[i]]=count[a[i]]+1;
                  ; ecx hold address of next element of array     
      mov eax,[ecx]           ; value of index in array a[i]
      mul esi                 ; eax * 4 
      add eax,16              ; result (eax*4)+16
      sub edx,eax  ; count[a[i]] ==> ebp - (value * 4 + 16)
      add dword edx,1;         
       add ecx,4  

      dec edx                ; i-- 
      cmp edx,0              ; i!= 1 
      jne loop2               ; go to loop 
      

            