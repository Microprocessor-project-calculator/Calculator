INCLUDE Irvine32.inc

.data
   ;variables
msg byte "insert the expression:",0 
msg1 byte " result =",0
msg2 byte "ERROR!",0
buffer byte 30 DUP(0)      ;array to get string from user          
sign   DWORD 1             ;the sign of the number
nr     DWORD 0             
co     WORD 0              ; flag to know the operation (multiplication  or Division)
result DWORD 0         
aux    DWORD 0            ; store the number that will be multiplied or divided


.code
main PROC

start : 
             mov ebp,0                  ;put zero to ebp register ( index of the buffer array )
             mov sign,1
             mov result,0
             mov nr,0
             mov aux,0
             lea edx,  msg               ;get the offest of the variable msg
             call WriteString           ;print the text in the variable msg to the user
             lea edx,  buffer           ;get the offest of buffer
             mov ecx, sizeof buffer     ;put the size of the array in register ecx
             call ReadString            ;take input from user
            
loop1 :                                 ;while loop
             cmp ebp, ecx               ;compare ebp  register (index) with ecx register (string length)
             jae answer                 ;if (ebp >= ecx) then jump to label answer
  
digit :  
             cmp buffer[ebp],'0'
             jb switch                  ;jump to switch label if this char is less than cahr '0'
             cmp buffer[ebp],'9'
             ja switch                  ;jump to switch label if this char is greater than cahr '9' 
             mov bl,buffer[ebp]         ;store the char in ith index(ebp) into bl "char is BYTE" 
             sub bl,'0'                 ;convert char number to int number (v[i]-'0')
             movzx ebx, bl              ;convert 8-bit register to 32-bit(to adding the same size)
             mov ax ,10                 ;ax = 10
             mul nr                     ;eax = ax*nr => eax = 10*nr
             add eax , ebx              ;eax = eax+ebx => eax = 10*nr + (v[i]-'0')
             mov nr , eax               ;nr=nr*10 + (v[i]-'0')
             inc ebp                    ;i++ => ebp++
             jmp digit                  ;jump to get the second number like (123)
  
switch : 
             cmp buffer[ebp],'+'        
             je addition               ;jump to addition label if v[i]=='+'
             cmp buffer[ebp],'-'
             je subtraction            ;jump to subtraction label if v[i]=='-'
             cmp buffer[ebp],'*'
             je multiplication         ;jump to multiplication label if v[i]=='*'
             cmp buffer[ebp],'/'
             je Division               ;jump to Division label if v[i]=='/'
             cmp buffer[ebp],'!'
             je factorial              ;jump to factorial label if v[i]=='!'
             cmp buffer[ebp],'^'
             je power                  ;jump to power label if v[i]=='^'


 addition : 
             cmp buffer[ebp-1],'*'            
             je psign                        ;jump  to label psing if buffer[ebp] == '*'
             cmp buffer[ebp-1],'/'
             je psign                        ;jump  to label psing if buffer[ebp] == '/'
             cmp co, 1
             jne aco2                        ;jump  to label aco2 if co != 1 
             mov eax,sign                   
             mul nr                          ;nr * eax (sign)
             mul aux                         ;eax * aux
             add result,eax                  ;result += eax  , result = sign * nr * aux 
             mov aux, 0
             mov nr, 0
             mov co, 0
             jmp psign

 aco2 : 
             cmp co, 2                       
             jne aco0                      ;jump to label aco0 if co != 2
             cmp nr,0                     
             je error                      ;jump to label error if the denominator equal zero ( nr = 0 )
             mov eax,aux                   
             div nr                        ; eax / nr
             mul sign                      ; eax =  ax * sign
             add result,eax                ; result+ = eax  , result = aux / nr * sign
             mov aux, 0
             mov nr, 0
             mov co, 0
             jmp psign

  aco0 :
             mov eax, sign                 ;eax = sign 
             mul nr                        ; eax = eax * nr
             add result,eax                ; reasult+ = eax
             mov nr, 0
             mov co, 0
             jmp psign

subtraction :
           cmp buffer[ebp - 1], '*'       ;if (buffer[ebp-1]=='*')      
           je nsign                       ;if condition true, jump to nsign  
           cmp buffer[ebp - 1], '/'       ;if (buffer[ebp-1]=='/')     
           je nsign                       ;if condition true, jump to nsign   
           cmp co, 1                      ;if(co!=1)
           jne sco2                       ;jump to sco2
           mov eax, sign                  ; eax=sign
           mul nr                         ;eax*=nr
           mul aux                        ;eax*=aux
           add result, eax                ;result+=eax
           mov aux, 0                     ;aux=0
           mov nr, 0                      ;nr=0
           mov co, 0                      ;co=0
           jmp nsign                      ; jump to nsign
           
   sco2 :
           cmp co, 2        ;if(co!=2)
           jne sco0         ;jump to sco0
           cmp nr,0         ; if (nr==0) if you divide by zero
           je error         ;jump to error
           mov eax, aux     ;eax=aux
           div nr           ;eax/=nr
           mul sign         ;eax*=sign
           add result,eax
           mov aux, 0
           mov nr, 0
           mov co, 0
           jmp nsign
  sco0 :
          mov eax, sign    ;sign=eax
          mul nr           ;eax*=nr
          add result, eax  ;result+=eax
          mov nr, 0        ;nr=0
          mov co, 0        ;co=0
         jmp nsign





