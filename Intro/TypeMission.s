;TypeMission.s - Display MISSION; on screen like Typewriter

TypeMISSION
	ldx #00
.(
loop1	lda TypewriterMissionSequence_Object,x
	sta Object_V
	lda TypewriterMissionSequence_X,x
	sta Object_X
	lda #68
	sta Object_Y
	jsr PlotObject
	inx
	lda TypewriterMissionSequence_Wait-1,x
	bmi EndOfSequence
	beq loop1
	
	;May integrate delay into Music so synchronised
	sta IRQTimer
loop2	lda IRQTimer
	bne loop2
	
	jmp loop1
EndOfSequence
.)
	rts
	
;3 Tables describe the complete sequence of the typewriter tapping in the letters
;     M
;    MI
;   MIS
;  MISS
; MISSI
;etc.
TypewriterMissionSequence_Object
 .byt OBJ_BIGLETTER_M
 
 .byt OBJ_BIGLETTER_M
 .byt OBJ_BIGLETTER_I
 
 .byt OBJ_BIGLETTER_M
 .byt OBJ_BIGLETTER_I
 .byt OBJ_BIGLETTER_S

 .byt OBJ_BIGLETTER_M
 .byt OBJ_BIGLETTER_I
 .byt OBJ_BIGLETTER_S
 .byt OBJ_BIGLETTER_S

 .byt OBJ_BIGLETTER_M
 .byt OBJ_BIGLETTER_I
 .byt OBJ_BIGLETTER_S
 .byt OBJ_BIGLETTER_S
 .byt OBJ_BIGLETTER_I

 .byt OBJ_BIGLETTER_M
 .byt OBJ_BIGLETTER_I
 .byt OBJ_BIGLETTER_S
 .byt OBJ_BIGLETTER_S
 .byt OBJ_BIGLETTER_I
 .byt OBJ_BIGLETTER_O

 .byt OBJ_BIGLETTER_M
 .byt OBJ_BIGLETTER_I
 .byt OBJ_BIGLETTER_S
 .byt OBJ_BIGLETTER_S
 .byt OBJ_BIGLETTER_I
 .byt OBJ_BIGLETTER_O
 .byt OBJ_BIGLETTER_N

 .byt OBJ_BIGLETTER_M
 .byt OBJ_BIGLETTER_I
 .byt OBJ_BIGLETTER_S
 .byt OBJ_BIGLETTER_S
 .byt OBJ_BIGLETTER_I
 .byt OBJ_BIGLETTER_O
 .byt OBJ_BIGLETTER_N
 .byt OBJ_BIGLETTER_COLON

TypewriterMissionSequence_X
 .byt 30	;M
 
 .byt 27	;M
 .byt 34	;I
 
 .byt 23	;M
 .byt 30	;I
 .byt 33	;S

 .byt 19	;M
 .byt 26	;I
 .byt 29	;S
 .byt 33	;S
 
 .byt 16	;M
 .byt 23	;I
 .byt 26	;S
 .byt 30	;S
 .byt 34	;I
 
 .byt 11	;M
 .byt 18	;I
 .byt 21	;S
 .byt 25	;S
 .byt 29	;I
 .byt 32	;O
 
 .byt 5	;M
 .byt 12	;I
 .byt 15	;S
 .byt 19	;S
 .byt 23	;I
 .byt 26	;O
 .byt 31	;N

 .byt 4	;M
 .byt 11	;I
 .byt 14	;S
 .byt 18	;S
 .byt 22	;I
 .byt 25	;O
 .byt 30	;N
 .byt 36	;;

TypewriterMissionSequence_Wait	;Wait after displaying Letter specified in tables above
 .byt 50
 
 .byt 0
 .byt 40
 
 .byt 0
 .byt 0
 .byt 100
 
 .byt 0
 .byt 0
 .byt 0
 .byt 75

 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 50

 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 75

 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 40

 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 0
 .byt 128
	