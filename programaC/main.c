void inicio();

void(*isr[])()__attribute__ ((section (".vetor")))={
		(void (*)())0x20020000,
		inicio
};

void inicio(){
	//criando um ponteiro de struct de ponteiros
	*((int*)(0x40023800 + 0x30))=0x08;//inicio dos registradores do RCC 0x40023800
										// 0x30 offset do RCC AHB1 periferal clock
										// passa 0b00001000 pois GPIOD enable é o quarto bit

	*((int*)(0x40020c00 + 0x00))=0x01000000;//inicio dos registradores da porta d 0x40020c00
											//setando o primeiro registrador de modo
											// 01 é modo output na port d 12
	*((int*)(0x40020c00 + 0x04))=0x00000000; // offset 0x04 registrador de modo de output
											//todos os bits 0 setam o modo push-pull
	*((int*)(0x40020c00 + 0x08))=0x00000000; // offset 0x08 registrador de velocidade da porta
											//setamos todas as portas em low speed

	*((int*)(0x40020c00 + 0x0c))=0x00000000;// offset 0x0c registrador para setar se a porta é pull-up/pull-down
											//setamos o modo no pull-up, pull-down
	int ligado=0x1000;
	int desligado=0x0000;
	int i; //declara variável inteira
	int *ptr=(int*)(0x40020c00 + 0x14); // aponta para o data register da porta d 12
loop:
	i=800000; //atribui o valor de 800000 para a variavel i
	*ptr=ligado; //passa o data register o valor de ligado para o ptr
	while(i--); //conta de 800000 ate 0
	*ptr=desligado; //passa o data register o valor de desligado para o ptr
	i=800000; //atribui o valor de 800000 para a variavel i
	while(i--); //conta de 800000 ate 0
	goto loop; //vai ate o loop
}


