

;
; ЙННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННН»
;
; File Name   :	C:\OSDK\Projects\im\Audio\SpeechSID\imspeech.bin
; Format      :	Binary File
; Base Address:	0000h Range: 0880h - 2967h Loaded length: 20E7h

; ; Processor:	      M6502
; ННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННН

; Segment type:	Regular
		;.segment RAM
		; 0 .BYTE uninited & unexplored
cpuIORegister:	.BYTE 0	; (uninited)	; DATA XREF: sub_C60:loc_C52r
					; sub_2900+2w ...
unk_90:		; 0 .BYTE uninited & unexplored
byte_A5:	.BYTE 0	; (uninited)	; DATA XREF: RAM:loc_A5Cr RAM:0A61w ...
byte_A6:	.BYTE 0	; (uninited)	; DATA XREF: RAM:0A65w	sub_CAB+38w
byte_A7:	.BYTE 0	; (uninited)	; DATA XREF: sub_B1D+20w sub_B1D+38w ...
byte_A8:	.BYTE 0	; (uninited)	; DATA XREF: sub_B1D+3Cw sub_CAB+22w
byte_A9:	.BYTE 0	; (uninited)	; DATA XREF: RAM:09DCw	RAM:0ACEw ...
byte_AA:	.BYTE 0	; (uninited)	; DATA XREF: RAM:09E9w	RAM:0AD2w ...
byte_AB:	.BYTE 0	; (uninited)	; DATA XREF: RAM:0A7Fw
byte_AC:	.BYTE 0	; (uninited)	; DATA XREF: sub_C2F+16w
byte_AD:	.BYTE 0	; (uninited)	; DATA XREF: RAM:088Ew	RAM:0901w
byte_AE:	.BYTE 0	; (uninited)	; DATA XREF: RAM:08AFw	RAM:0903w
byte_AF:	.BYTE 0	; (uninited)	; DATA XREF: RAM:loc_8B8r RAM:08CEw ...
sysIRQVectorLo:	.BYTE 0	; (uninited)	; DATA XREF: RAM:2948w
sysIRQVectorHi:	.BYTE 0	; (uninited)	; DATA XREF: RAM:294Dw
byte_840:	.BYTE 0	; (uninited)	; DATA XREF: RAM:loc_884r RAM:loc_8A5r

sub_880:				; CODE XREF: sub_2900+8p sub_2900+Dp ...
		JMP	sub_C2F
; End of function sub_880

; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

NMIRoutine4:
		PHA

loc_884:				; DATA XREF: RAM:0892w	RAM:089Cr ...
		LDA	byte_840
		LSR	A
		STA	sidMasterVolume
		CMP	CIA2_ICR
		DEC	byte_AD
		BEQ	loc_897
		INC	loc_884+1
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_897:				; CODE XREF: RAM:0890j
		LDA	#$A4 ; '¤'
		STA	sysNMIVectorLo
		LDA	loc_884+1
		STA	loc_8A5+1
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

NMIRoutine0:
		PHA

loc_8A5:				; DATA XREF: RAM:089Fw	RAM:08B3w
		LDA	byte_840
		LSR	A
		STA	sidMasterVolume
		CMP	CIA2_ICR
		DEC	byte_AE
		BEQ	loc_8B8
		DEC	loc_8A5+1
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_8B8:				; CODE XREF: RAM:08B1j
		LDA	byte_AF
		BEQ	loc_8F2
		LDA	#$C3 ; 'Г'
		STA	sysNMIVectorLo
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

NMIRoutine1:
		PHA
		NOP
		LDA	#$E
		LSR	A
		STA	sidMasterVolume
		CMP	CIA2_ICR
		DEC	byte_AF
		BEQ	loc_8F2
		LDA	#$D9 ; 'Щ'
		STA	sysNMIVectorLo
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

NMIRoutine2:
		CMP	CIA2_ICR
		DEC	byte_AF
		BEQ	loc_8F1
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

