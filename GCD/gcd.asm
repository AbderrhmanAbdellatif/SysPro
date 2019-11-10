segment .text
global gcd
;int gcd(int n1,int n2)

gcd:

   push ebp
   mov ebp,esp
   sub esp,4
   
   mov edx,[ebp+12]; n2
   mov ecx,[ebp+8] ; n1
    
 while_:
        cmp ecx,edx
        jne ending

        cmp ecx,edx
        jl  n2  
        sub ecx,edx
        mov ecx,ecx
n2:     
         sub edx,ecx ; n2-n1
         mov  edx ,edx   ; n2=n2

         jmp while_
       
         mov eax,ecx
 
 ending:
      mov esp,ebp
      sub ebp,4
      pop ebp
      ret
