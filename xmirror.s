

; --------------------
; SPRITE XMirror
; Compile with 64Tass
; --------------------

; MACHINE LANGUAGE ROUTINE TO MIRROR SPRITE LEFT TO RIGHT 
; By Ernesto Contreras
; Assumes that Sprite to be altered is loaded into Address $010000
; Program Begins on Address $A0100 

*=$A0100
LSROW=<>SROW
LSPRPTR=<>SPRPTR 


;INITIALIZE, SET NATIVE MODE, A & INDEX SIZE & DEFAULT DATA BANK
CLC			;clear Carry 
XCE			;Set Native Mode 
REP #$30    ;Make A and indexes 16 bits 
SEP #$20 	;Set A to 8 bits 
.as 
LDA #$0a 	;Set value of Data Bank to RAM 
PHA			;Push Accumulator into Stack
PLB 		;Pull Data Bank's Highest Byte from Stack 

;INITIALIZE CONSTANTS
.xl  
LDY #$0000			;Load (00) as counters for initital position
LDX #$0020			;Load (32) as counter for end row 
STX LSROW,b			;Store X Coord in SROW 
LDX #$001F			;;Load (31) as counter for end position 
STY LSPRPTR,b  		;Store Sprite Pointer Value 
.as 
PHB					;Send current Data Bank to stack 


; create a counter in Acumulator
.as 
LDA #$00	;Init Counter to $00
XBA 		;Transfer counter to B 
MAINLOOP
; Switch to Bank 1
.as  
LDA #$01 			;Set value of Data Bank to RAM Bank 01
PHA					;Push Accumulator into Stack
PLB 				;Pull Data Bank's Highest Byte from Stack 

LDA  $0000,b,X 	;LOAD SPRPTR value offset by X register (left Pixel to swap)  
PHA					;Push Accumulator into Stack 
LDA  $0000,b,Y 	;LOAD SPRPTR value offset by Y register (Right Pixel to swap)  
PHA 				;Push Accumulator into Stack

; Read & Swap pixels 
PLA 
STA  $0000,b,X     ;STORE right pixel in left pixel address 
PLA 
STA  $0000,b,Y     ;STORE left pixel in right pixel address 
INY 				;Move left pixel right by one 
DEX 				;Move right pixel left by one 
XBA					;Restore Counter from B to Acumulator 
CLC 				;prepare addition
INC A 				;Increment Counter 
.as 
Cmp #$10 			;Compare vs Counter Limit 
XBA					;Store counter in B
BLT MAINLOOP 
PLB					; Restore program Bank
PHB					; Push Bank into Stack 
DEC LSROW 			; Decrement LSROW 
BEQ ENDROUTINE 		; If LSROW <> 00 continue, else go to ENDROUTINE
REP #$30    		;Make A and indexes 16 bits 
.al 
LDA #$0020
CLC					;prepare Addition
ADC LSPRPTR 		;Add to sprite Pointer address
STA LSPRPTR			;Store Value in SPRPTR 
TAY					;Store first pixel of next row address in Y  
CLC					;Prepare Addition 
ADC #$1F			;Add Offset for left pixel 
TAX 				;Store leftmost pixel of next row in X 
SEP #$20 			;Set A to 8 bits 
.as 
LDA #$00			;Init Counter to $00
XBA 				;Transfer counter to B 
JMP MAINLOOP

ENDROUTINE
PLB
RTL

SROW
.word $0020
SPRPTR 
.word $0000
