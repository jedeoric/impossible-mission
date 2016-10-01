;Intro Code
#define	IRQVECTORLO	$0245
#define	IRQVECTORHI         $0246

#define	HIRES		$EC33

#define	VIA_PORTB		$0300
#define	VIA_PORTAH	$0301
#define	VIA_DDRB		$0302
#define	VIA_DDRA		$0303
#define	VIA_T1CL		$0304
#define	VIA_T1CH		$0305
#define	VIA_T1LL		$0306
#define	VIA_T1LH		$0307
#define	VIA_T2LL		$0308
#define	VIA_T2CH		$0309
#define	VIA_SR		$030A
#define	VIA_ACR		$030B
#define	VIA_PCR		$030C
#define	VIA_IFR		$030D
#define	VIA_IER		$030E
#define	VIA_PORTA		$030F
#define	VIA2_PORTB	$0320

#define	OBJ_BIGLETTER_M	22
#define	OBJ_BIGLETTER_I	20
#define	OBJ_BIGLETTER_S	21
#define	OBJ_BIGLETTER_O	23
#define	OBJ_BIGLETTER_N	24
#define	OBJ_BIGLETTER_COLON	25

#define	LETTER_A		0
#define	LETTER_B            1
#define	LETTER_C            2
#define	LETTER_D            3
#define	LETTER_E            4
#define	LETTER_F            5
#define	LETTER_G            6
#define	LETTER_H            7
#define	LETTER_I            8
#define	LETTER_L            9
#define	LETTER_M            10
#define	LETTER_N            11
#define	LETTER_O            12
#define	LETTER_P            13
#define	LETTER_R            14
#define	LETTER_S            15
#define	LETTER_T            16
#define	LETTER_U            17
#define	LETTER_V            18
#define	LETTER_Y            19

#define	YELLOWCOLUMN	26
 .zero
*=$00

screen		.dsb 2
source		.dsb 2
text		.dsb 2

ActorID		.dsb 1
FinalAnimationIndex	.dsb 1

;Used in RecalcScreen
TempLo		.dsb 1
TempRX		.dsb 1

;Used in PlotObject
ObjTempX		.dsb 1
ObjTempY            .dsb 1
ObjTempA            .dsb 1
ObjTempWidth	.dsb 1
Object_X		.dsb 1
Object_Y            .dsb 1
Object_V            .dsb 1

;IRQ
IRQTempA		.dsb 1
IRQTempX            .dsb 1
IRQTempY            .dsb 1
IRQTimer		.dsb 1

;Filepack
ptr_source		.dsb 2
ptr_destination               .dsb 2
ptr_destination_end           .dsb 2
ptr_source_back               .dsb 2
offset			.dsb 2
mask_value		.dsb 1
nb_dst			.dsb 2

 .text
*=$500

Driver	sei
	;Init IRQ (Init and start Music)
	jsr InitIRQ
	
	;Display spark together with dithered film here

	;Perform 'Clean' HIRES
	jsr SoftHIRES
	
;kip999	nop
;	jmp kip999

	;Display MISSION; like typewriter
	;! may need to interrupt sound or integrate typewriter sound into music
	jsr TypeMISSION
	
	;Wait a mo
	lda #200
	jsr WaitAMo

	;Display each Actor
	ldx #05
	stx ActorID
.(
loop1	;Perform 'Clean' HIRES for next actor
	jsr SoftHIRES

	;Unpack Actor straight to HIRES
	ldx ActorID
	jsr UnpackData
	
	;Wait a mo
	lda #75
	jsr WaitAMo

	;Display Actors name
	jsr DisplayActorsName

	;Wait a mo
	lda #200
	jsr WaitAMo

	dec ActorID
	bpl loop1
.)
	
	
	;Zoom in on Mission
	lda #6
	sta FinalAnimationIndex
.(	
loop1	;For each new frame parts of screen need to be cleared manually
	ldx FinalAnimationIndex
	lda ClearProcessHi-6,x
	beq skip1
	sta vector1+2
	lda ClearProcessLo-6,x
	sta vector1+1
vector1	jsr $dead
	
skip1	ldx FinalAnimationIndex
	jsr UnpackData
	
	ldx FinalAnimationIndex
	lda FinalAnimationFrameDelays-6,x
	jsr WaitAMo
	
	inc FinalAnimationIndex
	lda FinalAnimationIndex
	cmp #12+6+1
	bcc loop1
.)	

	;Now shift final frame up to top
	ldx #19
	stx FinalAnimationIndex
