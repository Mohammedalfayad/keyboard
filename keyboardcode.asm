bits 16
org 0x7C00

mov dl ,0 ; column
mov dh ,0; row
 


cli 
xor ax , ax 
mov ss , ax 
mov sp , 0xfff
mov esi , edi 
dec esi 
xor dx , dx
 
main :
mov ah,02h
mov bh ,00
int 10h
int 10h

mov ah,00h
int 16h

cmp ah,47h
	je home
cmp ah ,1Ch
       je _enter
cmp ah,4Fh
	je end
cmp ah,0fh
       je tab
cmp ah,0Eh
       je backSpace
cmp ah,48h  
       je Up
cmp ah,50h  

cmp ah,50h  
       je Down
cmp ah,4dh
       je Right
cmp ah,4bh
       je Left
cmp ah,3Bh
       je c
cmp ah,3Ch
       je v
cmp ah,3Dh
       je x
jmp writing


writing:

mov ah,09h
mov bl,70h
mov cx,1dint 10h
mov ah,02h
mov bh,00
cmp dl,79d
jg newrow
add dl,1h
int 10h
jmp main
ret                                                                                                                             

newrow:

mov ah,02
mov bh,00
mov dl,0
add dh,1h
jmp main
ret


home: 
       
mov ah,02h
mov bh,00
mov dl,0
jmp main
ret

_enter:

mov ah,02h
mov bh,00
add dh , 1h
mov dl,0
int 10h
jmp main
ret 
end: 

mov ah,02h
mov bh,00
mov dl,79d
jmp main
ret

tab:

mov ah,02h
mov bh,00
add dl ,8d
jmp main
ret

backSpace:

mov ah,02h

mov bh,00
sub dl,1h
mov ah,09h
mov al,0
int 10h
jmp main
ret

Up:

cmp dh,0h
  jle main
sub dh,1

jmp main
ret

Down:
cmp dh,24d
    jge main
add dh,1
jmp main
ret

Right:

cmp dl,79d
   jge main
add dl,1
jmp main
ret


Left:

cmp dl,0h
  jle main
sub dl,1

jmp main
ret

;;;;;;;;;;write string



c:

    pushad
    mov edx , 0xb8000
    mov dword[a] , 0 
    forLoop:
    cmp edx , 0xb8fff
    jge done
    cmp byte[edx+1] , 0x70
    je ce
    add edx , 2
    jmp forLoop
        
done:     

    popad
    jmp main 


ce:
    inc dword[a] 
    mov al      ,[edx] 
    mov ecx     ,[a]
    mov [st+ecx],al
    add edx     , 2 
    jmp forLoop
   
    
     
v:
    mov ah , 13h 
    mov ecx , [a]
    mov bp , st 
    push cs 

   pop es
    mov bl , 7h
    mov bh , 0
    mov dl , 10
    mov dh , 10 
    int 10h
    jmp main 

x:

    pushad
    mov edx , 0xb8000
    mov dword[a] , 0 
    forLoop1:
    cmp edx , 0xb8fff
    jge done1
    cmp byte[edx+1] , 0x70
    je ce1

    add edx , 2
    jmp forLoop1
ce1:
    inc dword[a] 
    mov al       ,[edx]
    mov esi      ,[a]
    mov [st+esi] , al
    mov byte[edx],0 
    add edx      ,2 
    jmp forLoop1
        
done1:     
    popad
    jmp main 


;;;;
b: db 0
a: dd 0

st:  dd 0 
;;;;



times (510 - ($ - $$)) db 0
db 0x55, 0xAA
times (0x400000 - 512) db 0

db 	0x63, 0x6F, 0x6E, 0x65, 0x63, 0x74, 0x69, 0x78, 0x00, 0x00, 0x00, 0x02
db	0x00, 0x01, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
db	0x20, 0x72, 0x5D, 0x33, 0x76, 0x62, 0x6F, 0x78, 0x00, 0x05, 0x00, 0x00
db	0x57, 0x69, 0x32, 0x6B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x78, 0x04, 0x11
db	0x00, 0x00, 0x00, 0x02, 0xFF, 0xFF, 0xE6, 0xB9, 0x49, 0x44, 0x4E, 0x1C

db	0x50, 0xC9, 0xBD, 0x45, 0x83, 0xC5, 0xCE, 0xC1, 0xB7, 0x2A, 0xE0, 0xF2
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00