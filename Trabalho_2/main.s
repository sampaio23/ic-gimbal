.syntax unified
.thumb
.cpu cortex-m4

.section .vetor, "a", %progbits
.weak vetor
.type vetor, %object
.size vetor, .-vetor

vetor:
	.word 0x20020000 //fim da memoria RAM
	.word inicio + 1


	.section .text.inicio
	.weak inicio
	.type inicio, %function

inicio:
	ldr r6, = 40023800 + 0x30
	mov r0, 0x08
	str r0, [r6]

	//pino no modo output
	ldr r6, = 0x40020C00 + 0x00
	ldr r0, = 0x01000000
	str r0, [r6]

	//config pino output push-pull
	ldr r6, = 0x40020C00 + 0x04
	ldr r6, = 0x00000000
	str r0, [r6]

	//speed low
	ldr r6, = 0x40020C00 + 0x08
	ldr r6, = 0x00000000
	str r0, [r6]

	//no pull-up, pull-down
	ldr r6, = 0x40020C00 + 0x0C
	ldr r6, = 0x00000000
	str r0, [r6]

	mov r2, 0x1000
	mov r3, 0x0000
	ldr r6, = 0x40020C00 + 0x14

loop:
	str r2, [r6]
	ldr r1, =800000

delay1:
	subs r1, 1
	bne delay1

	str r3, [r6]
	ldr r1, =800000

delay2:
	subs r1, 1
	bne delay2

	b loop