NMIRoutine3:
		PHA
		LDA	#$90 ; 'ђ'
		STA	CIA2_CtrlRegB
		LDA	#7
		STA	sidMasterVolume
		CMP	CIA2_ICR
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_8F1:				; CODE XREF: RAM:08DEj
		PHA

loc_8F2:				; CODE XREF: RAM:08BAj	RAM:08D0j
		LDA	byte_CF1
		STA	sysNMIVectorLo
		LDA	byte_CF2
		STA	loc_884+1
		LDA	byte_CF3
		STA	byte_AD
		STA	byte_AE
		LDA	byte_CF4
		STA	byte_AF
		CLD
		INC	byte_CF7
		BEQ	loc_913

loc_910:				; DATA XREF: RAM:0A10w	RAM:0A36w ...
		JMP	loc_937
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_913:				; CODE XREF: RAM:090Ej
		TXA
		PHA
		TYA
		PHA
		INC	byte_CF5
		BNE	loc_91F
		JSR	loc_9B6

loc_91F:				; CODE XREF: RAM:091Aj
		LDA	byte_CF6
		STA	byte_CF7
		LDA	byte_CF2
		AND	#$40 ; '@'
		EOR	#$40 ; '@'
		TAX
		CLC

loc_92E:				; DATA XREF: RAM:09BCw	RAM:loc_A1Ew ...
		JSR	sub_981
		PLA
		TAY
		PLA
		TAX
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_937:				; CODE XREF: RAM:loc_910j
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		TXA
		PHA
		TYA
		PHA
		LDA	byte_CFA
		CMP	byte_CF2
		BEQ	loc_948
		JSR	loc_BFD

loc_948:				; CODE XREF: RAM:0943j
		JSR	sub_B1D
		PLA
		TAY
		PLA
		TAX
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		LDA	byte_CF3
		CMP	#$10
		BEQ	loc_96B
		SEC
		SBC	byte_CF9
		STA	byte_CF3
		LDA	byte_CF2
		CLC
		ADC	byte_CF9
		STA	byte_CF2
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_96B:				; CODE XREF: RAM:0956j
		LDA	byte_CF2
		AND	#$40 ; '@'
		STA	byte_CF2
		LDA	byte_CF8
		STA	byte_CF3
		PLA
		RTI
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		LDA	#$E1 ; 'б'
		STA	byte_CF1
		RTS

; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_981:				; CODE XREF: RAM:loc_92Ep sub_C89+Ap
		LDA	#$C3 ; 'Г'
		STA	byte_CF1
		LDA	#$80 ; 'Ђ'
		STA	byte_CF4
		RTS
; End of function sub_981

; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		JMP	loc_B73
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		JMP	loc_BE3
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		JSR	loc_A68
		JMP	loc_99B
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		JSR	loc_AE5

loc_99B:				; CODE XREF: RAM:0995j
		LDA	loc_9B6+1
		ASL	A
		BPL	loc_9B0
		ROR	A
		EOR	#$40 ; '@'
		STA	loc_9B6+1
		LDA	byte_CFA
		STA	byte_CF2
		JMP	sub_B1D
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_9B0:				; CODE XREF: RAM:099Fj
		JSR	loc_BFD
		JMP	sub_B1D
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_9B6:				; CODE XREF: RAM:091Cp
					; DATA XREF: RAM:loc_99Br ...
		LDA	#0
		BPL	loc_9C0
		LDA	#$7B ; '{'
		STA	loc_92E+1
		RTS
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_9C0:				; CODE XREF: RAM:09B8j
		LDY	#0
		LDA	($A5),Y
		ORA	#$C0 ; 'А'
		STA	byte_CF5
		INY
		LDA	($A5),Y
		LSR	A
		LSR	A
		LSR	A
		ORA	#$E0 ; 'а'
		STA	byte_CF6
		BCS	loc_A4B
		INY
		LDA	($A5),Y
		ADC	byte_CFE
		STA	byte_A9
		INY
		LDA	($A5),Y
		STA	loc_9B6+1
		AND	#$3F ; '?'
		ADC	byte_CFF
		STA	byte_AA
		LDA	#$83 ; 'ѓ'
		STA	byte_CF1
		LDY	#1
		LDA	($A5),Y
		AND	#3
		TAX
		CMP	#2
		BPL	loc_A24
		LDY	#0
		LDA	($A5),Y
		AND	#$40 ; '@'
		BNE	loc_A05
		LDA	#$20 ; ' '

