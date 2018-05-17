	.syntax unified
	.thumb
	.cpu cortex-m4

	.section .vetor,"a",%progbits
	.weak vetor
	.type vetor, %object
	.size vetor, .-vetor

vetor:
	.word 0x20020000 //end of 128K RAM
	.word inicio + 1


	.section .text.inicio
	.weak inicio
	.type inicio, %function

inicio:
	//habilitar PORTD

	ldr r6, = 0x40023800 + 0x30 //inicio dos registradores do RCC 0x40023800
								// 0x30 offset do RCC AHB1 periferal clock
	mov r0, 0x08 // passa 0b00001000 pois GPIOD enable é o quarto bit
	str r0, [r6]

	//modo output
	ldr r6, = 0x40020c00 + 0x00 //inicio dos registradores da porta d 0x40020c00
								//setando o primeiro registrador de modo
	ldr r0, = 0x01000000 // 01 é modo output na port d 12
	str r0, [r6] // colocando r0 no endereço [r6]

	//output push-pull
	ldr r6, = 0x40020c00 + 0x04 // offset 0x04 registrador de modo de output
	ldr r0, = 0x00000000 //todos os bits 0 setam o modo push-pull
	str r0, [r6] // colocando r0 no endereço [r6]

	//speed low
	ldr r6, = 0x40020c00 + 0x08 // offset 0x08 registrador de velocidade da porta
	ldr r0, = 0x00000000 //setamos todas as portas em low speed
	str r0, [r6] // colocando r0 no endereço [r6]

	//no pull-up, pull-down
	ldr r6, = 0x40020c00 + 0x0c // offset 0x0c registrador para setar se a porta é pull-up/pull-down
	ldr r0, = 0x00000000 //setamos o modo no pull-up, pull-down
	str r0, [r6] // colocando r0 no endereço [r6]

	mov r2, 0x1000 //ligar led
	mov r3, 0x0000 //desligar led

	ldr r6, = 0x40020c00 + 0x14 // joga endereco de GPIOD_ODR (output data register) em r6

loop:
	str r2, [r6] //liga led
	ldr r1, =800000
delay1: //faz um delay com o led aceso
	subs r1, 1 //subtrai 1 de r1
	bne delay1 //acaba o delay (continua o código) quando r1 dá 0 , se não tenta novamente

	str r3, [r6] //desliga led
	ldr r1, =800000
delay2: //começa um novo delay mas desligada a porta
	subs r1,1 //subtrai 1 de r1
	bne delay2 //acaba o delay (continua o código) quando r1 dá 0 , se não tenta novamente

	b loop //jump para o loop
