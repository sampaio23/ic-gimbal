void inicio();

void(*isr[])()__attribute__ ((section (".vetor")))={
		(void (*)())0x20020000,
		inicio
};

void inicio(){
	*((int*)(0x40023800 + 0x30))=0x08;
	*((int*)(0x40020c00 + 0x00))=0x01000000;
	*((int*)(0x40020c00 + 0x04))=0x00000000;
	*((int*)(0x40020c00 + 0x08))=0x00000000;
	*((int*)(0x40020c00 + 0x0c))=0x00000000;
	int ligado=0x1000;
	int desligado=0x0000;
	int i;
	int *ptr=(int*)(0x40020c00 + 0x14);
loop:
	i=800000;
	*ptr=ligado;
	while(i--);
	*ptr=desligado;
	i=800000;
	while(i--);
	goto loop;
}