loc_A05:				; CODE XREF: RAM:0A01j
		STA	byte_CF8
		LSR	A
		LSR	A
		LSR	A
		STA	byte_CF9
		LDA	#$51 ; 'Q'
		STA	loc_910+1
		STY	byte_CF4
		TXA
		LSR	A
		LDA	#$8C ; 'Њ'
		BCS	loc_A1E
		LDA	#$8F ; 'Џ'

loc_A1E:				; CODE XREF: RAM:0A1Aj
		STA	loc_92E+1
		JMP	loc_A5C
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_A24:				; CODE XREF: RAM:09F9j
		LDY	#0
		LDA	($A5),Y
		ROL	A
		ROL	A
		ROL	A
		AND	#3
		TAY
		LDA	$A47,Y
		STA	byte_CF3
		LDA	#$39 ; '9'
		STA	loc_910+1
		TXA
		LSR	A
		LDA	#$92 ; '’'
		BCS	loc_A41
		LDA	#$98 ; ''

loc_A41:				; CODE XREF: RAM:0A3Dj
		STA	loc_92E+1
		JMP	loc_A5C
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		.BYTE	8
		.BYTE $10
		.BYTE $18
		.BYTE $20
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_A4B:				; CODE XREF: RAM:09D4j
		LDY	#3
		LDA	($A5),Y
		STA	loc_9B6+1
		LDA	#$37 ; '7'
		STA	loc_910+1
		LDA	#$81 ; 'Ѓ'
		STA	loc_92E+1

loc_A5C:				; CODE XREF: RAM:0A21j	RAM:0A44j
		LDA	byte_A5
		CLC
		ADC	#4
		STA	byte_A5
		BCC	locret_A67
		INC	byte_A6

locret_A67:				; CODE XREF: RAM:0A63j
		RTS
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_A68:				; CODE XREF: RAM:0992p
		ADC	byte_CF3
		STA	loc_AD4+1
		STX	byte_CFA
		LDY	#0
		LDA	($A9),Y

loc_A75:				; CODE XREF: RAM:0BFAj
		STA	loc_AA2+1
		AND	#3
		ASL	A
		ASL	A
		CLC
		ADC	#$D5 ; 'Х'
		STA	byte_AB
		LDA	loc_AA2+1
		LSR	A
		LSR	A
		AND	#3
		TAY
		LDA	($AB),Y
		STA	$800,X
		INX
		JMP	loc_AAB
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_A92:				; CODE XREF: RAM:0AD6j
		LDY	#0
		LDA	($A9),Y
		STA	loc_AA2+1
		AND	#3
		TAY
		LDA	($AB),Y
		STA	$800,X
		INX

loc_AA2:				; DATA XREF: RAM:loc_A75w RAM:0A81r ...
		LDA	#0
		LSR	A
		LSR	A
		AND	#3
		TAY
		LDA	($AB),Y

loc_AAB:				; CODE XREF: RAM:0A8Fj
		STA	$800,X
		INX
		LDA	loc_AA2+1
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		AND	#3
		TAY
		LDA	($AB),Y
		STA	$800,X
		INX
		LDA	loc_AA2+1
		ROL	A
		ROL	A
		ROL	A
		AND	#3
		TAY
		LDA	($AB),Y
		STA	$800,X
		INX
		INC	byte_A9
		BNE	loc_AD4
		INC	byte_AA

