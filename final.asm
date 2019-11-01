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
      
      
