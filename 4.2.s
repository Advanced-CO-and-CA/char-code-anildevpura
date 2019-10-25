/******************************************************************************
* file: Lab_Assignment_3.s
* author: Anil Kumar Devpura
* Guide: Prof. Madhumutyam IITM, PACE and G S Nitesh Narayana
******************************************************************************/

  @ BSS section
      .bss

  @ DATA SECTION
    .data
	STRING: .asciz "CS6620"
	SUBSTR: .asciz "620"
	PRESENT: .word 0

  @ TEXT section
      .text

.globl _main


_main:
	@Initilization 
	LDR R0,=STRING @load the address of String
	LDR R1,=SUBSTR @load the address of String
	@LDR R3,=PRESENT @load the address of Length
	
	@R2 will always hold current position of STRING
	MOV R2 ,#0 
	@R3 will hold last match position
	MOV R3, #0
	
	@Getting first element of both STRING and SUBSTR
	LDRB R4,[R0],#1 
	LDRB R5, [R1],#1
	@updating current char location
	ADD R2,R2,#1  @Current Position

Loop: 
	@compare String and substing char
	CMP R4,R5 
	BEQ MATCH
	BNE RESET
	IN:
		LDRB R4,[R0],#1
		ADD R2,R2,#1  @Current Position at STRING
		@To exit the programe if any of STRING or SUBSTR reached to END
		AND R6, R4, R5
		CMP R6,#0
		BNE Loop
		SWI 0x11


MATCH:
/*
Added to handle Match
On match, 
1. Substring will move to next char
2. Need to check if last match position needs to be updated.
*/
	LDRB R5, [R1],#1
	CMP R3, #0
	BEQ UPDATELastMatch
	B IN

RESET:
/*
Added to handle misMatch
1. Move to start position of substring
2. Verify if STRING position also need to adjust
*/
	LDR R1,=SUBSTR @load the address of String
	LDRB R5, [R1],#1
	CMP R3, #0
	BNE RESETSTRING 
	B IN

UPDATELastMatch:
/*
Added to keep track of last match position
1. Move current position of string char to tracker register
*/
	mov r3, r2
	B IN

RESETSTRING: 
/*
Added to handle misMatch and moving the char position for next comparision for STRING
consider string from last match + 1 location
*/
	LDR R0,=STRING @load the address of String
	MOV R2 ,#0 
	RE: 
		LDRB R4,[R0],#1
		ADD R2,R2,#1  @Current Position
		SUB R3,R3,#1
		CMP R3, #0
		BNE RE
		B IN
.end