loc_AD4:				; CODE XREF: RAM:0AD0j
					; DATA XREF: RAM:0A6Bw	...
		CPX	#0
		BNE	loc_A92
		RTS
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		.BYTE  $C
		.BYTE  $E
		.BYTE $10
		.BYTE $12
		.BYTE	8
		.BYTE  $C
		.BYTE $10
		.BYTE $14
		.BYTE	2
		.BYTE  $A
		.BYTE $12
		.BYTE $1A
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_AE5:				; CODE XREF: RAM:0998p
		ADC	byte_CF3
		STA	loc_B18+1
		STX	byte_CFA
		LDY	#0
		LDA	($A9),Y
		LSR	A
		LSR	A
		LSR	A
		AND	#$1E
		STA	$800,X
		INX
		JMP	loc_B0E
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_AFE:				; CODE XREF: RAM:0B1Aj
		LDA	($A9),Y
		ASL	A
		AND	#$1E
		STA	$800,X
		INX
		LDA	($A9),Y
		LSR	A
		LSR	A
		LSR	A
		AND	#$1E

loc_B0E:				; CODE XREF: RAM:0AFBj
		STA	$800,X
		INX
		INC	byte_A9
		BNE	loc_B18
		INC	byte_AA

loc_B18:				; CODE XREF: RAM:0B14j
					; DATA XREF: RAM:0AE8w
		CPX	#$20 ; ' '
		BNE	loc_AFE
		RTS

; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_B1D:				; CODE XREF: RAM:loc_948p RAM:09ADj ...
		INC	byte_CFB
		BEQ	loc_B31
		LDA	byte_CFC
		CLC
		ADC	byte_CFD
		STA	byte_CFC
		LSR	A
		STA	byte_CF4
		RTS
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_B31:				; CODE XREF: sub_B1D+3j
		LDY	#0
		LDA	($A7),Y
		TAX
		AND	#$FE ; 'ю'
		STA	byte_CFC
		TXA
		LSR	A
		INC	byte_A7
		LDA	($A7),Y
		ROR	A
		ROR	A
		ROR	A
		ROR	A
		ORA	#$E0 ; 'а'
		STA	byte_CFB
		LDA	($A7),Y
		AND	#$F
		TAY
		LDA	$B63,Y
		STA	byte_CFD
		INC	byte_A7
		BNE	loc_B5B
		INC	byte_A8

loc_B5B:				; CODE XREF: sub_B1D+3Aj
		LDA	byte_CFC
		LSR	A
		STA	byte_CF4
		RTS
; End of function sub_B1D

; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		.BYTE $F4 ; ф
		.BYTE $F6 ; ц
		.BYTE $F8 ; ш
		.BYTE $FA ; ъ
		.BYTE $FC ; ь
		.BYTE $FE ; ю
		.BYTE $FF
		.BYTE	0
		.BYTE	1
		.BYTE	2
		.BYTE	4
		.BYTE	6
		.BYTE	8
		.BYTE  $A
		.BYTE  $C
		.BYTE  $E
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_B73:				; CODE XREF: RAM:098Cj
		STA	byte_CF2
		ADC	byte_CF8
		STA	loc_BAA+1
		LDA	byte_CF8
		STA	byte_CF3
		LDY	#0
		LDA	($A9),Y
		LSR	A
		LSR	A
		TAY
		LDA	#$E
		BCC	loc_B8F
		LDA	#$10

loc_B8F:				; CODE XREF: RAM:0B8Bj
		STA	$800,X
		INX
		JSR	sub_BC4
		JMP	loc_BA0
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_B99:				; CODE XREF: RAM:0BACj
		LDY	#0
		LDA	($A9),Y
		JSR	sub_BAF