multiplication :    
              cmp aux, 0       ;compare aux and 0
              jne mco2         ;jump to label mco2 if aux != 0 
              mov eax,sign     ;eax = sign
              mul nr           ;eax*nr
              mov aux , eax    ;aux = eax
              mov co  , 1      ;co = 1
              mov nr ,0        ;nr = 0
              jmp psign        ;jump to label psign
             
  mco2   :   
              cmp co , 2       ;compare co and 2
              jne melse        ;jump to label melse if co!=2
              cmp nr,0
              je error         ;jump to label error if nr=zero
              mov eax, aux     ;eax = aux
              div nr           ;eax /nr
              mul sign         ;eax *sign
              mov aux ,eax     ;aux = eax
              mov co  , 1      ;co = 1
              mov nr ,0        ;nr = 0
              jmp psign        ;jump to label psign
              
melse  :      
              mov eax ,sign    ;eax = sign
              mul nr           ;eax * nr
              mul aux          ;eax* aux
              mov aux ,eax     ;aux = eax
              mov co  , 1      ;co = 1
              mov nr ,0        ;nr = 0
              jmp psign        ;jump to label psign   
              
              
              
                     
              
 Division : 
            cmp aux ,0                    ;compare aux and 0
            jne div1                      ;jump to label div1 if aux != 0 
            mov eax,sign                  ;eax = sign
            mul nr                        ;eax*nr
            mov aux ,eax                  ;aux = eax
            mov co  , 2                   ;co = 2
            mov nr ,0                     ;nr=0
            jmp psign                     ;jump to label psign
              
              
     div1:   
            cmp co ,1                    ;compare co and 1
            jne delse                    ;jump to label delse if co != 1
            mov eax ,sign                ;eax = sign
            mul nr                       ;eax*nr
            mul aux                      ;aux*eax
            mov aux ,eax                 ;aux =eax
            mov co  , 2                  ;co=2
            mov nr ,0                    ;nr =0
            jmp psign                    ;jump to label psign
            
    delse:   
            cmp nr,0                    ;compare nr and 0
            je error                    ;jump to label error if the denominator = 0
            mov eax, aux                ;eax = aux 
            div nr                      ;eax / nr
            mul sign                    ;eax* sign
            mov aux ,eax                ;aux =eax
            mov co  , 2                 ;co=2
            mov nr ,0                   ;nr=0
            jmp psign                   ;jump to label psign
            
 factorial :
            mov ebx,ecx                 ;ebx=ecx
            mov ecx,nr                  ;ecx=nr
            sub ecx,1                   ;ecx= ecx-1
         
   floop :
            mov eax,nr                  ;eax=nr
            mul ecx                     ;ecx*eax
            mov nr,eax                  ;nr=eax
            loop floop                  ;ecx-- and check if ecx=0 => break loop
            mov ecx,ebx                 ;ecx=ebx
            jmp default                 ;jump to label default

            
power :
            inc ebp                     ;i++
            mov ebx,ecx                 ;copy the string length (ecx) to (ebx)
            mov cl,buffer[ebp]          ;get the number of power from the array ( m = v[i])
            sub cl,'0'                  ; m - '0'
            movzx ecx, cl               ; change the size from one byte to 4 byte ( ecx = power )
            dec ecx                     ;  m--
            mov esi,nr                  ; esi = nr  ( k = nr )
   ploop :
            mov eax,nr                   
            mul esi                     ; eax = eax * esi
            mov nr,eax
            loop ploop                  ;ecx-- and check if ecx=0 => break loop
            mov ecx,ebx                 ;ecx=ebx
            jmp default                 ;jump to label default

            ; we can use anthor method in power 
            ; we won't use esi register and the method is:
                ;ploop :
                ;mov al, buffer[ebp-2] 
                ;sub al,'0'
                ;movzx eax , al   ( k = nr )
                ;mul nr
                ;mov nr,eax
                ;loop ploop



   psign :
              mov sign, 1                     ; sign = 1
              jmp default        


  nsign:
              mov sign,-1                     ;sign=-1
              jmp default
     
  default : 
             mov eax,ecx                     ;ecx=n , mov it to keep it from changing
             sub eax,1                       ;eax=eax-1 , n-1
             cmp ebp,eax
             jb incre                        ;jump if ebp < eax , i < n-1 
             cmp co, 1
             jne dco2                        ;jump if co != 1 , c!=1
             mov eax,sign      
             mul nr                          ;eax = eax * nr , eax = nr * sign
             mul aux                         ;eax = eax * aux , eax = nr * aux * sign 
             add result,eax                  ; resule+= eax , result += nr * aux * sign
             jmp answer
             
   dco2 :    
             cmp co, 2
             jne dco0                        ;jump if c!=2
             mov eax,aux                     ;eax = aux
             div nr                          ;eax = aux / nr
             mul sign                        ;eax = aux / nr * sign
             add result,eax                  ;result += aux / nr * sign
             jmp answer

    dco0 :  
             mov eax, sign                   ;eax = sign
             mul nr                          ;eax = sign * nr
             add result,eax                  ;result += sign * nr
             jmp answer
             
    incre : 
            inc ebp                          ;i++
            jmp loop1
            
            
            
    answer : 
            mov edx, offset msg1        
            call WriteString
            mov eax, result
            call WriteInt
            call crlf                      ;\n
            jmp start

   error :
             mov edx, offset msg2      
             call WriteString         ;print the text in the variable msg2 to the user
             call crlf
             jmp start          

  INVOKE ExitProcess, 0               ;exit  

main ENDP
END main
