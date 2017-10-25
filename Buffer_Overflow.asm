;simple stack overflow attack 
;in the result of this attack, attacker get control on program  beceause
;not only change return address but also can change data on the stack
;below is assembler's code of main function which takes values from user _and save it _in args[]
00401030 _main proc near
00401030
00401030 arg_0 =dword ptr   8
00401030 arg_4 -dword ptr   0Ch
00401030
00401030              push ebp
00401031              mov ebp,esp
00401033              cmp [ebp+arg_0],2       ;add value from user to buffer's pointer and then compare it with 2 
00401037              jge shor loc_40103E
00401039              or eax,0FFFFFFFFh
0040103C              jmp short loc_40104C
0040103E
0040103E loc_40103E:
0040103E              mov eax,[ebp+arg_4]       ;add value from user  to pointer to  buffer 
                                                ; and move this value to eax register. 
                                                ;Eax has pointer to buffer and user's value now 
00401041              mov ecx,[eax+4]           ;modify eax register by add 4 and move value to ecx 
00401044              push ecx                  ;put buffer's pointer (located in ecx )  on the stack
00401045              call _make_bo@4           ;evoke make_bo() function and put return's addres on the stack
0040104A              xor eax,eax 
0040104C
0040104C loc_40104C:
0040104C             pop ebp
0040104D             retn
0040104D _main       endp

;below is code of function  make_bo(x) which save function's argumetns _in table _and print result on the screen
00401000 ; int  _stdcall make_bo(char*)
00401000 _make_bo@4 proc near
00401000 
00401000 
00401000       push ebp  ;put on the stack  current value of EBP 
004010001      mov ebp,esp ;move value form esp(current stack's pointer)  to ebp
004010003      sub esp,10h ;book 16 baits
004010006      mov eax,[ebp+8]
004010009      push eax  ;char*
00401000A      lea ecx,[ebp-10]
00401000D      push ecx   ;char*
00401000E      call _strcpy
004010013      add esp,8
004010016      lea edx,[ebp-10]
004010019      push edx
00401001A      push offset aWczytanoS;"Wczytano:%s\n"
00401001F      call _printf
004010024      add esp,8
004010027      mov esp,ebp ;retrieve previous stack's pointer
004010029      pop ebp ; take value from the stack and put it on the ebp 
00401002A      retn 4 ;return address (very important)
00401002A _make_bo@4 endp
