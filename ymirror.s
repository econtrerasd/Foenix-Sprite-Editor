
; --------------------
; SPRITE YMirror
; Compile with 64Tass
; --------------------

; MACHINE LANGUAGE ROUTINE TO FLIP SPRITE TOP TO BOTTOM 
; By Ernesto Contreras
; Assumes that Sprite to be altered is loaded into Address $010000
; Program Begins on Address $A0100 

*=$A0200
LSCOL=<>SCOL
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
STX LSCOL,b			;Store X Coord in SCOL 
LDX #$03E0			;;Load (3e0) as counter for end position 
STY LSPRPTR,b  		;Store Sprite Pointer Value 
.as 
PHB					;Send current Data Bank to stack 


; create a counter in Acumulator
REP #$30			; Set A to 16 bits 
.al 
LDA #$0000			; Init Counter to $00
STA COUNTER			; Store counter in Memory  

MAINLOOP
SEP #$20 			;Set A to 8 bits 
; Switch to Bank 1
.as  
LDA #$01 			; Set value of Data Bank to RAM Bank 01
PHA					; Push Accumulator into Stack
PLB 				; Pull Data Bank's Highest Byte from Stack 

LDA  $0000,b,X 		; LOAD SPRPTR value offset by X register (left Pixel to swap)  
PHA					; Push Accumulator into Stack 
LDA  $0000,b,Y 		; LOAD SPRPTR value offset by Y register (Right Pixel to swap)  
PHA 				; Push Accumulator into Stack

; Read & Swap pixels 
PLA 				; Pull value from stack
STA  $0000,b,X     	; STORE right pixel in left pixel address 
PLA 				; Pull value from stack
STA  $0000,b,Y     	; STORE left pixel in right pixel address 

; Move to program Bank
PLB					; Restore program Bank
PHB					; Push Bank into Stack 

REP #$30    		; Make A and indexes 16 bits 
TYA					; Transfer Y to Acumulator 
CLC 				; Prepare Addition
.al 
ADC #$0020			; Add $20 to move one row down
TAY 				; Move value back to register Y
TXA					; Transfer X to Acumulator 
SEC 				; Prepare Substraction
.al 
SBC #$0020			; Substract $20 to move one row up
TAX 				; Move value back to register X

LDA COUNTER			; Load Counter from Memory
CLC 				; Prepare addition
INC A 				; Increment Counter 
.al 
Cmp #$0010 			; Compare vs Counter Limit 
STA COUNTER			; Store counter in Memory 
BLT MAINLOOP 		; If value is less than 10 jump MAINLOOP
PLB					; Restore program Bank
PHB					; Push Bank into Stack 
DEC LSCOL 			; Decrement LSCOL 
BEQ ENDROUTINE 		; If LSCOW <> 00 continue, else go to ENDROUTINE
.al 
LDA #$0001			; Load value offset to move to next column 
CLC					; Prepare Addition
ADC LSPRPTR 		; Add to sprite Pointer address
STA LSPRPTR			; Store Value in SPRPTR 
TAY					; Store top pixel address of next row  in Y  
CLC					; Prepare Addition 
ADC #$03E0 			; Add Offset for bottom pixel 
TAX 				; Store address of botoom pixel in X 
.al 
LDA #$0000			; Init Counter to $00
STA COUNTER 		; Store Counter 
JMP MAINLOOP

ENDROUTINE
PLB
RTL

COUNTER 
.word $0000
SCOL
.word $0020
SPRPTR 
.word $0000
