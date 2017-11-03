#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

void makebo(char *input)
{
	char buffer[16];
	
	strcpy(buffer,input);
printf("Read %s\n",buffer);
}


int main(int argc, char *argv[]) {
	if(argc<2)
	return -1;
	
	makebo(argv[1]);
	return 0;
}