.(	
loop1	;Clear bottom 17 rows only
	ldx FinalAnimationIndex
	ldy FinalScrollUpClearRow-19,x
	ldx #17
	jsr WipeWithRedPaper
	
	;Unpack to new position
	ldx FinalAnimationIndex
	jsr UnpackData
	
	lda #20
	jsr WaitAMo
	
	inc FinalAnimationIndex
	lda FinalAnimationIndex
	cmp #24
	bcc loop1
.)

.(
loop1	nop
	jmp loop1
.)

FinalScrollUpClearRow
 .byt 146,134,122,110,98

ClearProcessLo
 .byt 0
 .byt 0
 .byt <ClearFirst3RowsAndAltRed
 .byt <ClearTop18AndBottom23
 .byt <ClearTop25AndBottom24
 .byt <ClearTop23AndBottom29
 .byt <ClearTop3
ClearProcessHi
 .byt 0
 .byt 0
 .byt >ClearFirst3RowsAndAltRed
 .byt >ClearTop18AndBottom23
 .byt >ClearTop25AndBottom24
 .byt >ClearTop23AndBottom29
 .byt >ClearTop3
 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 0
FinalAnimationFrameDelays
 .byt 35
 .byt 35
 .byt 35
 .byt 35
 .byt 35
 .byt 35
 .byt 10
 .byt 10
 .byt 10
 .byt 10
 .byt 10
 .byt 10
 .byt 10
ClearFirst3RowsAndAltRed
	ldx #119
	lda #00
.(
loop1	sta $A000,x
	dex
	bpl loop1
.)
	lda #17
	sta $A001
	sta $A001+80
	rts

ClearTop18AndBottom23
	ldy #00
	ldx #18
	jsr WipeWithRedPaper
	ldy #180-23
	ldx #23
	jmp WipeWithRedPaper
ClearTop25AndBottom24
	ldy #18
	ldx #25
	jsr WipeWithRedPaper
	ldy #134
	ldx #24
	jmp WipeWithRedPaper
ClearTop23AndBottom29
	ldy #43
	ldx #23
	jsr WipeWithRedPaper
	ldy #106
	ldx #29
	jmp WipeWithRedPaper
ClearTop3	ldy #66
	ldx #3
	jmp WipeWithRedPaper


WipeWithRedPaper
	lda #01
	jsr RecalcScreen
.(
loop2	lda #64
	ldy #38
loop1	sta (screen),y
	dey
	bne loop1
	lda #17
	sta (screen),y
	jsr nl_screen
	dex
	bne loop2
.)
	rts

WaitAMo
	sta IRQTimer
.(
loop1	lda IRQTimer
	bne loop1
.)
	rts
	
	
SoftHIRES
;	;Wipe character 64 in both Text and HIRES areas before performing HIRES
;	ldx #7
;	lda #0
;.(
;loop1	sta $B400+8*64,x
;	sta $9800+8*64,x
;	dex
;	bpl loop1
;.)
	;Now clear A000-BFFF
	lda #<$a000
	sta screen
	lda #>$a000
	sta screen+1
	ldx #32
	ldy #00
	lda #7
.(
loop1	sta (screen),y
	iny
	bne loop1
	inc screen+1
	dex
	bne loop1
.)
	;Switch to HIRES
	lda #28
	sta $BFDF
	rts
	
	
	
InitIRQ	;For test just redirect irq to routine below
	lda #<IRQRoutine
	sta IRQVECTORLO
	lda #>IRQRoutine
	sta IRQVECTORHI
	cli
	rts

IRQRoutine
	sta IRQTempA
	stx IRQTempX
	sty IRQTempY
	
	;Reset IRQ
	lda VIA_T1CL

	lda IRQTimer
.(
	beq skip1
	dec IRQTimer
skip1
.)
	lda IRQTempA
	ldx IRQTempX
	ldy IRQTempY
	rti
		

;16890 Bytes
#include "IntroLetters.s"
#include "TypeMission.s"
#include "ObjectCode.s"
#include "unpack.s"
#include "DisplayActorsName.s"
;Cameos
#include "h-miml.s"	;A000
#include "h-mipg.s"	;A1B8
#include "h-miln.s"	;A000
#include "h-migm.s"	;A4D8
#include "h-mibb.s"	;A190
#include "h-mipl.s"	;A028
;Final Animation
#include "h-mit00.s"
#include "h-mit01.s"
#include "h-mit02.s"
#include "h-mit03.s"
#include "h-mit04.s"
#include "h-mit05.s"
#include "h-mit06.s"
#include "h-mit07.s"
#include "h-mit08.s"
#include "h-mit09.s"
#include "h-mit10.s"
#include "h-mit11.s"
#include "h-mit12.s"
Himem
 .byt 0