loc_BA0:				; CODE XREF: RAM:0B96j
		TYA
		JSR	sub_BAF
		INC	byte_A9
		BNE	loc_BAA
		INC	byte_AA

loc_BAA:				; CODE XREF: RAM:0BA6j
					; DATA XREF: RAM:0B79w
		CPX	#$80 ; 'Ђ'
		BNE	loc_B99
		RTS

; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_BAF:				; CODE XREF: RAM:0B9Dp	RAM:0BA1p
		LSR	A
		TAY
		LDA	#$E
		BCC	loc_BB7
		LDA	#$10

loc_BB7:				; CODE XREF: sub_BAF+4j
		STA	$800,X
		INX
		TYA
		LSR	A
		TAY
		LDA	#$E
		BCC	sub_BC4
		LDA	#$10
; End of function sub_BAF


; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_BC4:				; CODE XREF: RAM:0B93p	sub_BAF+11j
		STA	$800,X
		INX
		TYA
		LSR	A
		TAY
		LDA	#$E
		BCC	loc_BD1
		LDA	#$10

loc_BD1:				; CODE XREF: sub_BC4+9j
		STA	$800,X
		INX
		TYA
		LSR	A
		TAY
		LDA	#$E
		BCC	loc_BDE
		LDA	#$10

loc_BDE:				; CODE XREF: sub_BC4+16j
		STA	$800,X
		INX
		RTS
; End of function sub_BC4

; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_BE3:				; CODE XREF: RAM:098Fj
		STA	byte_CF2
		ADC	byte_CF8
		STA	loc_AD4+1
		LDA	byte_CF8
		STA	byte_CF3
		LDY	#0
		LDA	($A9),Y
		AND	#$FC ; 'ь'
		ORA	#1
		JMP	loc_A75
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_BFD:				; CODE XREF: RAM:0945p	RAM:loc_9B0p
		LDX	#0
		LDA	byte_CF2
		STA	loc_C1B+1
		LDA	byte_CFA
		STA	loc_C17+1
		LDA	byte_CF2
		AND	#$40 ; '@'
		EOR	#$40 ; '@'
		ORA	#$20 ; ' '
		STA	loc_C1F+1

loc_C17:				; CODE XREF: RAM:0C26j
					; DATA XREF: RAM:0C08w
		LDA	$800,X
		SEC

loc_C1B:				; DATA XREF: RAM:0C02w
		ADC	$820,X
		ROR	A

loc_C1F:				; DATA XREF: RAM:0C14w	RAM:0C28r
		STA	$860,X
		INX
		CPX	byte_CF3
		BNE	loc_C17
		LDA	loc_C1F+1
		STA	byte_CF2
		RTS

; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_C2F:				; CODE XREF: sub_880j

; FUNCTION CHUNK AT 0C68 SIZE 00000009 BYTES

		CMP	#$FF
		BEQ	loc_C52
		CMP	#$FE ; 'ю'
		BEQ	sub_C60
		CMP	#$FD ; 'э'
		BEQ	loc_C68
		JSR	sub_CAB
		JSR	sub_C60
		BMI	locret_C5F
		LDA	#$A
		STA	byte_AC
		LDA	#8
		STA	byte_FFFB
		JSR	sub_C89
		JSR	sub_C71
; End of function sub_C2F

; START	OF FUNCTION CHUNK FOR sub_C60

loc_C52:				; CODE XREF: sub_C2F+2j sub_C60+5j ...
		LDA	cpuIORegister
		LSR	A
		LSR	A
		LDA	#$80 ; 'Ђ'
		BCS	locret_C5F
		LDA	CIA2_CtrlRegB
		AND	#1

locret_C5F:				; CODE XREF: sub_C2F+12j sub_C60-8j
		RTS
; END OF FUNCTION CHUNK	FOR sub_C60

; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_C60:				; CODE XREF: sub_C2F+6j sub_C2F+Fp

