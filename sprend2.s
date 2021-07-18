; --------------------
; SPRITE RENDER 2
; Compile with 64Tass
; --------------------

; MACHINE LANGUAGE ROUTINE TO SHOW SPRITE IN 320x240 Graphical Mode 
; By Ernesto Contreras
; Assumes that Sprite to be shown is loaded into Address $010000
; Program Begins on Address $A0000 

*=$A0000
LSROW=<>SROW
LSPR=<>SPR
LXCOORD=<>XCOORD 
LYCOORD=<>YCOORD 
LSPRPTR=<>SPRPTR 
LCOLOR=<>COLOR
LOFFSETS=<>OFFSETS 

;INITIALIZE, SET NATIVE MODE, A & INDEX SIZE & DEFAULT DATA BANK
CLC			;clear Carry 
XCE			;Set Native Mode 
REP #$30    ;Make A and indexes 16 bits 
SEP #$20 	;Set A to 8 bits 
.as 
LDA #$0a 	;Set value of Data Bank to RAM 
PHA			;Push Accumulator into Stack
PLB 		;Pull Data Bank's Highest Byte from Stack 
REP#$30

;INITIALIZE CONSTANTS
.al 
LDA #$d69d		;Load screen pointer where to paint sprite data
STA LSROW,b		;Store pointer in SROW variable
.al  
LDA #$0020		;Load (32) as counters for X & Y coordinates
STA LXCOORD,b	;Store X Coord 
STA LYCOORD,b	;Store Y Coord 
LDA #$0400		;load Sprite Pointer Value 
STA LSPRPTR,b  	;Store Sprite POinter Value 

MAINLOOP
;Get Sprite color
DEC LSPRPTR,b      ;Reduce one the base address for first run, this puts pointer on last pixel of reqd sprite     

; CHANGE BANK TO Data MEMORY
LDY LSPRPTR,b 	;LOAD SPRPTR on Y register (Last sprite Pixel Read)  

;Switch Data Bank to Bank 01 - Data Bank where Sprite data Is  

SEP #$20			; Set acumulator to 8 bits 
.as 
PHB					;Send current Data Bank to stack 
.as  
LDA #$01 			;Set value of Data Bank to RAM Bank 01
PHA					;Push Accumulator into Stack
PLB 				;Pull Data Bank's Highest Byte from Stack 
REP #$30			; Set Acumulator 16 Bits 

LDA $0000,b,y 		;Read sprite color from Data Memory 
.al  
AND #$00FF  		;filter only low byte      
.xl 
LDY #$0000 			; Initialice Counter for offsets
PAINTCELL

PLB 				;Return to Original Bank 
STA LCOLOR,b 		;Store color read from Sprite  
LDX LOFFSETS,b,Y  	;Load offset of screen position indexed by Y

TXA  				;Transfer Offset read to Acumulator
CLC 				;Prepare for Addition 
ADC LSROW,b 		;Add to Base address 
TAX 				;Return Result to X Index 

;Switch Data Bank to Bank B0 - Vicky Memory 
LDA LCOLOR,b   		;Load Color into Acumulator 
XBA					;Swap low & high byte  
SEP #$20			;Set acumulator 8 bits
PHB 				;Push Data Bank into stack 
.as 
LDA #$B0 			;Set value of Data Bank to VRAM 
PHA					;Push Accumulator into Stack
PLB 				;Pull Data Bank's Highest Byte from Stack 

; PUT PIXEL COLOR IN MEMORY 
XBA					;restore color from B register 
STA $0000,b,x		;Store pixel color @SROW Address modified by X Offset 
REP #$30			;Set acumulator and Index to 16 bits 

INY 				;Increment Y  
INY					;Increment Y again to move to next word 
CPY #$20 			;If I have processed 16 pixels finish this routine
BNE PAINTCELL   	;if value is not equal run PAINTCELL loop again 
 
PLB 				;restore Data Bank 
; change X coordinate 
DEC LXCOORD,b		;Decrement XCOORD Count
BEQ CHANGEROW   	;IF XCOORD value is Zero move to CHANGEROW Routine
.al 
LDA SROW 			;Prepare to substract 10 from SROW to move to first pixel of previous sprite Cell
SEC 				;prepare Carry Flag for substraction
.al
SBC #$0005			;execute substraction 
STA LSROW,b 		;Store result in SROW again 
JMP MAINLOOP    	;Go to read another sprite Byte 

; Change Y coordinate 
CHANGEROW 
DEC LYCOORD,b		;decrease Y Coord 
BEQ ENDROUTINE		;If YCOORD ios Zero go to EndRoutine 
.al
LDA #$0020			;Reset counter for XCoord to 32 decimal
STA LXCOORD,b 		;Reset value of X coord 
.al 
LDA LSROW,b      	;load row value 
SEC 				;prepare Carry flag for substraction
.al 
SBC #$05a5 			;execute substraction  of 1445 pixels to align next cell
sta LSROW,b 		;Store new value in SROW
JMP MAINLOOP 		;Return to main loop

ENDROUTINE
RTL

OFFSETS 
.word $0000, $0001, $0002, $0003 ;-> test
.word $0140, $0141, $0142, $0143
.word $0280, $0281, $0282, $0283
.word $03C0, $03C1, $03C2, $03C3

SPR 
.word $0001
XCOORD
.word $001F
YCOORD
.word $001F
SROW
.word $d69d
SPRPTR 
.word $0000
COLOR
.word $FFFF
