//here is only attack (part 1)
;buffer  overflow attack on stack 
;below is assembler's code of main function that takes values from user _and save it _in args[]
00401030 _main proc near
00401030
00401030 arg_0 =dword ptr   8
00401030 arg_4 =dword ptr   0Ch
00401030
00401030              push ebp
00401031              mov ebp,esp
00401033              cmp [ebp+arg_0],2       
00401037              jge shor loc_40103E
00401039              or eax,0FFFFFFFFh
0040103C              jmp short loc_40104C
0040103E
0040103E loc_40103E:
0040103E              mov eax,[ebp+arg_4]        
00401041              mov ecx,[eax+4]            
00401044              push ecx                   
00401045              call _make_bo@4            
0040104A              xor eax,eax 
0040104C
0040104C loc_40104C:
0040104C             pop ebp
0040104D             retn
0040104D _main       endp

;below is code of function  make_bo(x) which save function's arguments _in table _and print result on the screen
00401000 ; int  _stdcall make_bo(char*)
00401000 _make_bo@4 proc near
00401000 
00401000 
00401000       push ebp  
004010001      mov ebp,esp  
004010003      sub esp,10h 
004010006      mov eax,[ebp+8]
004010009      push eax  
00401000A      lea ecx,[ebp-10]
00401000D      push ecx   
00401000E      call _strcpy
004010013      add esp,8
004010016      lea edx,[ebp-10]
004010019      push edx
00401001A      push offset aLoadedS;"Loaded:%s\n"
00401001F      call _printf
004010024      add esp,8
004010027      mov esp,ebp 
004010029      pop ebp 
00401002A      retn 4  
00401002A _make_bo@4 endp