; FUNCTION CHUNK AT 0C52 SIZE 0000000E BYTES

		LDA	#$90 ; 'ђ'
		STA	CIA2_CtrlRegB
		JMP	loc_C52
; End of function sub_C60

; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
; START	OF FUNCTION CHUNK FOR sub_C2F

loc_C68:				; CODE XREF: sub_C2F+Aj
		STX	byte_CFE
		STY	byte_CFF
		JMP	loc_C52
; END OF FUNCTION CHUNK	FOR sub_C2F

; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_C71:				; CODE XREF: sub_C2F+20p
		LDA	#$91 ; '‘'
		STA	CIA2_CtrlRegB
		LDA	#$64 ; 'd'
		STA	CIA2_TimerBLo
		LDA	#0
		STA	CIA2_TimerBHi
		LDA	#$82 ; '‚'
		STA	CIA2_ICR
		LDA	CIA2_ICR
		RTS
; End of function sub_C71


; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_C89:				; CODE XREF: sub_C2F+1Dp
		LDA	#$37 ; '7'
		STA	loc_910+1
		LDA	#$81 ; 'Ѓ'
		STA	loc_92E+1
		JSR	sub_981
		LDA	#$FE ; 'ю'
		STA	byte_CF6
		STA	byte_CF7
		STA	byte_CF5
		LDA	#$C3 ; 'Г'
		STA	sysNMIVectorLo
		LDA	#1
		STA	byte_AF
		RTS
; End of function sub_C89


; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_CAB:				; CODE XREF: sub_C2F+Cp
		ROL	A
		ROL	A
		TAX
		AND	#$FC ; 'ь'
		CLC
		ADC	byte_CFE
		STA	byte_A9
		TXA
		AND	#3
		ADC	byte_CFF
		STA	byte_AA
		LDY	#0
		LDA	($A9),Y
		ADC	byte_CFE
		STA	byte_A7
		INY
		LDA	($A9),Y
		ADC	byte_CFF
		STA	byte_A8
		LDA	#$FF
		STA	byte_CFB
		INY
		LDA	($A9),Y
		CLC
		ADC	byte_CFE
		STA	byte_A5
		INY
		LDA	($A9),Y
		ADC	byte_CFF
		STA	byte_A6
		LDA	#0
		STA	loc_9B6+1
		RTS
; End of function sub_CAB

; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
byte_CF1:	.BYTE $C3		; DATA XREF: RAM:loc_8F2r RAM:097Dw ...
byte_CF2:	.BYTE $40		; DATA XREF: RAM:08F8r	RAM:0925r ...
byte_CF3:	.BYTE $40		; DATA XREF: RAM:08FEr	RAM:0951r ...
byte_CF4:	.BYTE $80		; DATA XREF: RAM:0905r	sub_981+7w ...
byte_CF5:	.BYTE $FE		; DATA XREF: RAM:0917w	RAM:09C6w ...
byte_CF6:	.BYTE $FE		; DATA XREF: RAM:loc_91Fr RAM:09D1w ...
byte_CF7:	.BYTE $FE		; DATA XREF: RAM:090Bw	RAM:0922w ...
byte_CF8:	.BYTE $40		; DATA XREF: RAM:0973r	RAM:loc_A05w ...
byte_CF9:	.BYTE 8			; DATA XREF: RAM:0959r	RAM:0963r ...
byte_CFA:	.BYTE 0			; DATA XREF: RAM:093Dr	RAM:09A7r ...
byte_CFB:	.BYTE $FF		; DATA XREF: sub_B1Dw sub_B1D+2Aw ...
byte_CFC:	.BYTE $E6		; DATA XREF: sub_B1D+5r sub_B1D+Cw ...
byte_CFD:	.BYTE $A		; DATA XREF: sub_B1D+9r sub_B1D+35w
byte_CFE:	.BYTE 0			; DATA XREF: RAM:09D9r
					; sub_C2F:loc_C68w ...
