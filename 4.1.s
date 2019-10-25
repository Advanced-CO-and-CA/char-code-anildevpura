/******************************************************************************
* file: Lab_Assignment_4.1.s
* author: Anil Kumar Devpura
* Guide: Prof. Madhumutyam IITM, PACE and G S Nitesh Narayana
******************************************************************************/

  @ BSS section
      .bss

  @ DATA SECTION
    .data
	Length: .word 4
	GREATER: .word 0x00000000
	String1: .asciz "CAT"
	String2: .asciz "DAT"

  @ TEXT section
      .text

.globl _main


_main:
	@Initilization 
	LDR R0,=String1 @load the address of String
	LDR R1,=String2 @load the address of String
	LDR R2,=Length @load the address of Length
	LDR R3,=GREATER @load the address of Length
	@Updating R2 with r2 content
	LDR R2, [R2]
	Loop: 
		@moving to next char String1 and String2
		LDRB R4,[R0],#1 
		LDRB R5, [R1],#1
		@Comaparing String1 and String2 current char
		CMP R4,R5
		@if R4 < R5 then we got the ans and it is 0xFFFFFFFF
		BLT LT
		@if R4 > R5 then we got the ans and it is 0xo, which is default value		
		BGT GT
		@updating the counter, once it reach to 0 i.e. all elements are seen and both strings are same
		SUB R2,R2,#1 @decrement the count
		CMP R2,#0
		BNE Loop
	GT: 
		SWI 0x11

	LT: 
		LDR R3,=0xFFFFFFFF
		SWI 0x11
		.end