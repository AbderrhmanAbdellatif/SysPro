segment .text
global final
; ebx,esi,edi,ebp,cs,ds,ss,es should remain unchanged
final:
    
      push ebp
      mov ebp,esp 
      push esi 
      sub  esp,16  ;(max= -8 , count=-12 , 4=-16 )place 
    
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
      
    
      mov ecx, [ebp+12]       ;array[0]  ecx hold start address of array
      mov edx,[ebp-20]         ;count[0] count array first element
      ;mov [ebp-12],edx        ; hold count array adderess for future change
      xor esi,esi ;            ; i= 0

loop2:                     ;  count[a[i]]=count[a[i]]+1;
                  ; ecx hold address of next element of array     
    mov eax,[ecx]           ; value of index in array a[i]
    push ecx                ; save ecx value
    mov ecx,[ebp-16]        ; give ecx = 4
    mul ecx                 ; eax * 4 
    pop ecx                 ; add ecx 
    add eax,20              ; result (eax*4)+20
    push edx                ; add edx to use 
    sub edx,eax             ; count[a[i]] ==> ebp - (value * 4 + 20)
    add dword edx,1;        ; count[array[i]]+=1
    pop edx                 ;get edx main value
    add ecx,4               ; to get  next element
    inc esi                 ; i++
    cmp esi,[ebp+8]         ; i < count 
    jl  loop2  


    mov ecx , 0  ; i 
    mov edx , 1  ; j 
    xor esi,  esi  

      ; int k= 0
      ;for(i=0;i<=max;++i)
      ;for(j=1;j<=count[i];++j)
       ;array[k]=i;k++;
      mov esi,[ebp-20]         ;count[0] count array first element 
      xor eax,eax
for1:
           cmp  ecx, [ebp-8]  ; i < = max
           jg  ending        ; end for loop
        
for2: 
        push eax
        mov eax, [esi]     ; take the value in esi eax=count[0]
        push esi           ; save the value in esi
        mov esi,4          ; next element of array 
        mul esi            ; eax*4
       ; add eax,20         ; (value*4)+20
        pop esi            ; give esi main value 
        push esi           ; save the value in esi
        sub esi,eax        ; count[i] ==> [ebp-((value*4)))]
        pop eax            ;  give pop main value 
        cmp esi, edx       ; j < = count [i]
        jg for1            ; go to for1
        mov dword [ebp+12+4*eax],ecx  ; array[k]=i ==> ((array[0] index)+4*k) = i
        pop esi                      ; get count array element
        inc eax                      ; k++
        inc ecx                       ; i++
        inc edx                        ; j++
        jmp for1                       ; go to for1
ending:  

    mov esp,ebp
    sub esp,16
    pop ebp
    pop esi
    ret 