                                                                                                                          
segment .text
global countingSort

; in C calling conventions
; ebx,esi,edi,ebp,cs,ds,ss,es should remain unchanged

countingSort:
    push ebp
    mov  ebp,esp
    push ebx
    sub  esp,4              ; biggest will be here, ebp-8
 
    mov  eax,[ebp+12]       ;adresin birinci
    mov  ebx,[eax]   
    mov  [ebp-8],ebx        ; 1st no of array is the biggest

    mov edx,[ebp+8] 
    mov ecx, [ebp+12]       ; ecx hold start address of array

;-----------------------maxi bulma işlemleri-----------------------
max_loop:
    add ecx,4               ; ecx hold address of next element of array
    mov eax,[ecx]   
    cmp eax,[ebp-8]
    jle next
    mov [ebp-8],eax
 

next:
    dec edx
    cmp edx,1
    jne max_loop

;-----------------------max+1 array oluşturup sıfırlamak-----------------------
mov esi,ecx ;normal arrayin bittigi adres


max_plus_one_arr:
    mov  edx,[ebp-8] ;max
    add  edx,1 ;max+1 (sayaç olarak kullanıldı)
    mov ebx,0


zero_loop:

    add ecx,4 ;ecx te son eleman bulunuyor
    mov [ecx],ebx ;ecx a sıfır at count arrayin elmanlarına sıfır atıcaz
    cmp edx,1
    je adedine_gore_guncelle ;1 a eşitse
    dec edx   ;max+1 den 0 kadar
    JMP zero_loop


;-----------------------arraydeki her sayının adedi stackta güncellemek-----------------------
adedine_gore_guncelle:
    mov edx,[ebp+8] ;array sizei (sayaç olarak kullanacaz)
    mov eax,[ebp+12];array başlangıç adresi
    
    mov edi,1

adet: 
   mov ebx,[eax] ;array[i]
   mov ecx,esi ;array bittigi adres

   jmp count_array_i_bul

adet_loop:

   add [ecx],edi ;count[array[i]]++;
   
   add eax,4  ;i+1
   dec edx ;size--
   cmp edx,0
   je sayi_toplama
   jmp adet

count_array_i_bul:
   add ecx,4

   
   cmp ebx,0
   je adet_loop ;0 a eşitse
   dec ebx
   jmp count_array_i_bul


;-----------------------countteki her sayısı önceki sayı ile toplama-----------------------
sayi_toplama:
   mov ebx,[ebp-8] ;max
   mov ecx,esi ;array bittigi adres 
   add ecx,8 ; count array i=1

sayi_toplama_loop:
   mov edx,ecx ;count[i] i edx a atıldı
   sub edx,4 ; count[i-1] adresi
   
   mov edi,[edx] ;count[i-1]
   mov eax, [ecx] ;count[i]

   add eax,edi ;count[i] += count[i - 1];
   mov [ecx],eax  ;count[i] güncelle

   add ecx,4 ;i++

   cmp ebx,1 ;max 0 a eşit mi
   dec ebx ;max--
   
   je output_array
   jmp sayi_toplama_loop

;-----------------------orjinal arraydeki elmanların indisini bulma işlemleri-----------------------
output_array:
   mov ecx,esi ;array bittigi adres
   mov edx,[ebp-8] ;max
   add edx,1 ;max+1

count_son_elmani_bulma:
   add ecx,4 ;count 1.adres
   cmp edx,1 ;max=1 mi
   je output_array_olusturma
   dec edx ;max--
   jmp count_son_elmani_bulma

output_array_olusturma:
   mov edx,[ebp+8] ;array sizei (sayaç olarak kullanacaz)
   
   mov ebx,0 ;elemanları 0 olsun

   mov [ebp-8],ecx ;count arrayin bittigi adresi atama

output_olusturma_loop:
   add ecx,4 ;count array bitişinden sonra başlicak
   mov [ecx],ebx ;0 atama
   cmp edx,1
   je orjinal_array_siralama
   dec edx ;size--
   jmp output_olusturma_loop


;-------------------------------------------------------------
orjinal_array_siralama:
   mov edx,[ebp+8] ;array sizei
   sub edx,1 ;size - 1 (sayaç olarak kullanacaz)

   mov ebx,esi ;array bittigi adres (son elemanı içeriyor)

orjinal_array_siralama_loop:
   mov ecx,[ebx] ;array[i]
  
   mov edi,esi ;array bittigi adres 
   jmp count_array_de_arr_i_bul


count_array_de_arr_i_bul:
   add edi,4 ;count array 1.adres

   cmp ecx,0
   je orjinal_array_siralama_loop2 ;0 a eşitse
   dec ecx
   jmp count_array_de_arr_i_bul


orjinal_array_siralama_loop2:
   mov ecx,[edi] ;count[array[i]]
   mov eax,-1
   add ecx,eax ;count[array[i]]-1

   add [edi],eax ; count[array[i]]--

   mov eax,[ebp-8]  ;count arrayin bittigi adresi atama
   
   jmp output_array_count_array_i_eksibir_bul
   

output_array_count_array_i_eksibir_bul:
   add eax,4 ;output array 1.adres

   cmp ecx,0
   je orjinal_array_siralama_loop3 ;0 a eşitse
   dec ecx
   jmp output_array_count_array_i_eksibir_bul


orjinal_array_siralama_loop3:
   
   mov ecx,[ebx] ;array[i]
   mov [eax], ecx;  output[count[array[i]] - 1] = array[i]
   
   cmp edx,0
   je ending ;0<
   dec edx
   sub ebx,4
   jmp orjinal_array_siralama_loop
   



;-----------------------bitirme işlemleri-----------------------
ending:

    mov ecx,[ebp-8] 
    add ecx,4 ;output 1.adres
    
    mov  eax,ecx   ; [ebp-8] holds the biggest
    mov  esp,ebp
    sub  esp,4
    pop  ebx
    pop  ebp
    ret