byte_CFF:	.BYTE $D		; DATA XREF: RAM:09E6r	sub_C2F+3Cw ...

; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_2900:				; CODE XREF: RAM:2951p
		LDX	#$35 ; '5'
		STX	cpuIORegister
		CMP	#8
		BEQ	loc_2918
		JSR	sub_880

loc_290B:				; CODE XREF: sub_2900+11j sub_2900+30j
		LDA	#$FF
		JSR	sub_880
		LSR	A
		BCS	loc_290B
		LDA	#$37 ; '7'
		STA	cpuIORegister
		RTS
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

loc_2918:				; CODE XREF: sub_2900+6j
		NOP
		LDA	#2
		JSR	sub_880

loc_291E:				; CODE XREF: sub_2900+24j
		LDA	#$FF
		JSR	sub_880
		LSR	A
		BCS	loc_291E
		LDA	#$20 ; ' '
		JSR	sub_2934
		LDA	#3
		JSR	sub_880
		JMP	loc_290B
; End of function sub_2900

; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД
		RTS

; ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ S U B	R O U T	I N E ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ


sub_2934:				; CODE XREF: sub_2900+28p sub_2934+Dj
		LDX	#$E

loc_2936:				; CODE XREF: sub_2934+8j
					; RAM:IRQHandlerp
		LDY	#0

loc_2938:				; CODE XREF: sub_2934+5j
		DEY
		BNE	loc_2938
		DEX
		BNE	loc_2936
		SEC
		SBC	#1
		BNE	sub_2934
		RTS
; End of function sub_2934

; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

InitSID:				; A holds Song Number to play (1-9)
		SEI
		PHA
		LDA	#$5A ; 'Z'
		STA	sysIRQVectorLo
		LDA	#$29 ; ')'
		STA	sysIRQVectorHi
		PLA
		JSR	sub_2900
		LDA	#$37 ; '7'
		STA	cpuIORegister
		CLI
		RTS
; ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД

IRQHandler:
		JSR	loc_2936
		LDA	#$37 ; '7'
		STA	cpuIORegister
		INC	vicIFR
		JMP	krom_ResetIRQ_RTI
; end of 'RAM'

; ННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННННН

; Segment type:	Pure code
		;.segment ROM
		* =  $C000
vicIFR:		.BYTE 0	; (uninited)	; DATA XREF: RAM:2961w
sidMasterVolume:.BYTE 0	; (uninited)	; DATA XREF: RAM:0888w	RAM:08A9w ...
CIA2_TimerBLo:	.BYTE 0	; (uninited)	; DATA XREF: sub_C71+7w
CIA2_TimerBHi:	.BYTE 0	; (uninited)	; DATA XREF: sub_C71+Cw
		; 0 .BYTE uninited & unexplored
		; 0 .BYTE uninited & unexplored
		; 0 .BYTE uninited & unexplored
		; 0 .BYTE uninited & unexplored
		; 0 .BYTE uninited & unexplored
CIA2_ICR:	.BYTE 0	; (uninited)	; DATA XREF: RAM:088Br	RAM:08ACr ...
		; 0 .BYTE uninited & unexplored
CIA2_CtrlRegB:	.BYTE 0	; (uninited)	; DATA XREF: RAM:08E4w	sub_C60-6r ...
krom_ResetIRQ_RTI:; 0 .BYTE uninited & unexplored ; CODE XREF: RAM:2964j

sysNMIVectorLo:	.BYTE 0	; (uninited)	; DATA XREF: RAM:0899w	RAM:08BEw ...
byte_FFFB:	.BYTE 0	; (uninited)	; DATA XREF: sub_C2F+1Aw
		; 0 .BYTE uninited & unexplored
		; 0 .BYTE uninited & unexplored
		; 0 .BYTE uninited & unexplored
		; 0 .BYTE uninited & unexplored
; end of 'ROM'


		.END
