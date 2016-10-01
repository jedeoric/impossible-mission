;//--------------------------------------------------------------------------------
;// S.A.M. (Software Automatic Mouth) Speach Engine
;//--------------------------------------------------------------------------------

;	__SID__	= $d400
#define	VolumeRegister	$030F	;= $d418

 .zero
*=$00

zp_3F		.dsb 1



 .text
*=$800
;//--------------------------------------------------------------------------------
;// .text Segment (Code)
;//--------------------------------------------------------------------------------

;.export sam_init
;.export sam_say
;.export sam_setspd
;.export sam_setmouth

;//--------------------------------------------------------------------------------
;// sam_setbuffer (added function)
;// - set destination buffer for rendered sample
;//--------------------------------------------------------------------------------
;// in-
;//	A	- samplebuffer lowbyte
;//	Y	- samplebuffer highbyte
;//--------------------------------------------------------------------------------
;-void sam_setbuffer(unsigned char *buf)
;-{
sam_setbuffer 
        	sta zp_11
	sty zp_12
	rts
;//--------------------------------------------------------------------------------
;// sam_say
;// - say (or render) text
;//--------------------------------------------------------------------------------
;// in 
;//	A	- string lowbyte
;//	Y	- string highbyte
;//--------------------------------------------------------------------------------

; void sam_say(unsigned char *string)
; {
sam_say 
	sta $ae
	sty $af

        	ldy #$00
.(
lp
        	lda ($ae),y
        	beq skp
        	sta speachbuffer,y
        	iny
        	jmp lp
skp
.)

        	lda #$9b
        	sta speachbuffer,y

        	jmp loc_9B5B
; }

;//--------------------------------------------------------------------------------
;// sam_init
;// - initialize the speech engine
;//--------------------------------------------------------------------------------
;// in- none
;//--------------------------------------------------------------------------------

; void sam_init(void)
; {
sam_init 

	ldx #5

loc_97EF 	
	lda loc_B000,X
	sta loc_98E4,X
	lda loc_B050,X
	sta loc_9902,X
	inx 
	cpx #$1E
	bne loc_97EF
	    
	LDX #$30 ; '0'
	LDY #0
              
loc_9804 	    
	LDA loc_B000,X
	STA loc_9920,Y
	LDA loc_B050,X
	STA loc_9926,Y
	INX 
	INY 
	CPX #$36 ; '6'
	BNE loc_9804

	rts
; }

;//--------------------------------------------------------------------------------
;// sam_setspd
;// - set mouth params speed/pitch
;//--------------------------------------------------------------------------------
;// in 
;//	A	- speed
;//	Y	- pitch
;//--------------------------------------------------------------------------------

; void sam_setspd(unsigned char speed,unsigned char pitch)
; {
sam_setspd 
        	sta speed_value
        	sty pitch_value
        	rts
; }

;;not yet
;;unknown_param1
;;unknown_param2

;//--------------------------------------------------------------------------------
;// sam_setmouth
;// - set mouth params throat/mouth
;//--------------------------------------------------------------------------------
;// in 
;//	A	- throat
;//	Y	- mouth
;//--------------------------------------------------------------------------------

; void sam_setmouth(unsigned char throat,unsigned char mouth)
; {
sam_setmouth 

	sta throat_value
	sty mouth_value

sub_97E2 		

; this code was moved to init
;-.if 1=0
;-	lda	byte_9932
;-	bne	loc_9819
;-
;-	; do this only first time
;-	ldx	#5
;-
;-loc_97EF 		
;-	lda	loc_B000,X
;-	sta	loc_98E4,X
;-	lda	loc_B050,X
;-	sta	loc_9902,X
;-	inx
;-	cpx	#$1E
;-	bne	loc_97EF
;-
;-	LDX	#$30 ; '0'
;-	LDY	#0
;-
;-loc_9804 		
;-	LDA	loc_B000,X
;-	STA	loc_9920,Y
;-	LDA	loc_B050,X
;-	STA	loc_9926,Y
;-	INX
;-	INY
;-	CPX	#$36 ; '6'
;-	BNE	loc_9804
;-
;-	INC	byte_9932
;-.endif

loc_9819 		
	LDA #5
	STA byte_9930

loc_981E 		
	LDX byte_9930
	CPX #$1E
	BEQ loc_9893

	LDA #0
	STA byte_9931

	LDA throat_value
	STA byte_992C
	LDA loc_98E4,X
	STA byte_992D
	BNE loc_9860

loc_9838 		
	LDA byte_992F
	LDX byte_9930
	STA loc_B000,X
	INC byte_9931
	LDA mouth_value
	STA byte_992C
	LDA loc_9902,X
	STA byte_992D
	BNE loc_9860

loc_9852 		
	LDA byte_992F
	LDX byte_9930
	STA loc_B050,X
	INC byte_9930
	BNE loc_981E

loc_9860 		
	LDA #0
	STA byte_992F
	STA byte_992E
	LDX #8

loc_986A 		
	LSR byte_992C
	BCC loc_9879
	CLC 
	LDA byte_992F
	ADC byte_992D
	STA byte_992F

loc_9879 		
	ROR byte_992F
	DEX 
	BNE loc_986A
	ROL byte_992E
	ROL byte_992F
	LDX byte_9931
	BEQ loc_9838
	DEX
	BEQ loc_9852
	DEX
	BEQ loc_98B4
	DEX
	BEQ loc_98CE

loc_9893 		
	LDA #$30 ; '0'
	STA byte_9930
	LDY #0

loc_989A 		
	LDX byte_9930
	CPX #$36 ; '6'
	BEQ loc_98DD
	LDA #2
	STA byte_9931

	LDA throat_value
	STA byte_992C
	LDA loc_9920,Y
	STA byte_992D
	BNE loc_9860

loc_98B4 		
	LDA byte_992F
	LDX byte_9930
	STA loc_B000,X
	INC byte_9931
	LDA mouth_value
	STA byte_992C
	LDA loc_9926,Y
	STA byte_992D
	BNE loc_9860

loc_98CE 		
	LDA byte_992F
	LDX byte_9930
	STA loc_B050,X
	INY 
	INC byte_9930
	BNE loc_989A

loc_98DD 		
	RTS
; }

;//--------------------------------------------------------------------------------
;// Speak ("say") main
;//--------------------------------------------------------------------------------

loc_9B5B 		

sub_9B61 		
	LDA #$ff
	STA byte_9A14

	JSR sub_A068

;-	LDA	byte_9A14
byte_9A14=*+1
	lda #$ff
	CMP #$ff
	BNE loc_9BBC ; not $ff -> end

	JSR sub_A1B5
	JSR sub_A39B
	JSR sub_A0F3
	JSR sub_BDEB
	JSR sub_A118

;_ these two are somehow unused params
;-	LDA	#7
;-	STA	loc_BCA8+1
;-	LDA	#6
;-	STA	loc_BCD7+1

;-	LDA	pitch_value
;-	STA	loc_BA3E+1

;-	LDA	speed_value
;-	STA	loc_BC17+1

loc_9B97 		
	LDA speachbuffer2,X
	CMP #$50 ; 'P'
	BCS loc_9BA3
	INX 
	BNE loc_9B97
	BEQ loc_9BA8

loc_9BA3 		
	LDA #$ff
	STA speachbuffer2,X

loc_9BA8 		
	JSR sub_BD2F
	LDA #$ff
	STA speachbuffer2+$fe
	jmp sub_BDA3

;-	JSR	sub_BDA3
;-	LDX	#0
;-	CPX	zp_1D
;-	STX	zp_1D

loc_9BBC 		
;-	LDA	1
;-	ORA	#1
;-	STA	1
;-	CLI
	RTS

;--------------------------------------------------------------------------------

;-sub_A028 		
;-	STA	zp_3F
;-	STX	zp_3E
;-	STY	zp_3D
;-	RTS

;-sub_A02F 		
;-	LDA	zp_3F
;-	LDX	zp_3E
;-	LDY	zp_3D
;-	RTS

; ллллллллллллллл S U B	R O U T	I N E ллллллллллллллллллллллллллллллллллллллл

sub_A036 		
;-	JSR	sub_A028
	STA zp_3F
	STX zp_3E
	STY zp_3D

	LDX #$ff
	LDY #0
loc_A03D 		
	DEX
	DEY
	LDA speachbuffer2,X
	STA speachbuffer2,Y
	LDA loc_9CE0,X
	STA loc_9CE0,Y
	LDA loc_9DE0,X
	STA loc_9DE0,Y
	CPX zp_39
	BNE loc_A03D

	LDA zp_3C
	STA speachbuffer2,X
	LDA zp_3B
	STA loc_9CE0,X
	LDA zp_3A
	STA loc_9DE0,X

	LDA zp_3F
	LDX zp_3E
	LDY zp_3D
	rts

;-	jmp	sub_A02F
;-	JSR	sub_A02F
;-	RTS

;//---------------------------------------------------------------------------------------
;// first routine called by say main
;// (only called by say main)
;//---------------------------------------------------------------------------------------

sub_A068 		
	LDX #0
	TXA
	TAY
	STA zp_42

loc_A06E 		
	STA loc_9DE0,Y
	INY
	CPY #$ff
	BNE loc_A06E
	
	; loop

loc_A076 		
	LDA speachbuffer,X
	CMP #$9b
	BEQ loc_A0EB
	STA zp_41
	INX
	LDA speachbuffer,X
	STA zp_40
	LDY #0

loc_A087 		
	LDA loc_9EEA,Y
	CMP zp_41
	BNE loc_A099
	LDA loc_9F3B,Y
	CMP #$2A ; '*'
	BEQ loc_A099
	CMP zp_40
	BEQ loc_A0A0

loc_A099 		
	INY
	CPY #$51 ; 'Q'
	BNE loc_A087
	BEQ loc_A0AC

loc_A0A0 		
	TYA
	LDY zp_42
	STA speachbuffer2,Y
	INC zp_42
	INX
	JMP loc_A076
	;--------------------------------------------------------------------------------

loc_A0AC 		
	LDY #0

loc_A0AE 		
	LDA loc_9F3B,Y
	CMP #$2A ; '*'
	BNE loc_A0BC
	LDA loc_9EEA,Y
	CMP zp_41
	BEQ loc_A0C3

loc_A0BC 		
	INY
	CPY #$51 ; 'Q'

loc_A0BF 
	BNE loc_A0AE
	BEQ loc_A0CE

loc_A0C3 		
	TYA
	LDY zp_42
	STA speachbuffer2,Y
	INC zp_42
	JMP loc_A076
	;--------------------------------------------------------------------------------

loc_A0CE 		
	LDA zp_41
	LDY #8

loc_A0D2 		
	CMP loc_9EE0,Y
	BEQ loc_A0E1
	DEY
	BNE loc_A0D2
	STX byte_9A14
	jmp soundout1
;-	JSR	soundout1
;-	RTS

loc_A0E1 		
	TYA
	LDY zp_42
	DEY
	STA loc_9DE0,Y
	JMP loc_A076
	;--------------------------------------------------------------------------------

loc_A0EB 		
	LDA #$ff
	LDY zp_42
	STA speachbuffer2,Y
	RTS

; ллллллллллллллл S U B	R O U T	I N E ллллллллллллллллллллллллллллллллллллллл

sub_A0F3 		
	LDY #0

loc_A0F5 		
	LDA speachbuffer2,Y
	CMP #$ff
	BEQ locret_A117
	TAX
	LDA loc_9DE0,Y
	BEQ loc_A10D
	BMI loc_A10D
	LDA loc_B1E0,X
	STA loc_9CE0,Y

;-	JMP	loc_A113
	INY
	JMP loc_A0F5

loc_A10D 		
	LDA loc_B230,X
	STA loc_9CE0,Y

;-loc_A113 		
	INY
	JMP loc_A0F5
;--------------------------------------------------------------------------------

locret_A117 		
	RTS

; ллллллллллллллл S U B	R O U T	I N E ллллллллллллллллллллллллллллллллллллллл


sub_A118 		
	LDA #0
	STA zp_42

loc_A11C 		
	LDX zp_42
	LDA speachbuffer2,X
	CMP #$ff
	BNE loc_A126
	RTS
;--------------------------------------------------------------------------------

loc_A126 		
	STA zp_3C
	TAY 
	LDA loc_9F8C,Y
	TAY
	AND #2
	BNE loc_A136
	INC zp_42
	JMP loc_A11C
;--------------------------------------------------------------------------------

loc_A136 		
	TYA
	AND #1
	BNE loc_A167
	INC zp_3C
	LDY zp_3C
	LDA loc_9DE0,X
	STA zp_3A
	LDA loc_B230,Y
	STA zp_3B
	INX
	STX zp_39
	JSR sub_A036
	INC zp_3C
	LDY zp_3C
	LDA loc_B230,Y
	STA zp_3B
	INX
	STX zp_39
	JSR sub_A036
	INC zp_42
	INC zp_42
	INC zp_42
	JMP loc_A11C
;--------------------------------------------------------------------------------

loc_A167 		
	INX
	LDA speachbuffer2,X
	BEQ loc_A167
	STA zp_38
	CMP #$ff
;-	BNE	loc_A176
;-	JMP	loc_A188
	beq loc_A188

loc_A176 		
	TAY
	LDA loc_9F8C,Y
	AND #8
	BNE loc_A1B0
	LDA zp_38
	CMP #$24 ; '$'
	BEQ loc_A1B0
	CMP #$25 ; '%'
	BEQ loc_A1B0

loc_A188 		
	LDX zp_42
	LDA loc_9DE0,X
	STA zp_3A
	INX
	STX zp_39
	LDX zp_3C
	INX
	STX zp_3C
	LDA loc_B230,X
	STA zp_3B
	JSR sub_A036
	INC zp_39
	INX
	STX zp_3C
	LDA loc_B230,X
	STA zp_3B
	JSR sub_A036
	INC zp_42
	INC zp_42

loc_A1B0 		
	INC zp_42
	JMP loc_A11C

; ллллллллллллллл S U B	R O U T	I N E ллллллллллллллллллллллллллллллллллллллл

sub_A1B5 		
	LDA #0
	STA zp_42

loc_A1B9 		
	LDX zp_42
	LDA speachbuffer2,X
	BNE loc_A1C5
	INC zp_42
	JMP loc_A1B9

loc_A1C5 		
	CMP #$ff
	BNE loc_A1CA
	RTS

loc_A1CA 		
	TAY
	LDA loc_9F8C,Y
	AND #$10
	BEQ loc_A1F1
	LDA loc_9DE0,X
	STA zp_3A
	INX
	STX zp_39
	LDA loc_9F8C,Y
	AND #$20 ; ' '
	BEQ loc_A1ED
	LDA #$15

loc_A1E3 		
	STA zp_3C
	JSR sub_A036
	LDX zp_42
	JMP loc_A315

loc_A1ED 		
	LDA #$14
	BNE loc_A1E3

loc_A1F1 		
	LDA speachbuffer2,X
	CMP #$4E ; 'N'
	BNE loc_A20F
	LDA #$18

loc_A1FA 		
	STA zp_3C
	LDA loc_9DE0,X
	STA zp_3A
	LDA #$D
	STA speachbuffer2,X
	INX
	STX zp_39
	JSR sub_A036
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A20F 		
	CMP #$4F ; 'O'
	BNE loc_A217
	LDA #$1B
	BNE loc_A1FA

loc_A217 		
	CMP #$50 ; 'P'
	BNE loc_A21F
	LDA #$1C
	BNE loc_A1FA

loc_A21F 		
	TAY
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BEQ loc_A252
	LDA loc_9DE0,X
	BEQ loc_A252
	INX
	LDA speachbuffer2,X
	BNE loc_A252
	INX
	LDY speachbuffer2,X
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BEQ loc_A252
	LDA loc_9DE0,X
	BEQ loc_A252
	STX zp_39
	LDA #0
	STA zp_3A
	LDA #$1F
	STA zp_3C
	JSR sub_A036
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A252 		
	LDX zp_42
	LDA speachbuffer2,X
	CMP #$17
	BNE loc_A28B
	DEX
	LDA speachbuffer2,X
	CMP #$45 ; 'E'
	BNE loc_A26B
	LDA #$2A ; '*'
	STA speachbuffer2,X
	JMP loc_A333
;--------------------------------------------------------------------------------

loc_A26B 		
	CMP #$39 ; '9'
	BNE loc_A277
	LDA #$2C ; ','
	STA speachbuffer2,X
	JMP loc_A33C
;--------------------------------------------------------------------------------

loc_A277 		
	TAY
	INX
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BNE loc_A283
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A283 		
	LDA #$12
	STA speachbuffer2,X
	JMP loc_A396    ;->
;--------------------------------------------------------------------------------

loc_A28B 		
	CMP #$18
	BNE loc_A2A6
	DEX
	LDY speachbuffer2,X
	INX
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BNE loc_A29E
	JMP loc_A396    ;->
loc_A29E 		
	LDA #$13
	STA speachbuffer2,X
	JMP loc_A396    ;->
loc_A2A6 		
	CMP #$20 ; ' '
	BNE loc_A2BE
	DEX
	LDA speachbuffer2,X
	CMP #$3C ; '<'
	BEQ loc_A2B5
	JMP loc_A396	;->
;--------------------------------------------------------------------------------

loc_A2B5 		
	INX
	LDA #$26 ; '&'
	STA speachbuffer2,X
	JMP loc_A396    ;->
;--------------------------------------------------------------------------------

loc_A2BE 		
	CMP #$48 ; 'H'
	BNE loc_A2D9
	INX
	LDY speachbuffer2,X
	DEX
	LDA loc_9F8C,Y
	AND #$20 ; ' '
	BEQ loc_A2D1
	JMP loc_A2F4
;--------------------------------------------------------------------------------

loc_A2D1 		
	LDA #$4B ; 'K'
	STA speachbuffer2,X
	JMP loc_A2F4
;--------------------------------------------------------------------------------

loc_A2D9 		
	CMP #$3C ; '<'
	BNE loc_A2F4
	INX
	LDY speachbuffer2,X
	DEX
	LDA loc_9F8C,Y
	AND #$20 ; ' '
	BEQ loc_A2EC
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A2EC 		
	LDA #$3F ; '?'
	STA speachbuffer2,X
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A2F4 		
			
	LDY speachbuffer2,X
	LDA loc_9F8C,Y
	AND #1
	BEQ loc_A315
	DEX
	LDA speachbuffer2,X
	INX
	CMP #$20 ; ' '
	BEQ loc_A30B
	TYA
	JMP loc_A354
;--------------------------------------------------------------------------------

loc_A30B 		
	SEC
	TYA
	SBC #$C
	STA speachbuffer2,X
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A315 		
			
	LDA speachbuffer2,X
	CMP #$35 ; '5'
	BNE loc_A333
	DEX
	LDY speachbuffer2,X
	INX
	LDA loc_9FDA,Y
	AND #4
	BNE loc_A32B
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A32B 		
	LDA #$10
	STA speachbuffer2,X
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A333 		
			
	CMP #$2A ; '*'
	BNE loc_A33C

loc_A337 		
	TAY
	INY
	JMP loc_A343
;--------------------------------------------------------------------------------

loc_A33C 		
			
	CMP #$2C ; ','
	BEQ loc_A337
	JMP loc_A354
;--------------------------------------------------------------------------------

loc_A343 		
	STY zp_3C
	INX
	STX zp_39
	DEX
	LDA loc_9DE0,X
	STA zp_3A
	JSR sub_A036
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A354 		
			
	CMP #$45 ; 'E'
;-	BNE	loc_A35A
	BEQ loc_A361

loc_A35A 		
	CMP #$39 ; '9'
;-	BEQ	loc_A361
;-	JMP	loc_A396
	bne loc_A396
;--------------------------------------------------------------------------------

loc_A361 		
			
	DEX
	LDY speachbuffer2,X
	INX
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BEQ loc_A396
	INX
	LDA speachbuffer2,X
	BEQ loc_A38A
	TAY
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BEQ loc_A396
	LDA loc_9DE0,X
	BNE loc_A396

loc_A380 		
	LDX zp_42
	LDA #$1E
	STA speachbuffer2,X
	JMP loc_A396
;--------------------------------------------------------------------------------

loc_A38A 		
	INX
	LDA speachbuffer2,X
	TAY
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BNE loc_A380

; this is used a few times from above (end of loop)
loc_A396 		
	INC zp_42
	JMP loc_A1B9

; ллллллллллллллл S U B	R O U T	I N E ллллллллллллллллллллллллллллллллллллллл


sub_A39B 		
	LDA #0
	STA zp_42

loc_A39F 		
	LDX zp_42
	LDY speachbuffer2,X
	CPY #$ff
	BNE loc_A3A9
	RTS

loc_A3A9 		
	LDA loc_9F8C,Y
	AND #$40 ; ''
	BEQ loc_A3C8
	INX
	LDY speachbuffer2,X
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BEQ loc_A3C8
	LDY loc_9DE0,X
	BEQ loc_A3C8
	BMI loc_A3C8
	INY
	DEX
	TYA
	STA	loc_9DE0,X

	; end of loop
loc_A3C8 		
	INC zp_42
	JMP loc_A39F

;--------------------------------------------------------------------------------

sub_B98F 		
	LDY #0
	BIT zp_35
	BPL loc_B99E
	SEC
	LDA #0
	SBC zp_35
	STA zp_35
	LDY #$80 ; 'Ч'

loc_B99E 		
	STY zp_32
	LDA #0
	LDX #8

loc_B9A4 		
	ASL zp_35
	ROL A
	CMP zp_34
	BCC loc_B9AF
	SBC zp_34
	INC zp_35

loc_B9AF 		
	DEX
	BNE loc_B9A4
	STA zp_33
	BIT zp_32
	BPL locret_B9BF
	SEC
	LDA #0
	SBC zp_35
	STA zp_35

locret_B9BF 		
	RTS

;--------------------------------------------------------------------------------

loc_B9D6 		
	LDA loc_B8C0
	CMP #$ff
	BNE loc_B9DE
	RTS

loc_B9DE 		
	LDA #0
	TAX
	STA zp_2C

loc_B9E3 		
	LDY zp_2C
	LDA loc_B8C0,Y
	STA zp_38
	CMP #$ff
	;-BNE	loc_B9F1
	;-JMP	loc_BA4E
	beq loc_BA4E

loc_B9F1 		
	CMP #1
	BNE loc_B9F8
	JMP loc_BCEE

loc_B9F8 		
	CMP #2
	BNE loc_B9FF
	JMP loc_BCF4

loc_B9FF 		
	LDA loc_B8FC,Y
	STA zp_2B
	LDA loc_B938,Y
	STA zp_2A
	LDY zp_2B
	INY
	LDA loc_B984,Y
	STA zp_2B
	LDY zp_38

loc_BA13 		
	LDA loc_B000,Y
	STA loc_A900,X
	LDA loc_B050,Y
	STA loc_AA00,X
	LDA loc_B0A0,Y
	STA loc_AB00,X
	LDA loc_B0F0,Y
	STA loc_AC00,X
	LDA loc_B140,Y
	STA loc_AD00,X
	LDA loc_B190,Y
	STA loc_AE00,X
	LDA loc_B370,Y
	STA loc_AF00,X
	CLC

loc_BA3E 		
pitch_value=loc_BA3E+1
	LDA #$40 ; '' ; pitch value

	ADC zp_2B
	STA loc_A800,X
	INX
	DEC zp_2A
	BNE loc_BA13
	INC zp_2C
	BNE loc_B9E3

loc_BA4E 		
	LDA #0
	STA zp_2C
	STA zp_31
	TAX

loc_BA55 		
	LDY loc_B8C0,X
	INX
	LDA loc_B8C0,X
	CMP #$ff
	BNE loc_BA63
	JMP loc_BB62
;--------------------------------------------------------------------------------

loc_BA63 		
	TAX
	LDA loc_B320,X
	STA zp_38
	LDA loc_B320,Y
	CMP zp_38
	BEQ loc_BA8C
	BCC loc_BA7F
	LDA loc_B280,Y
	STA zp_2B
	LDA loc_B2D0,Y
	STA zp_2A
	JMP loc_BA96
;--------------------------------------------------------------------------------

loc_BA7F 		
	LDA loc_B2D0,X
	STA zp_2B
	LDA loc_B280,X
	STA zp_2A
	JMP loc_BA96
;--------------------------------------------------------------------------------

loc_BA8C 		
	LDA loc_B280,Y
	STA zp_2B
	LDA loc_B280,X
	STA zp_2A

loc_BA96 		
	CLC
	LDA zp_31
	LDY zp_2C
	ADC loc_B938,Y
	STA zp_31
	ADC zp_2A
	STA zp_2D
	LDA #0
	STA zp_2E
	LDA #$a8	;$100-$58
	STA zp_2F
	SEC
	LDA zp_31
	SBC zp_2B
	STA zp_29
	CLC
	LDA zp_2B
	ADC zp_2A
	STA zp_26
	TAX
	DEX
	DEX
	BPL loc_BAC2
	JMP loc_BB5B
;--------------------------------------------------------------------------------

loc_BAC2 		
	LDA zp_26
	STA zp_28
	LDA zp_2F
	CMP #$a8	;$100-$58 
	BNE loc_BB09
	LDY zp_2C
	LDA loc_B938,Y
	LSR A
	STA zp_24
	INY
	LDA loc_B938,Y
	LSR A
	STA zp_25
	CLC
	LDA zp_24
	ADC zp_25
	STA zp_28
	CLC
	LDA zp_31
	ADC zp_25
	STA zp_25
	SEC
	LDA zp_31
	SBC zp_24
	STA zp_24
	LDY zp_25
	LDA (zp_2E),Y
	SEC
	LDY zp_24
	SBC (zp_2E),Y
	STA zp_35
	LDA zp_28
	STA zp_34
	JSR sub_B98F
	LDX zp_28
	LDY zp_24
	JMP loc_BB1F
;--------------------------------------------------------------------------------

loc_BB09 		
	LDY zp_2D
	SEC
	LDA (zp_2E),Y
	LDY zp_29
	SBC (zp_2E),Y
	STA zp_35
	LDA zp_28
	STA zp_34
	JSR sub_B98F
	LDX zp_28
	LDY zp_29

loc_BB1F 		
	LDA #0
	STA zp_38
	CLC

loc_BB24 		
	LDA (zp_2E),Y
	ADC zp_35
	STA zp_30
	INY
	DEX
	BEQ loc_BB50
	CLC
	LDA zp_38
	ADC zp_33
	STA zp_38
	CMP zp_28
	BCC loc_BB49
	LDA zp_38
	SBC zp_28
	STA zp_38
	BIT zp_32
	BMI loc_BB47
	INC zp_30
	BNE loc_BB49

loc_BB47 		
	DEC zp_30

loc_BB49 		
	LDA zp_30
	STA (zp_2E),Y
	CLC
	BCC loc_BB24

loc_BB50 		
	INC zp_2F
	LDA zp_2F
	CMP #$af	;$100-$51
	BEQ loc_BB5B
	JMP loc_BAC2

loc_BB5B 		
	INC zp_2C
	LDX zp_2C
	JMP loc_BA55
;--------------------------------------------------------------------------------

loc_BB62 		
	LDA zp_31
	CLC
	LDY zp_2C
	ADC loc_B938,Y
	STA zp_30

	LDX #0
loc_BB6E 		
	LDA loc_A900,X
	LSR A
	STA zp_38
	SEC
	LDA loc_A800,X
	SBC zp_38
	STA loc_A800,X
	DEX
	BNE loc_BB6E

	LDA #0
	STA zp_2B
	STA zp_2A
	STA zp_29
	STA zp_31
	LDA #$48 ; 'H'
	STA zp_2D
	LDA #3
	STA zp_38
	LDA #0
	STA zp_2E
	LDA #$ac	;$100-$54
	STA zp_2F

loc_BB9A 		
	LDY #0

loc_BB9C 		
	LDA (zp_2E),Y
	TAX 
	LDA loc_B974,X
	STA (zp_2E),Y
	DEY
	BNE loc_BB9C
	INC zp_2F
	DEC zp_38
	BNE loc_BB9A
	LDY #0
	LDA loc_A800,Y
	STA zp_2C
	TAX 
	LSR A
	LSR A
	STA zp_38
	SEC 
	TXA 
	SBC zp_38
	STA zp_26
	JMP soundout2

;//--------------------------------------------------------------------------------
;// buffer output routine(s) (added)
;//--------------------------------------------------------------------------------

; void sam_bufout_x(unsigned char X)
; {
; 	*zp_11_12=X;
; 	 zp_11_12++;
; }

sam_bufout_x 
	sta zp_0F
	txa
	jsr sam_bufout
	tax
	lda zp_0F
	rts

; void sam_bufout(unsigned char A)
; {
; 	*zp_11_12=A;
; 	 zp_11_12++;
; }

sam_bufout 
	; write into output buffer
	sty zp_10
	ldy #$00
	sta (zp_11),y
	inc zp_11
	bne sk1
	inc zp_12
sk1 
	ldy zp_10
	rts

;//--------------------------------------------------------------------------------
;// delay routine(s) (added)
;//--------------------------------------------------------------------------------
; void delay(int cycles)
; {
; }

;//--------------------------------------------------------------------------------
;// actual sound output routines
;//--------------------------------------------------------------------------------
; unsigned char soundout3(unsigned char A);
; unsigned char soundout4(unsigned char A);

;//--------------------------------------------------------------------------------
;// SOund out (1/4)
;// zp_a2 is TIME+2
;//--------------------------------------------------------------------------------
;//
;// in 
;//	A
;//	X
;//	Y
;//
;// out 
;//	A
;//	X
;//	Y
;//
;// modifies 
;//	A
;//	X
;//	Y
;//--------------------------------------------------------------------------------
;sub_A43B 

soundout1 	

;.if RENDER_TO_BUFFER=0
; #if RENDER_TO_BUFFER==0
; unsigned char soundout1(void)
; {

	lda #$02
	STA zp_1E
	CLI
;  	zp_1E=2;
loc_A440 
;  	do {

	LDA TIME+2
	CLC
	ADC #8
	TAX
; 		X=((TIME[2])+8);

		;// nmi 0a00 hz 6157.8 1sample  162.395microsec
		;// do this roughly 8*(1/60) secs
		;// = 133.333ms
		;// = 821 samples  6157.8hz
loc_A446 
;  		do {
		;// write into output register
	LDA #$F
	STA VolumeRegister
;  		sam_bufout(0x0f);

		;// 2+($d0*(2+3))+2+2 = 1046 cycles
		;//  (1/985248)*1046 = 1,061ms
		;//  = 7 samples  6157.8hz

	lda #0
	LDY #$d0		;2
loc_A44F 
	DEY			;2
	BNE loc_A44F	;2+1
;  		delay (0xd0);

		;// write into output register
	STA VolumeRegister
;  		sam_bufout(0x00);

		;// 2+($d0*(2+3))+2+2 = 1046 cycles
		;//  (1/985248)*1046 = 1,061ms
		;// = 7 samples  6157.8hz
	LDY #$d0
loc_A457 
	DEY
	BNE loc_A457
;  		delay (0xd0);

	CPX TIME+2
	BNE loc_A446
; 		} while((TIME[2])!=X);

	DEC zp_1E
	BEQ locret_A46E
;  	if (zp_1E--==0) return;

	TXA
	CLC
	ADC #5
	TAX
; 		X+=5;
		;// wait until roughly 5*(1/60) secs passed
		;//  = 83.333ms
		;//  = 513 samples  6157.8hz
; 		do {
loc_A467 
	CPX TIME+2
	BNE loc_A467
; 		} while((TIME[2])!=X);

	JMP loc_A440
;  	} while(1);

locret_A46E 		
	RTS
; }
.else
; #else
; unsigned char soundout1(void)
; {
	lda #$02
	STA	    zp_1E
;-	CLI
;  	zp_1E=2;
loc_A440 
;  	do {

;-	LDA	TIME+2
;-	CLC
;-	ADC	#8
;-	TAX
		;// nmi 0a00 hz 6157.8 1sample  162.395microsec

		;// do this roughly 8*(1/60) secs
		;// = 133.333ms
		;// = 821 samples  6157.8hz
		;// 59*(2*7)=826 samples
	ldx	#59	
; 		X=59;
loc_A446 
;  		do {
		;// write into output register
;  		sam_bufout(0x0f); // 7 samples

	LDA	#$F
;-	STA	_SIDVOL_
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
		;// 2+($d0*(2+3))+2+2 = 1046 cycles
		;//  (1/985248)*1046 = 1,061ms
		;//  = 7 samples  6157.8hz
;-	LDY	#$d0	;2
;-loc_A44F 
;-	DEY		;2
;-	BNE	loc_A44F	;2+1
	ldy #0
;  		delay (0xd0);
; 		Y=0;		
		;// write into output register
;  		sam_bufout(0x00); // 7 samples
	LDA #0
;-	STA	_SIDVOL_
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
	jsr sam_bufout
		;// 2+($d0*(2+3))+2+2 = 1046 cycles
		;//  (1/985248)*1046 = 1,061ms
		;//  = 7 samples  6157.8hz
;-	LDY	#$d0
;-loc_A457 
;-	DEY
;-	BNE	loc_A457
	ldy #0
;  		delay (0xd0);
; 		Y=0;		

;-	CPX	TIME+2
;-	BNE	loc_A446

	dex
	bne loc_A446
;  		} while(X!=0);

	DEC zp_1E
	BEQ locret_A46E
;  		if (zp_1E--==0) return;

;-	TXA
;-	CLC
;-	ADC	#5
;-	TAX

		;// wait until roughly 5*(1/60) secs passed
		;// = 83.333ms
		;// = 513 samples  6157.8hz
;-loc_A467 
;-	CPX	TIME+2
;-	BNE	loc_A467

; 		X=0;
;  		do {
	ldx #0
l1 
	jsr sam_bufout
	jsr sam_bufout
	dex
	bne l1
;  		sam_bufout(A); // 512 samples
;  		} while(X++!=512);

	JMP loc_A440
;  	} while(1);

locret_A46E 
	RTS

; }
.endif
; #endif

;//--------------------------------------------------------------------------------
;// SOund out (2/4)
;//--------------------------------------------------------------------------------
;//
;// in 
;//	X?
;//	Y
;//
;// out 
;//	A
;//	X
;//	Y
;//
;// modifies 
;//	A
;//	X
;//	Y
;//--------------------------------------------------------------------------------
;loc_BBCE 

; unsigned char soundout2(unsigned char Y)
; {

soundout2 		

	LDA loc_AF00,Y
	STA zp_27
	AND #$f8	;$100-8 
	BNE loc_BBC2

	LDX zp_2B
	CLC 
	LDA loc_A500,X
	ORA loc_AC00,Y
	TAX 
	LDA loc_A700,X
	STA zp_38
	LDX zp_2A
	LDA loc_A500,X
	ORA loc_AD00,Y
	TAX 
	LDA loc_A700,X
	ADC zp_38
	STA zp_38
	LDX zp_29
	LDA loc_A600,X
	ORA loc_AE00,Y
	TAX 
	LDA loc_A700,X

;  	A+=(zp_38+0x88);
	ADC zp_38
	ADC #$88	;$100-$78
;  	A>>=4;
	LSR
	LSR
	LSR
	LSR

	;// write into output register
;  	sam_bufout(A);
;.if RENDER_TO_BUFFER=0
	STA VolumeRegister
;.else
	jsr sam_bufout
;.endif
	DEC zp_2D
	BNE loc_BC1B

	INY
	DEC zp_30

loc_BC14 		
	BNE loc_BC17
	RTS

loc_BBC2 		
	JSR soundout3or4
;  	Y+=2;
	INY
	INY
;  	zp_30+=2;
	DEC zp_30
	DEC zp_30
	JMP loc_BC14

loc_BC17 
;-speed_value=*+1
	LDA #$48 ; 'H'  the speedvalue, initialized in init?
	STA zp_2D

loc_BC1B 		
	DEC zp_2C
	BNE loc_BC3A

loc_BC1F 		
	LDA loc_A800,Y
	STA zp_2C
	TAX
	LSR A
	LSR A
	STA zp_38
	SEC
	TXA
	SBC zp_38
	STA zp_26
	LDA #0
	STA zp_2B
	STA zp_2A
	STA zp_29
	JMP soundout2

loc_BC3A 		
	DEC zp_26
	BNE loc_BC48
	LDA zp_27
	BEQ loc_BC48
	JSR soundout3or4
	JMP loc_BC1F

loc_BC48 		
	CLC
	LDA zp_2B
	ADC loc_A900,Y
	STA zp_2B
	CLC
	LDA zp_2A
	ADC loc_AA00,Y
	STA zp_2A
	CLC
	LDA zp_29
	ADC loc_AB00,Y
	STA zp_29
	JMP soundout2

speed_value=loc_BC17+1
; }

;//--------------------------------------------------------------------------------
;// SOund out (3+4/4)
;//--------------------------------------------------------------------------------
;// called 2 times from within soundout2
;// calls either soundout3 or soundout4
;//
;// in 
;//	A
;//	X
;//	Y
;//
;// out 
;//	A
;//	X
;//	Y
;//
;// modifies 
;//	A
;//	X
;//	Y
;//--------------------------------------------------------------------------------

; unsigned char soundout3or4(unsigned char Y)
; {
; extern unsigned char randomtable[0x500];
; extern unsigned char tab48426[5];
soundout3or4 		
;.scope
	STY zp_31
; 	zp_31=Y;
	LDA zp_27
	TAY
; 	A=zp_27;
	AND #7
	TAX
	DEX
; 	X=(A&7)-1;
	STX zp_38
; 	zp_38=X;
	LDA loc_BD2A,X
	STA zp_35
; 	zp_35=tab48426[X];
	CLC
	LDA #>loc_B3C0
	ADC zp_38
	STA zp_2F
; 	zp_2F=zp_38+(((unsigned)&randomtable[0])>>8);
	LDA #<loc_B3C0
	STA zp_2E
; 	zp_2E=((unsigned)&randomtable[0])&0xff;	
	TYA
	AND #$f8
	BNE soundout3  ; -> soundout 3
; 	if(zp_27&0xf8)
; 	{
; 		soundout3(A=zp_27&0xf8);	// ,X==?
; 	}
; 	else
; 	{
; 		soundout4(A=zp_27&0xf8);	// ,X==?
; 	}

; }
;.endscope

;//--------------------------------------------------------------------------------
;// SOund out (4/4)
;//--------------------------------------------------------------------------------
;//
;// in 
;//	A
;//	X
;//	Y
;//
;// out 
;//	A
;//	X
;//	Y
;//
;// modifies 
;//	A
;//	X
;//	Y
;//--------------------------------------------------------------------------------

;.if RENDER_TO_BUFFER=0;
; #if RENDER_TO_BUFFER==0
; unsigned char soundout4(unsigned char A)
; {

	LDY zp_31
	LDA loc_A800,Y
;  	A>>=4;
	LSR
	LSR
	LSR
	LSR

	; fall through
;-	JMP	soundout4  ; -> soundout 4

;soundout4 
;-loc_BCBB 
	EOR #$ff
	STA zp_2B
;  	zp_2B = A ^ 0xff;

	LDY zp_42
;  	Y = zp_42;
loc_BCC1 		
;  	do {

	LDA #8
	STA zp_38
; 		zp_38 = 8;
	LDA (zp_2E),Y
;  		A = *(unsigned char*)(zp_2E+(zp_2F<<8)+Y);

loc_BCC7 		
;  		do {
	ASL
	BCC loc_BCD1
; 		if ((A<<=1)&0x100)
;  		{
	LDX #$1A
			;// write into output register
	STX VolumeRegister
; 	 		sam_bufout(0x1a);

	BNE loc_BCD7
; 		 } else {

loc_BCD1 		
	LDX #6
			;// write into output register
	STX VolumeRegister
; 	 		sam_bufout(0x06);
	NOP
; 		}
loc_BCD7 		
		;// 6 is no sample  6khz
	LDX #6	; set in init? some param?
loc_BCD9 		
	DEX
	BNE loc_BCD9
; 		delay(6);

	DEC zp_38
	BNE loc_BCC7
;  		} while (zp_38--!=0);

	INY
;  		Y++;
	INC zp_2B
	BNE loc_BCC1
;  	} while (zp_2B!=0);


	LDA #1
	STA zp_2C
	STY zp_42
	LDY zp_31
	RTS

; }
;.else
; #else
; unsigned char soundout4(unsigned char A)
; {

	LDY zp_31
	LDA loc_A800,Y
;  	A>>=4;
	LSR
	LSR
	LSR
	LSR

	; fall through
;-	JMP	soundout4  ; -> soundout 4

;soundout4 
	EOR #$ff
	STA zp_2B
;  	zp_2B = A ^ 0xff;

	LDY zp_42
;  	Y = zp_42;
loc_BCC1 		
;  	do {

	LDA #8
	STA zp_38
; 		zp_38 = 8;
	LDA (zp_2E),Y
;  		A = *(unsigned char*)(zp_2E+(zp_2F<<8)+Y);

loc_BCC7 		
;  		do {
	ASL
	BCC loc_BCD1
; 		if ((A<<=1)&0x100)
;  		{
	LDX #$1A
			;// write into output register
	;STX	_SIDVOL_

	jsr sam_bufout_x
; 	 		sam_bufout(0x1a);

;-	LDX	#$1A
;-	BNE	loc_BCD7
	jmp loc_BCD7
; 		 } else {

loc_BCD1 		
	LDX #6
			;// write into output register
;-	STX	_SIDVOL_

	jsr sam_bufout_x
; 	 		sam_bufout(0x06);

;-	NOP
; 		}
loc_BCD7 		
			
		;// 6 is no sample  6khz
;	LDX	#6	; set in init? some param?
;loc_BCD9 
;	DEX
;	BNE	loc_BCD9
	ldx #$00   ; dont remove!
; 		delay(6);

	DEC zp_38
	BNE loc_BCC7
;  		} while (zp_38--!=0);

	INY
;  		Y++;
	INC zp_2B
	BNE loc_BCC1
;  	} while (zp_2B!=0);


	LDA #1
	STA zp_2C
	STY zp_42
	LDY zp_31
	RTS

; }
;unknown_param2=loc_BCD7+1
;.endif
; #endif

;//--------------------------------------------------------------------------------
;// SOund out (3/4)
;//--------------------------------------------------------------------------------
;//
;// in 
;//	A
;//	X
;//	Y
;//
;// out 
;//	A
;//	X
;//	Y
;//
;// modifies 
;//	A
;//	X
;//	Y
;//--------------------------------------------------------------------------------
;loc_BC8F 

;.if RENDER_TO_BUFFER=0
; #if RENDER_TO_BUFFER==0

; unsigned char soundout3(unsigned char A)
; {

soundout3 		
	EOR #$ff
	TAY
;  	Y = A ^ 0xff;

loc_BC92 		
; 	do
; 	{

	LDA #8
	STA zp_38
;  		zp_38 = 8;

	LDA (zp_2E),Y
;  		A = *(unsigned char*)(zp_2E+(zp_2F<<8)+Y);
loc_BC98 		
;  		do {
	ASL
	BCC loc_BCA2
; 		if (((unsigned short)A<<=1)&0x100)
; 		{
;  			X=zp_35;
	LDX zp_35
			;// write into output register
;  			sam_bufout(X);
	STX VolumeRegister
	BNE loc_BCA8
; 		} else {

loc_BCA2 		
	LDX #5
			;// write into output register
;  			sam_bufout(X);
	STX VolumeRegister
	NOP
; 		}
;  		delay(7);


loc_BCA8 
	;7 = no sample at 6khz
	LDX #7	; (param modified from init!)
loc_BCAA 		
	DEX
	BNE loc_BCAA


	DEC	zp_38
	BNE loc_BC98
;  		} while (zp_38--!=0);

	INY
	BNE loc_BC92
;  	} while (Y++!=0);

	LDA #1
	STA zp_2C
	LDY zp_31
	RTS
; 	zp_2C=1;
; 	return(Y=zp_31);
; }

unknown_param1=loc_BCA8+1
.else
; #else

; unsigned char soundout3(unsigned char A)
; {

soundout3 		
	EOR	#$ff
	TAY
;  	Y = A ^ 0xff;

loc_BC92 		
; 	do
; 	{

	LDA #8
	STA zp_38
;  		zp_38 = 8;

	LDA (zp_2E),Y
;  		A = *(unsigned char*)(zp_2E+(zp_2F<<8)+Y);
loc_BC98 		
;  		do {
	ASL A
	BCC loc_BCA2
; 		if(A&0x80)		
; 		{
; 			A<<=1;
;  			X=zp_35;
	LDX zp_35
			;// write into output register
;  			sam_bufout(X);
;-	STX	_SIDVOL_

	jsr sam_bufout_x
;-	LDX	zp_35
;-	BNE	loc_BCA8
	jmp	loc_BCA8
; 		} else {
; 			A<<=1;

loc_BCA2 		
	LDX #5
			;// write into output register
;  			sam_bufout(X);
;-	STX	_SIDVOL_

	jsr sam_bufout_x

;-	NOP
; 		}
;-loc_BCA8 		
;  		delay(7);
			


;loc_BCA8 
loc_BCA8 
;	ldx #0            ; (param modified from init!)
;	ldx #7
	;7 = no sample at 6khz
;	LDX	#7
;loc_BCAA 		
;	DEX
;	BNE	loc_BCAA
	ldx #0

	DEC zp_38
	BNE loc_BC98
;  		} while (zp_38--!=0);

	INY
	BNE loc_BC92
;  	} while (Y++!=0);

	LDA #1
	STA zp_2C
	LDY zp_31
	RTS
; 	zp_2C=1;
; 	return(Y=zp_31);
; }

unknown_param1=loc_BCA8+1
.endif
; #endif

;//--------------------------------------------------------------------------------
;// SOund out END
;//--------------------------------------------------------------------------------

loc_BCEE 		
	LDA #1
	STA zp_30
	BNE loc_BCF8

loc_BCF4 		
	LDA #$ff
	STA zp_30

loc_BCF8 		
	STX zp_31
	TXA
	SEC
	SBC #$1E
	BCS loc_BD02
	LDA #0

loc_BD02 		
	TAX

loc_BD03 		
	LDA loc_A800,X
	CMP #$7F ; ''
	BNE loc_BD0E
	INX
	JMP loc_BD03

loc_BD0E 		
	CLC
	ADC zp_30
	STA zp_2B
	STA loc_A800,X

loc_BD16 		
	INX
	CPX zp_31
	BEQ loc_BD27
	LDA loc_A800,X
	CMP #$ff
	BEQ loc_BD16
	LDA zp_2B
	JMP loc_BD0E

loc_BD27 		
	JMP loc_B9FF
;--------------------------------------------------------------------------------


sub_BD2F 		
	LDX #$ff
	STX zp_36
	INX
	STX zp_37
	STX zp_42

loc_BD38 		
	LDX zp_42
	LDY speachbuffer2,X
	CPY #$ff
	BNE loc_BD42
	RTS

loc_BD42 		
	CLC
	LDA zp_37
	ADC loc_9CE0,X
	STA zp_37
	CMP #$e8	;$100-$18 
;-	BCC	loc_BD51
;-	JMP	loc_BD7A
	bcs loc_BD7A

loc_BD51 		
	LDA loc_9FDA,Y
	AND #1
	BEQ loc_BD6F
	INX
	STX zp_39
	LDA #0
	STA zp_37
	STA zp_3A
	LDA #$fe	;$100-2
	STA zp_3C
	JSR sub_A036
	INC zp_42
	INC zp_42
	JMP loc_BD38
;--------------------------------------------------------------------------------

loc_BD6F 		
	CPY #0
	BNE loc_BD75
	STX zp_36

loc_BD75 		
	INC zp_42
	JMP loc_BD38
;--------------------------------------------------------------------------------

loc_BD7A 		
	LDX zp_36
	LDA #$1F
	STA speachbuffer2,X
	LDA #4
	STA loc_9CE0,X
	LDA #0
	STA loc_9DE0,X
	INX
	STX zp_39
	LDA #$fe	;$100-2
	STA zp_3C
	LDA #0
	STA zp_37
	STA zp_3A
	JSR sub_A036
	INX
	STX zp_42
	JMP loc_BD38

; ллллллллллллллл S U B	R O U T	I N E ллллллллллллллллллллллллллллллллллллллл
; last routine called by say main

sub_BDA3 		
	LDA #0
	TAX
	TAY

loc_BDA7 		
	LDA speachbuffer2,X
	CMP #$ff
	BNE loc_BDB7
	LDA #$ff
	STA loc_B8C0,Y
	jmp loc_B9D6
;-	JSR loc_B9D6
;-	RTS
	;--------------------------------------------------------------------------------

loc_BDB7 		
	CMP #$fe	;$100-2 
	BNE loc_BDCF
	INX
	STX byte_BDA2
	LDA #$ff
	STA loc_B8C0,Y
	JSR loc_B9D6
byte_BDA2=*+1
	LDX #$00
	LDY #0
	JMP loc_BDA7
;--------------------------------------------------------------------------------

loc_BDCF 		
	CMP #0
	BNE loc_BDD7
	INX
	JMP loc_BDA7

loc_BDD7 		
	STA loc_B8C0,Y
	LDA loc_9CE0,X
	STA loc_B938,Y
	LDA loc_9DE0,X
	STA loc_B8FC,Y
	INX
	INY
	JMP loc_BDA7

; ллллллллллллллл S U B	R O U T	I N E ллллллллллллллллллллллллллллллллллллллл

sub_BDEB 		
	LDX #0

loc_BDED 		
	LDY speachbuffer2,X
	CPY #$ff
	BNE loc_BDF7

loc_BDF4 		
	JMP loc_BE39

loc_BDF7 		
	LDA loc_9FDA,Y
	AND #1
	BNE loc_BE02
	INX
	JMP loc_BDED
;--------------------------------------------------------------------------------

loc_BE02 		
	STX zp_42

loc_BE04 		
	DEX
	BEQ loc_BDF4
	LDY speachbuffer2,X
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BEQ loc_BE04

loc_BE11 		
	LDY speachbuffer2,X
	LDA loc_9FDA,Y
	AND #$20 ; ' '
	BEQ loc_BE22
	LDA loc_9F8C,Y
	AND #4
	BEQ loc_BE30

loc_BE22 		
	LDA loc_9CE0,X
	STA zp_38
	LSR A
	CLC
	ADC zp_38
	ADC #1
	STA loc_9CE0,X

loc_BE30 		
	INX
	CPX zp_42
	BNE loc_BE11
	INX
	JMP loc_BDED
;--------------------------------------------------------------------------------

loc_BE39 		
	LDX #0
	STX zp_42

loc_BE3D 		
	LDX zp_42
	LDY speachbuffer2,X
	CPY #$ff
	BNE loc_BE47
	RTS
;--------------------------------------------------------------------------------

loc_BE47 		
	LDA loc_9F8C,Y
	AND #$80 ; 'Ч'
	BNE loc_BE51
	JMP loc_BEB5
;--------------------------------------------------------------------------------

loc_BE51 		
	INX
	LDY speachbuffer2,X
	LDA loc_9F8C,Y
	STA zp_38
	AND #$40 ; ''
	BEQ loc_BE91
	LDA zp_38
	AND #4
	BEQ loc_BE77
	DEX
	LDA loc_9CE0,X
	STA zp_38
	LSR A
	LSR A
	CLC
	ADC zp_38
	ADC #1
	STA loc_9CE0,X

loc_BE74 		
	JMP loc_BF21
;--------------------------------------------------------------------------------

loc_BE77 		
	LDA zp_38
	AND #1
	BEQ loc_BE74
	DEX
	LDA loc_9CE0,X
	TAY
	LSR
	LSR
	LSR
	STA zp_38
	SEC
	TYA
	SBC zp_38
	STA loc_9CE0,X
	JMP loc_BF21
;--------------------------------------------------------------------------------

loc_BE91 		
	CPY #$12
	BEQ loc_BE9C
	CPY #$13
	BEQ loc_BE9C

loc_BE99 		
	JMP loc_BF21
;--------------------------------------------------------------------------------

loc_BE9C 		
	INX
	LDY speachbuffer2,X
	LDA loc_9F8C,Y
	AND #$40 ; ''
	BEQ loc_BE99
	LDX zp_42
	LDA loc_9CE0,X
	SEC
	SBC #1
	STA loc_9CE0,X
	JMP loc_BF21
;--------------------------------------------------------------------------------

loc_BEB5 		
	LDA loc_9FDA,Y
	AND #8
	BEQ loc_BED8
	INX
	LDY speachbuffer2,X
	LDA loc_9F8C,Y
	AND #2
	BNE loc_BECA

loc_BEC7 		
	JMP loc_BF21
;--------------------------------------------------------------------------------

loc_BECA 		
	LDA #6
	STA loc_9CE0,X
	DEX
	LDA #5
	STA loc_9CE0,X
	JMP loc_BF21
;--------------------------------------------------------------------------------

loc_BED8 		
	LDA loc_9F8C,Y
	AND #2
	BEQ loc_BF05

loc_BEDF 		
	INX
	LDY speachbuffer2,X
	BEQ loc_BEDF
	LDA loc_9F8C,Y
	AND #2
	BEQ loc_BEC7
	LDA loc_9CE0,X
	LSR A
	CLC
	ADC #1
	STA loc_9CE0,X
	LDX zp_42
	LDA loc_9CE0,X
	LSR A
	CLC
	ADC #1
	STA loc_9CE0,X

loc_BF02 		
			
	JMP loc_BF21
;--------------------------------------------------------------------------------

loc_BF05 		
	LDA loc_9FDA,Y
	AND #$10
	BEQ loc_BF02
	DEX
	LDY speachbuffer2,X
	LDA loc_9F8C,Y
	AND #2
	BEQ loc_BF02
	INX
	LDA loc_9CE0,X
	SEC
	SBC #2
	STA loc_9CE0,X

	; loop end
loc_BF21 		
	INC zp_42
	JMP loc_BE3D

;//--------------------------------------------------------------------------------
;// .data Segment (Read/Write Data)
;//--------------------------------------------------------------------------------

;.if REARRANGE_VARIABLES=0
byte_992C 	.byt 0
byte_992D 	.byt $22
byte_992E 	.byt 0
byte_992F 	.byt $22
byte_9930 	.byt $36
byte_9931 	.byt 3
byte_9932 	.byt 0
; unsigned char byte_9a14;	
;-byte_9A14 	.byte $FF	; changed to selfmodding code
; unsigned char speed_value;	// 9a0e
;-speed_value 	.byte $48	; changed to selfmodding code
; unsigned char pitch_value;	// 9a0f
;-pitch_value 	.byte $40	; changed to selfmodding code
;.endif

; unsigned char freq1data[]=
; {
loc_B000  ; read/write
 .byt 0 ,$13 ,$13 ,$13 ,$13 , $A , $E ,$12
 .byt $18 ,$1A ,$16 ,$14 ,$10 ,$14 , $E ,$12
 .byt $E ,$12 ,$12 ,$10 , $C , $E , $A ,$12
 .byt $E ,$A  , 8  , 6  , 6  ,  6 ,  6 ,$11
 .byt 6 , 6 , 6 , 6 ,$E , $10 , 9 ,$A
 .byt 8 ,$A , 6 , 6 , 6 , 5 , 6 , 0
 .byt $12 , $1A , $14 , $1A , $12 ,$C , 6 , 6
 .byt 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6
 .byt 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6
 .byt 6 ,$A ,$A , 6 , 6 , 6 , $2C , $13
; };

; unsigned char freq2data[]=
; {
loc_B050  ; read/write
 .byt 0 , $43 , $43 , $43 , $43 , $54 , $48 , $42
 .byt $3E , $28 , $2C , $1E , $24 , $2C , $48 , $30
 .byt $24 , $1E , $32 , $24 , $1C , $44 , $18 , $32
 .byt $1E , $18 , $52 , $2E , $36 , $56 , $36 , $43
 .byt $49 , $4F , $1A , $42 , $49 , $25 , $33 , $42
 .byt $28 , $2F , $4F , $4F , $42 , $4F , $6E , 0
 .byt $48 , $26 , $1E , $2A , $1E , $22 , $1A , $1A
 .byt $1A , $42 , $42 , $42 , $6E , $6E , $6E , $54
 .byt $54 , $54 , $1A , $1A , $1A , $42 , $42 , $42
 .byt $6D , $56 , $6D , $54 , $54 , $54 , $7F , $7F
; };

;//--------------------------------------------------------------------------------
;// .rodata Segment (Read-only/Constant Data)
;//--------------------------------------------------------------------------------

; unsigned char stressInputTable[] =
; {
;         '*', '1', '2', '3', '4', '5', '6', '7', '8'
loc_9EE0   ; read only
 .byt  $2A , $31 , $32 , $33 , $34 , $35 , $36 , $37
 .byt  $38 , $39
; };

; unsigned char signInputTable1[]={
; 	' ', '.', '?', ',', '-', 'I', 'I', 'E',
; 	'A', 'A', 'A', 'A', 'U', 'A', 'I', 'E',
; 	'U', 'O', 'R', 'L', 'W', 'Y', 'W', 'R',
; 	'L', 'W', 'Y', 'M', 'N', 'N', 'D', 'Q',
; 	'S', 'S', 'F', 'T', '/', '/', 'Z', 'Z',
; 	'V', 'D', 'C', '*', 'J', '*', '*', '*',
; 	'E', 'A', 'O', 'A', 'O', 'U', 'B', '*',
; 	'*', 'D', '*', '*', 'G', '*', '*', 'G',
; 	'*', '*', 'P', '*', '*', 'T', '*', '*',
; 	'K', '*', '*', 'K', '*', '*', 'U', 'U',
; 	'U'
loc_9EEA   ; read only
 .byt  $20 , $2E , $3F , $2C , $2D , $49 , $49 , $45
 .byt  $41 , $41 , $41 , $41 , $55 , $41 , $49 , $45
 .byt  $55 , $4F , $52 , $4C , $57 , $59 , $57 , $52
 .byt  $4C , $57 , $59 , $4D , $4E , $4E , $44 , $51
 .byt  $53 , $53 , $46 , $54 , $2F , $2F , $5A , $5A
 .byt  $56 , $44 , $43 , $2A , $4A , $2A , $2A , $2A
 .byt  $45 , $41 , $4F , $41 , $4F , $55 , $42 , $2A
 .byt  $2A , $44 , $2A , $2A , $47 , $2A , $2A , $47
 .byt  $2A , $2A , $50 , $2A , $2A , $54 , $2A , $2A
 .byt  $4B , $2A , $2A , $4B , $2A , $2A , $55 , $55
 .byt  $55
; };

; unsigned char signInputTable2[] =
; {
; 	'*', '*', '*', '*', '*', 'Y', 'H', 'H',
; 	'E', 'A', 'H', 'O', 'H', 'X', 'X', 'R',
; 	'X', 'H', 'X', 'X', 'X', 'X', 'H', '*',
; 	'*', '*', '*', '*', '*', 'X', 'X', '*',
; 	'*', 'H', '*', 'H', 'H', 'X', '*', 'H',
; 	'*', 'H', 'H', '*', '*', '*', '*', '*',
; 	'Y', 'Y', 'Y', 'W', 'W', 'W', '*', '*',
; 	'*', '*', '*', '*', '*', '*', '*', 'X',
; 	'*', '*', '*', '*', '*', '*', '*', '*',
; 	'*', '*', '*', 'X', '*', '*', 'L', 'M',
; 	'N'
loc_9F3B  ; read only
 .byt  $2A , $2A , $2A , $2A , $2A , $59 , $48 , $48
 .byt  $45 , $41 , $48 , $4F , $48 , $58 , $58 , $52
 .byt  $58 , $48 , $58 , $58 , $58 , $58 , $48 , $2A
 .byt  $2A , $2A , $2A , $2A , $2A , $58 , $58 , $2A
 .byt  $2A , $48 , $2A , $48 , $48 , $58 , $2A , $48
 .byt  $2A , $48 , $48 , $2A , $2A , $2A , $2A , $2A
 .byt  $59 , $59 , $59 , $57 , $57 , $57 , $2A , $2A
 .byt  $2A , $2A , $2A , $2A , $2A , $2A , $2A , $58
 .byt  $2A , $2A , $2A , $2A , $2A , $2A , $2A , $2A
 .byt  $2A , $2A , $2A , $58 , $2A , $2A , $4C , $4D
 .byt  $4E
; };

; Leider wird hфufig ausserhalb einer Tabelle lesend zugegriffen.
; Damit mein ich das Flagfeld loc_9F8C.
; 1. wќrde ich loc_9F8C und loc_9FDA unbedingt zusammenlassen.
; 2. sollte bei loc_9F8C+FF eine 41(hexadezimal) stehen.

; unsigned char flags[]={
loc_9F8C   ; read only
 .byt 0 , 0 , 0 , 0 , 0 , $A4 , $A4 , $A4
 .byt $A4 , $A4 , $A4 , $84 , $84 , $A4 , $A4 , $84
 .byt $84 , $84 , $84 , $84 , $84 , $84 , $44 , $44
 .byt $44 , $44 , $44 , $4C , $4C , $4C , $48 , $4C
 .byt $40 , $40 , $40 , $40 , $40 , $40 , $44 , $44
 .byt $44 , $44 , $48 , $40 , $4C , $44 , 0 , 0
 .byt $B4 , $B4 , $B4 , $94 , $94 , $94 , $4E , $4E
 .byt $4E , $4E , $4E , $4E , $4E , $4E , $4E , $4E
 .byt $4E , $4E , $4B , $4B , $4B , $4B , $4B , $4B
 .byt $4B , $4B , $4B , $4B , $4B , $4B
; };

; unsigned char flags2[]={
loc_9FDA  ; read only
 .byt $80 , $C1 , $C1 , $C1 , $C1 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , $10
 .byt $10 , $10 , $10 , 8 ,$C , 8 , 4 , $40
 .byt $24 , $20 , $20 , $24 , 0 , 0 , $24 , $20
 .byt $20 , $24 , $20 , $20 , 0 , $20 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 4 , 4 , 4 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 4 , 4 , 4
 .byt 0 , 0 , 0 , 0 , 0 , 0
; };

; unsigned char sinus[]={
loc_A500  ; read only
 .byt 0 , 0 , 0 ,$10 ,$10 ,$10 ,$10 ,$10
 .byt $10 ,$20,$20,$20 ,$20 ,$20 ,$20 ,$30
 .byt $30 ,$30,$30,$30 ,$30 ,$30 ,$40 ,$40
 .byt $40 ,$40,$40,$40 ,$40 ,$50 ,$50 ,$50
 .byt $50 ,$50,$50,$50 ,$50 ,$60 ,$60 ,$60
 .byt $60 , $60 , $60 , $60 , $60 , $60 , $60 , $60
 .byt $60 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $60 , $60 , $60 , $60 , $60 , $60 , $60 , $60
 .byt $60 , $60 , $60 , $60 , $50 , $50 , $50 , $50
 .byt $50 , $50 , $50 , $50 , $40 , $40 , $40 , $40
 .byt $40 , $40 , $40 , $30 , $30 , $30 , $30 , $30
 .byt $30 , $30 , $20 , $20 , $20 , $20 , $20 , $20
 .byt $10 , $10 , $10 , $10 , $10 , $10 , 0 , 0
 .byt 0 , 0 , 0 , $F0 , $F0 , $F0 , $F0 , $F0
 .byt $F0 , $E0 , $E0 , $E0 , $E0 , $E0 , $E0 , $D0
 .byt $D0 , $D0 , $D0 , $D0 , $D0 , $D0 , $C0 , $C0
 .byt $C0 , $C0 , $C0 , $C0 , $C0 , $B0 , $B0 , $B0
 .byt $B0 , $B0 , $B0 , $B0 , $B0 , $A0 , $A0 , $A0
 .byt $A0 , $A0 , $A0 , $A0 , $A0 , $A0 , $A0 , $A0
 .byt $A0 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $A0 , $A0 , $A0 , $A0 , $A0 , $A0 , $A0 , $A0
 .byt $A0 , $A0 , $A0 , $A0 , $B0 , $B0 , $B0 , $B0
 .byt $B0 , $B0 , $B0 , $B0 , $C0 , $C0 , $C0 , $C0
 .byt $C0 , $C0 , $C0 , $D0 , $D0 , $D0 , $D0 , $D0
 .byt $D0 , $D0 , $E0 , $E0 , $E0 , $E0 , $E0 , $E0
 .byt $F0 , $F0 , $F0 , $F0 , $F0 , $F0 , 0 , 0
; };

; unsigned char rectangle[]={
loc_A600  ; read only
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $90 , $90 , $90 , $90 , $90 , $90 , $90 , $90
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
 .byt $70 , $70 , $70 , $70 , $70 , $70 , $70 , $70
; };

; unsigned char multtable[]={
loc_A700    ; read only
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 1 , 1 , 2 , 2 , 3 , 3
 .byt 4 , 4 , 5 , 5 , 6 , 6 , 7 , 7
 .byt 0 , 1 , 2 , 3 , 4 , 5 , 6 , 7
 .byt 8 , 9 ,$A ,$B ,$C ,$D ,$E ,$F
 .byt 0 , 1 , 3 , 4 , 6 , 7 , 9 ,$A
 .byt $C ,$D ,$F , $10 , $12 , $13 , $15 , $16
 .byt 0 , 2 , 4 , 6 , 8 ,$A ,$C ,$E
 .byt $10 , $12 , $14 , $16 , $18 , $1A , $1C , $1E
 .byt 0 , 2 , 5 , 7 ,$A ,$C ,$F , $11
 .byt $14 , $16 , $19 , $1B , $1E , $20 , $23 , $25
 .byt 0 , 3 , 6 , 9 ,$C ,$F , $12 , $15
 .byt $18 , $1B , $1E , $21 , $24 , $27 , $2A , $2D
 .byt 0 , 3 , 7 ,$A ,$E , $11 , $15 , $18
 .byt $1C , $1F , $23 , $26 , $2A , $2D , $31 , $34
 .byt 0 , $FC , $F8 , $F4 , $F0 , $EC , $E8 , $E4
 .byt $E0 , $DC , $D8 , $D4 , $D0 , $CC , $C8 , $C4
 .byt 0 , $FC , $F9 , $F5 , $F2 , $EE , $EB , $E7
 .byt $E4 , $E0 , $DD , $D9 , $D6 , $D2 , $CF , $CB
 .byt 0 , $FD , $FA , $F7 , $F4 , $F1 , $EE , $EB
 .byt $E8 , $E5 , $E2 , $DF , $DC , $D9 , $D6 , $D3
 .byt 0 , $FD , $FB , $F8 , $F6 , $F3 , $F1 , $EE
 .byt $EC , $E9 , $E7 , $E4 , $E2 , $DF , $DD , $DA
 .byt 0 , $FE , $FC , $FA , $F8 , $F6 , $F4 , $F2
 .byt $F0 , $EE , $EC , $EA , $E8 , $E6 , $E4 , $E2
 .byt 0 , $FE , $FD , $FB , $FA , $F8 , $F7 , $F5
 .byt $F4 , $F2 , $F1 , $EF , $EE , $EC , $EB , $E9
 .byt 0 , $FF , $FE , $FD , $FC , $FB , $FA , $F9
 .byt $F8 , $F7 , $F6 , $F5 , $F4 , $F3 , $F2 , $F1
 .byt 0 , $FF , $FF , $FE , $FE , $FD , $FD , $FC
 .byt $FC , $FB , $FB , $FA , $FA , $F9 , $F9 , $F8
; };

; unsigned char freq3data[]={
loc_B0A0  ; read only
 .byt 0 , $5B , $5B , $5B , $5B , $6E , $5D , $5B
 .byt $58 , $59 , $57 , $58 , $52 , $59 , $5D , $3E
 .byt $52 , $58 , $3E , $6E , $50 , $5D , $5A , $3C
 .byt $6E , $5A , $6E , $51 , $79 , $65 , $79 , $5B
 .byt $63 , $6A , $51 , $79 , $5D , $52 , $5D , $67
 .byt $4C , $5D , $65 , $65 , $79 , $65 , $79 , 0
 .byt $5A , $58 , $58 , $58 , $58 , $52 , $51 , $51
 .byt $51 , $79 , $79 , $79 , $70 , $6E , $6E , $5E
 .byt $5E , $5E , $51 , $51 , $51 , $79 , $79 , $79
 .byt $65 , $65 , $70 , $5E , $5E , $5E , 8 , 1
; };

; unsigned char ampl1data[]={
loc_B0F0  ; read only
 .byt 0 , 0 , 0 , 0 , 0 ,$D ,$D ,$E
 .byt $F ,$F ,$F ,$F ,$F ,$C ,$D ,$C
 .byt $F ,$F ,$D ,$D ,$D ,$E ,$D ,$C
 .byt $D ,$D ,$D ,$C , 9 , 9 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 ,$B ,$B
 .byt $B ,$B , 0 , 0 , 1 ,$B , 0 , 2
 .byt $E ,$F ,$F ,$F ,$F ,$D , 2 , 4
 .byt 0 , 2 , 4 , 0 , 1 , 4 , 0 , 1 
 .byt 4 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 ,$C , 0 , 0 , 0 , 0 ,$F ,$F
; };

; unsigned char ampl2data[]={
loc_B140  ; read only
 .byt 0 , 0 , 0 , 0 , 0 ,$A ,$B ,$D
 .byt $E ,$D ,$C ,$C ,$B , 9 ,$B ,$B
 .byt $C ,$C ,$C , 8 , 8 ,$C , 8 ,$A
 .byt 8 , 8 ,$A , 3 , 9 , 6 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 3 , 5
 .byt 3 , 4 , 0 , 0 , 0 , 5 ,$A , 2
 .byt $E ,$D ,$C ,$D ,$C , 8 , 0 , 1
 .byt 0 , 0 , 1 , 0 , 0 , 1 , 0 , 0
 .byt 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 ,$A , 0 , 0 ,$A , 0 , 0 , 0
; };

; unsigned char ampl3data[]={
loc_B190  ; read only
 .byt 0 , 0 , 0 , 0 , 0 , 8 , 7 , 8
 .byt 8 , 1 , 1 , 0 , 1 , 0 , 7 , 5
 .byt 1 , 0 , 6 , 1 , 0 , 7 , 0 , 5
 .byt 1 , 0 , 8 , 0 , 0 , 3 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1
 .byt 0 , 0 , 0 , 0 , 0 , 1 ,$E , 1
 .byt 9 , 1 , 0 , 1 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 7 , 0 , 0 , 5 , 0 , $13 , $10
; };

; unsigned char phonemeLengthTable2[]={
loc_B1E0  ; read only
 .byt 0 , $12 , $12 , $12 , 8 ,$B , 9 ,$B
 .byt $E ,$F ,$B , $10 ,$C , 6 , 6 ,$E
 .byt $C ,$E ,$C ,$B , 8 , 8 ,$B ,$A
 .byt 9 , 8 , 8 , 8 , 8 , 8 , 3 , 5
 .byt 2 , 2 , 2 , 2 , 2 , 2 , 6 , 6
 .byt 8 , 6 , 6 , 2 , 9 , 4 , 2 , 1
 .byt $E ,$F ,$F ,$F ,$E ,$E , 8 , 2
 .byt 2 , 7 , 2 , 1 , 7 , 2 , 2 , 7
 .byt 2 , 2 , 8 , 2 , 2 , 6 , 2 , 2
 .byt 7 , 2 , 4 , 7 , 1 , 4 , 5 , 5
; };

; unsigned char phonemeLengthTable1[]={
loc_B230  ; read only
 .byt 0 , $12 , $12 , $12 , 8 , 8 , 8 , 8
 .byt 8 ,$B , 6 ,$C ,$A , 5 , 5 ,$B
 .byt $A ,$A ,$A , 9 , 8 , 7 , 9 , 7
 .byt 6 , 8 , 6 , 7 , 7 , 7 , 2 , 5
 .byt 2 , 2 , 2 , 2 , 2 , 2 , 6 , 6
 .byt 7 , 6 , 6 , 2 , 8 , 3 , 1 , $1E
 .byt $D ,$C ,$C ,$C ,$E , 9 , 6 , 1
 .byt 2 , 5 , 1 , 1 , 6 , 1 , 2 , 6
 .byt 1 , 2 , 8 , 2 , 2 , 4 , 2 , 2
 .byt 6 , 1 , 4 , 6 , 1 , 4 , $C7 , $FF
; };

; unsigned char tab45696[]={
loc_B280  ; read only
 .byt 0 , 2 , 2 , 2 , 2 , 4 , 4 , 4
 .byt 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4
 .byt 4 , 4 , 3 , 2 , 4 , 4 , 2 , 2
 .byt 2 , 2 , 2 , 1 , 1 , 1 , 1 , 1
 .byt 1 , 1 , 1 , 1 , 1 , 1 , 2 , 2
 .byt 2 , 1 , 0 , 1 , 0 , 1 , 0 , 5
 .byt 5 , 5 , 5 , 5 , 4 , 4 , 2 , 0
 .byt 1 , 2 , 0 , 1 , 2 , 0 , 1 , 2
 .byt 0 , 1 , 2 , 0 , 2 , 2 , 0 , 1
 .byt 3 , 0 , 2 , 3 , 0 , 2 , $A0 , $A0
; };

; unsigned char tab45776[]={
loc_B2D0  ; read only
 .byt 0 , 2 , 2 , 2 , 2 , 4 , 4 , 4
 .byt 4 , 4 , 4 , 4 , 4 , 4 , 4 , 4
 .byt 4 , 4 , 3 , 3 , 4 , 4 , 3 , 3
 .byt 3 , 3 , 3 , 1 , 2 , 3 , 2 , 1
 .byt 3 , 3 , 3 , 3 , 1 , 1 , 3 , 3
 .byt 3 , 2 , 2 , 3 , 2 , 3 , 0 , 0
 .byt 5 , 5 , 5 , 5 , 4 , 4 , 2 , 0
 .byt 2 , 2 , 0 , 3 , 2 , 0 , 4 , 2
 .byt 0 , 3 , 2 , 0 , 2 , 2 , 0 , 2
 .byt 3 , 0 , 3 , 3 , 0 , 3 , $B0 , $A0
; };

; unsigned char tab45856[]={
loc_B320  ; read only
.byt 0 , $1F , $1F , $1F , $1F , 2 , 2 , 2
.byt 2 , 2 , 2 , 2 , 2 , 2 , 5 , 5
.byt 2 ,$A , 2 , 8 , 5 , 5 ,$B ,$A
.byt 9 , 8 , 8 , $A0 , 8 , 8 , $17 , $1F
.byt $12 , $12 , $12 , $12 , $1E , $1E , $14 , $14
.byt $14 , $14 , $17 , $17 , $1A , $1A , $1D , $1D
.byt 2 , 2 , 2 , 2 , 2 , 2 , $1A , $1D
.byt $1B , $1A , $1D , $1B , $1A , $1D , $1B , $1A
.byt $1D , $1B , $17 , $1D , $17 , $17 , $1D , $17
.byt $17 , $1D , $17 , $17 , $1D , $17 , $17 , $17
; };

; unsigned char tab45936[]={
loc_B370  ; read only
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt $F1 , $E2 , $D3 , $BB , $7C , $95 , 1 , 2
 .byt 3 , 3 , 0 , $72 , 0 , 2 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
 .byt 0 , 0 , 0 , $1B , 0 , 0 , $19 , 0
 .byt 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0
; };

; unsigned char amplitudeRescale[]=
; {
; 	0x00,0x01,0x02,0x02,0x02,0x03,0x03,0x04,
; 	0x04,0x05,0x06,0x08,0x09,0x0b,0x0d,0x0f,0x00
loc_B974    ; read only
 .byt 0 , 1 , 2 , 2 , 2 , 3 , 3 , 4
 .byt 4 , 5 , 6 , 8 , 9 ,$B ,$D ,$F
 .byt 0	; 17 elements ?
; };

; unsigned char tab47492[11]=
; {
; 	0x00 , 0x00 , 0xE0 , 0xE6 , 0xEC , 0xF3 , 0xF9 , 0x00,0x06 ,0x0C , 0x06
loc_B984    ; read only
 .byt 0 , 0 , $E0 , $E6 , $EC , $F3 , $F9 , 0
 .byt 6 ,$C , 6
; };

; unsigned char tab48426[5]=
; {
; 	0x18,0x1a,0x17,0x17,0x17
loc_BD2A    ; read only
 .byt $18,$1a,$17,$17,$17
; };

; unsigned char randomtable[0x500]=
; {
loc_B3C0   ; read only
;00
 .byt $38 , $84 , $6B , $19 , $C6 , $63 ,  $18 , $86 
 .byt $73 , $98 , $C6 , $B1 , $1C , $CA , $31 , $8C 
 .byt $C7 , $31 , $88 , $C2 , $30 , $98 , $46 , $31 
 .byt $18 , $C6 , $35 ,$C , $CA , $31 ,$C , $C6 

; 	0x38 , 0x84 , 0x6B , 0x19 , 0xC6 , 0x63 ,  0x18 , 0x86, 
; 	0x73 , 0x98 , 0xC6 , 0xB1 , 0x1C , 0xCA , 0x31 , 0x8C, 
; 	0xC7 , 0x31 , 0x88 , 0xC2 , 0x30 , 0x98 , 0x46 , 0x31, 
; 	0x18 , 0xC6 , 0x35 ,0xC , 0xCA , 0x31 ,0xC , 0xC6, 

;20
 .byt $21 , $10 , $24 , $69 , $12 , $C2 , $31 , $14 
 .byt $C4 , $71 , 8 , $4A , $22 , $49 , $AB , $6A 
 .byt $A8 , $AC , $49 , $51 , $32 , $D5 , $52 , $88 
 .byt $93 , $6C , $94 , $22 , $15 , $54 , $D2 , $25 
;40
 .byt $96 , $D4 , $50 , $A5 , $46 , $21 , 8 , $85 
 .byt $6B , $18 , $C4 , $63 , $10 , $CE , $6B , $18 
 .byt $8C , $71 , $19 , $8C , $63 , $35 ,$C , $C6 
 .byt $33 , $99 , $CC , $6C , $B5 , $4E , $A2 , $99 
;60
 .byt $46 , $21 , $28 , $82 , $95 , $2E , $E3 , $30 
 .byt $9C , $C5 , $30 , $9C , $A2 , $B1 , $9C , $67 
 .byt $31 , $88 , $66 , $59 , $2C , $53 , $18 , $84 
 .byt $67 , $50 , $CA , $E3 ,$A , $AC , $AB , $30 
;80
 .byt $AC , $62 , $30 , $8C , $63 , $10 , $94 , $62 
 .byt $B1 , $8C , $82 , $28 , $96 , $33 , $98 , $D6 
 .byt $B5 , $4C , $62 , $29 , $A5 , $4A , $B5 , $9C 
 .byt $C6 , $31 , $14 , $D6 , $38 , $9C , $4B , $B4 
;A0
 .byt $86 , $65 , $18 , $AE , $67 , $1C , $A6 , $63 
 .byt $19 , $96 , $23 , $19 , $84 , $13 , 8 , $A6 
 .byt $52 , $AC , $CA , $22 , $89 , $6E , $AB , $19 
 .byt $8C , $62 , $34 , $C4 , $62 , $19 , $86 , $63 
;C0
 .byt $18 , $C4 , $23 , $58 , $D6 , $A3 , $50 , $42 
 .byt $54 , $4A , $AD , $4A , $25 , $11 , $6B , $64 
 .byt $89 , $4A , $63 , $39 , $8A , $23 , $31 , $2A 
 .byt $EA , $A2 , $A9 , $44 , $C5 , $12 , $CD , $42 
;E0
 .byt $34 , $8C , $62 , $18 , $8C , $63 , $11 , $48 
 .byt $66 , $31 , $9D , $44 , $33 , $1D , $46 , $31 
 .byt $9C , $C6 , $B1 ,$C , $CD , $32 , $88 , $C4 
 .byt $73 , $18 , $86 , $73 , 8 , $D6 , $63 , $58 
;100
 .byt 7 , $81 , $E0 , $F0 , $3C , 7 , $87 , $90 
 .byt $3C , $7C ,$F , $C7 , $C0 , $C0 , $F0 , $7C 
 .byt $1E , 7 , $80 , $80 , 0 , $1C , $78 , $70 
 .byt $F1 , $C7 , $1F , $C0 ,$C , $FE , $1C , $1F 
;120
 .byt $1F ,$E ,$A , $7A , $C0 , $71 , $F2 , $83 
 .byt $8F , 3 ,$F ,$F ,$C , 0 , $79 , $F8 
 .byt $61 , $E0 , $43 ,$F , $83 , $E7 , $18 , $F9 
 .byt $C1 , $13 , $DA , $E9 , $63 , $8F ,$F , $83 
;140
.byt $83 , $87 , $C3 , $1F , $3C , $70 , $F0 , $E1 
.byt $E1 , $E3 , $87 , $B8 , $71 ,$E , $20 , $E3 
.byt $8D , $48 , $78 , $1C , $93 , $87 , $30 , $E1 
.byt $C1 , $C1 , $E4 , $78 , $21 , $83 , $83 , $C3 
;160
 .byt $87 , 6 , $39 , $E5 , $C3 , $87 , 7 ,$E 
 .byt $1C , $1C , $70 , $F4 , $71 , $9C , $60 , $36 
 .byt $32 , $C3 , $1E , $3C , $F3 , $8F ,$E , $3C 
 .byt $70 , $E3 , $C7 , $8F ,$F ,$F ,$E , $3C 
;180
 .byt $78 , $F0 , $E3 , $87 , 6 , $F0 , $E3 , 7 
 .byt $C1 , $99 , $87 ,$F , $18 , $78 , $70 , $70 
 .byt $FC , $F3 , $10 , $B1 , $8C , $8C , $31 , $7C 
 .byt $70 , $E1 , $86 , $3C , $64 , $6C , $B0 , $E1 
;1A0
 .byt $E3 ,$F , $23 , $8F ,$F , $1E , $3E , $38 
 .byt $3C , $38 , $7B , $8F , 7 ,$E , $3C , $F4 
 .byt $17 , $1E , $3C , $78 , $F2 , $9E , $72 , $49 
 .byt $E3 , $25 , $36 , $38 , $58 , $39 , $E2 , $DE 
;1C0
 .byt $3C , $78 , $78 , $E1 , $C7 , $61 , $E1 , $E1 
 .byt $B0 , $F0 , $F0 , $C3 , $C7 ,$E , $38 , $C0 
 .byt $F0 , $CE , $73 , $73 , $18 , $34 , $B0 , $E1 
 .byt $C7 , $8E , $1C , $3C , $F8 , $38 , $F0 , $E1 
;1E0
 .byt $C1 , $8B , $86 , $8F , $1C , $78 , $70 , $F0 
 .byt $78 , $AC , $B1 , $8F , $39 , $31 , $DB , $38 
 .byt $61 , $C3 ,$E ,$E , $38 , $78 , $73 , $17 
 .byt $1E , $39 , $1E , $38 , $64 , $E1 , $F1 , $C1 
;200
 .byt $4E ,$F , $40 , $A2 , 2 , $C5 , $8F , $81 
 .byt $A1 , $FC , $12 , 8 , $64 , $E0 , $3C , $22 
 .byt $E0 , $45 , 7 , $8E ,$C , $32 , $90 , $F0 
 .byt $1F , $20 , $49 , $E0 , $F8 ,$C , $60 , $F0 
;220
 .byt $17 , $1A , $41 , $AA , $A4 , $D0 , $8D , $12 
 .byt $82 , $1E , $1E , 3 , $F8 , $3E , 3 ,$C 
 .byt $73 , $80 , $70 , $44 , $26 , 3 , $24 , $E1 
 .byt $3E , 4 , $4E , 4 , $1C , $C1 , 9 , $CC 
;240
 .byt $9E , $90 , $21 , 7 , $90 , $43 , $64 , $C0 
 .byt $F , $C6 , $90 , $9C , $C1 , $5B , 3 , $E2 
 .byt $1D , $81 , $E0 , $5E , $1D , 3 , $84 , $B8 
 .byt $2C ,$F , $80 , $B1 , $83 , $E0 , $30 , $41 
;260
 .byt $1E , $43 , $89 , $83 , $50 , $FC , $24 , $2E 
 .byt $13 , $83 , $F1 , $7C , $4C , $2C , $C9 ,$D 
 .byt $83 , $B0 , $B5 , $82 , $E4 , $E8 , 6 , $9C 
 .byt 7 , $A0 , $99 , $1D , 7 , $3E , $82 , $8F 
;280
 .byt $70 , $30 , $74 , $40 , $CA , $10 , $E4 , $E8 
 .byt $F , $92 , $14 , $3F , 6 , $F8 , $84 , $88 
 .byt $43 , $81 ,$A , $34 , $39 , $41 , $C6 , $E3 
 .byt $1C , $47 , 3 , $B0 , $B8 , $13 ,$A , $C2 
;2A0
 .byt $64 , $F8 , $18 , $F9 , $60 , $B3 , $C0 , $65 
 .byt $20 , $60 , $A6 , $8C , $C3 , $81 , $20 , $30 
 .byt $26 , $1E , $1C , $38 , $D3 , 1 , $B0 , $26 
 .byt $40 , $F4 ,$B , $C3 , $42 , $1F , $85 , $32 
;2C0
 .byt $26 , $60 , $40 , $C9 , $CB , 1 , $EC , $11 
 .byt $28 , $40 , $FA , 4 , $34 , $E0 , $70 , $4C 
 .byt $8C , $1D , 7 , $69 , 3 , $16 , $C8 , 4 
 .byt $23 , $E8 , $C6 , $9A ,$B , $1A , 3 , $E0 
;2E0
 .byt $76 , 6 , 5 , $CF , $1E , $BC , $58 , $31 
 .byt $71 , $66 , 0 , $F8 , $3F , 4 , $FC ,$C 
 .byt $74 , $27 , $8A , $80 , $71 , $C2 , $3A , $26 
 .byt 6 , $C0 , $1F , 5 ,$F , $98 , $40 , $AE 
;300
 .byt 1 , $7F , $C0 , 7 , $FF , 0 ,$E , $FE 
 .byt 0 , 3 , $DF , $80 , 3 , $EF , $80 , $1B 
 .byt $F1 , $C2 , 0 , $E7 , $E0 , $18 , $FC , $E0 
 .byt $21 , $FC , $80 , $3C , $FC , $40 ,$E , $7E 
;320
 .byt 0 , $3F , $3E , 0 ,$F , $FE , 0 , $1F 
 .byt $FF , 0 , $3E , $F0 , 7 , $FC , 0 , $7E 
 .byt $10 , $3F , $FF , 0 , $3F , $38 ,$E , $7C 
 .byt 1 , $87 ,$C , $FC , $C7 , 0 , $3E , 4 
;340
 .byt $F , $3E , $1F ,$F ,$F , $1F ,$F , 2 
 .byt $83 , $87 , $CF , 3 , $87 ,$F , $3F , $C0 
 .byt 7 , $9E , $60 , $3F , $C0 , 3 , $FE , 0 
 .byt $3F , $E0 , $77 , $E1 , $C0 , $FE , $E0 , $C3 
;360
 .byt $E0 , 1 , $DF , $F8 , 3 , 7 , 0 , $7E 
 .byt $70 , 0 , $7C , $38 , $18 , $FE ,$C , $1E 
 .byt $78 , $1C , $7C , $3E ,$E , $1F , $1E , $1E 
 .byt $3E , 0 , $7F , $83 , 7 , $DB , $87 , $83 
;380
 .byt 7 , $C7 , 7 , $10 , $71 , $FF , 0 , $3F 
 .byt $E2 , 1 , $E0 , $C1 , $C3 , $E1 , 0 , $7F 
 .byt $C0 , 5 , $F0 , $20 , $F8 , $F0 , $70 , $FE 
 .byt $78 , $79 , $F8 , 2 , $3F ,$C , $8F , 3 
;3a0
 .byt $F , $9F , $E0 , $C1 , $C7 , $87 , 3 , $C3 
 .byt $C3 , $B0 , $E1 , $E1 , $C1 , $E3 , $E0 , $71 
 .byt $F0 , 0 , $FC , $70 , $7C ,$C , $3E , $38 
 .byt $E , $1C , $70 , $C3 , $C7 , 3 , $81 , $C1 
;3c0
 .byt $C7 , $E7 , 0 ,$F , $C7 , $87 , $19 , 9 
 .byt $EF , $C4 , $33 , $E0 , $C1 , $FC , $F8 , $70 
 .byt $F0 , $78 , $F8 , $F0 , $61 , $C7 , 0 , $1F 
 .byt $F8 , 1 , $7C , $F8 , $F0 , $78 , $70 , $3C 
;3e0
 .byt $7C , $CE ,$E , $21 , $83 , $CF , 8 , 7 
 .byt $8F , 8 , $C1 , $87 , $8F , $80 , $C7 , $E3 
 .byt 0 , 7 , $F8 , $E0 , $EF , 0 , $39 , $F7 
 .byt $80 ,$E , $F8 , $E1 , $E3 , $F8 , $21 , $9F 
;400
 .byt $C0 , $FF , 3 , $F8 , 7 , $C0 , $1F , $F8 
 .byt $C4 , 4 , $FC , $C4 , $C1 , $BC , $87 , $F0 
 .byt $F , $C0 , $7F , 5 , $E0 , $25 , $EC , $C0 
 .byt $3E , $84 , $47 , $F0 , $8E , 3 , $F8 , 3 
;420
 .byt $FB , $C0 , $19 , $F8 , 7 , $9C ,$C , $17 
 .byt $F8 , 7 , $E0 , $1F , $A1 , $FC ,$F , $FC 
 .byt 1 , $F0 , $3F , 0 , $FE , 3 , $F0 , $1F 
 .byt 0 , $FD , 0 , $FF , $88 ,$D , $F9 , 1 
;440
 .byt $FF , 0 , $70 , 7 , $C0 , $3E , $42 , $F3 
 .byt $D , $C4 , $7F , $80 , $FC , 7 , $F0 , $5E 
 .byt $C0 , $3F , 0 , $78 , $3F , $81 , $FF , 1 
 .byt $F8 , 1 , $C3 , $E8 ,$C , $E4 , $64 , $8F 
;460
 .byt $E4 ,$F , $F0 , 7 , $F0 , $C2 , $1F , 0 
 .byt $7F , $C0 , $6F , $80 , $7E , 3 , $F8 , 7 
 .byt $F0 , $3F , $C0 , $78 ,$F , $82 , 7 , $FE 
 .byt $22 , $77 , $70 , 2 , $76 , 3 , $FE , 0 
;480
 .byt $FE , $67 , 0 , $7C , $C7 , $F1 , $8E , $C6 
 .byt $3B , $E0 , $3F , $84 , $F3 , $19 , $D8 , 3 
 .byt $99 , $FC , 9 , $B8 ,$F , $F8 , 0 , $9D 
 .byt $24 , $61 , $F9 ,$D , 0 , $FD , 3 , $F0 
;4a0
 .byt $1F , $90 , $3F , 1 , $F8 , $1F , $D0 ,$F 
 .byt $F8 , $37 , 1 , $F8 , 7 , $F0 ,$F , $C0 
 .byt $3F , 0 , $FE , 3 , $F8 ,$F , $C0 , $3F 
 .byt 0 , $FA , 3 , $F0 ,$F , $80 , $FF , 1 
;4c0
 .byt $B8 , 7 , $F0 , 1 , $FC , 1 , $BC , $80 
 .byt $13 , $1E , 0 , $7F , $E1 , $40 , $7F , $A0 
 .byt $7F , $B0 , 0 , $3F , $C0 , $1F , $C0 , $38 
 .byt $F , $F0 , $1F , $80 , $FF , 1 , $FC , 3 
;4e0
 .byt $F1 , $7E , 1 , $FE , 1 , $F0 , $FF , 0 
 .byt $7F , $C0 , $1D , 7 , $F0 ,$F , $C0 , $7E 
 .byt 6 , $E0 , 7 , $E0 ,$F , $F8 , 6 , $C1 
 .byt $FE , 1 , $FC , 3 , $E0 ,$F , 0 , $FC 
; };

;	Ind  | phoneme |  flags   |
;	-----|---------|----------|
;	0    |   *     | 00000000 |
;	1    |  .*     | 00000000 |
;	2    |  ?*     | 00000000 |
;	3    |  ,*     | 00000000 |
;	4    |  -*     | 00000000 |
;	
;	VOWELS
;	5    |  IY     | 10100100 |
;	6    |  IH     | 10100100 |
;	7    |  EH     | 10100100 |
;	8    |  AE     | 10100100 |
;	9    |  AA     | 10100100 |
;	10   |  AH     | 10100100 |
;	11   |  AO     | 10000100 |
;	17   |  OH     | 10000100 |
;	12   |  UH     | 10000100 |
;	16   |  UX     | 10000100 |
;	15   |  ER     | 10000100 |
;	13   |  AX     | 10100100 |
;	14   |  IX     | 10100100 |
;	
;	DIPTHONGS
;	48   |  EY     | 10110100 |
;	49   |  AY     | 10110100 |
;	50   |  OY     | 10110100 |
;	51   |  AW     | 10010100 |
;	52   |  OW     | 10010100 |
;	53   |  UW     | 10010100 |
;	
;	21   |  YX     | 10000100 |
;	20   |  WX     | 10000100 |
;	18   |  RX     | 10000100 |
;	19   |  LX     | 10000100 |
;	37   |  /X     | 01000000 |
;	30   |  DX     | 01001000 |
;	
;	22   |  WH     | 01000100 |
;	
;	VOICED CONSONANTS
;	23   |  R*     | 01000100 |
;	24   |  L*     | 01000100 |
;	25   |  W*     | 01000100 |
;	26   |  Y*     | 01000100 |
;	27   |  M*     | 01001100 |
;	28   |  N*     | 01001100 |
;	29   |  NX     | 01001100 |
;	54   |  B*     | 01001110 |
;	57   |  D*     | 01001110 |
;	60   |  G*     | 01001110 |
;	44   |  J*     | 01001100 |
;	38   |  Z*     | 01000100 |
;	39   |  ZH     | 01000100 |
;	40   |  V*     | 01000100 |
;	41   |  DH     | 01000100 |
;	
;	unvoiced CONSONANTS
;	32   |  S*     | 01000000 |
;	33   |  SH     | 01000000 |
;	34   |  F*     | 01000000 |
;	35   |  TH     | 01000000 |
;	66   |  P*     | 01001011 |
;	69   |  T*     | 01001011 |
;	72   |  K*     | 01001011 |
;	42   |  CH     | 01001000 |
;	36   |  /H     | 01000000 |
;	
;	43   |  **     | 01000000 |
;	45   |  **     | 01000100 |
;	46   |  **     | 00000000 |
;	47   |  **     | 00000000 |
;	
;	55   |  **     | 01001110 |
;	56   |  **     | 01001110 |
;	58   |  **     | 01001110 |
;	59   |  **     | 01001110 |
;	61   |  **     | 01001110 |
;	62   |  **     | 01001110 |
;	63   |  GX     | 01001110 |
;	64   |  **     | 01001110 |
;	65   |  **     | 01001110 |
;	67   |  **     | 01001011 |
;	68   |  **     | 01001011 |
;	70   |  **     | 01001011 |
;	71   |  **     | 01001011 |
;	73   |  **     | 01001011 |
;	74   |  **     | 01001011 |
;	75   |  KX     | 01001011 |
;	76   |  **     | 01001011 |
;	77   |  **     | 01001011 |
;	
;	SPECIAL
;	78   |  UL     | 10000000 |
;	79   |  UM     | 11000001 |
;	80   |  UN     | 11000001 |
;	31   |  Q*     | 01001100 |
;	

;         Konnte jetzt einige Tabellen und Variablen zuordnen.
;         Hier ist mal eine Liste aller intern genutzten Laute.
;        
;         Ind | phoneme |  flags   |
;         ----|---------|----------|
;         0   |   *     | 00000000 |
;         1   |  .*     | 00000000 |
;         2   |  ?*     | 00000000 |
;         3   |  ,*     | 00000000 |
;         4   |  -*     | 00000000 |
;         5   |  IY     | 10100100 |
;         6   |  IH     | 10100100 |
;         7   |  EH     | 10100100 |
;         8   |  AE     | 10100100 |
;         9   |  AA     | 10100100 |
;         10   |  AH     | 10100100 |
;         11   |  AO     | 10000100 |
;         12   |  UH     | 10000100 |
;         13   |  AX     | 10100100 |
;         14   |  IX     | 10100100 |
;         15   |  ER     | 10000100 |
;         16   |  UX     | 10000100 |
;         17   |  OH     | 10000100 |
;         18   |  RX     | 10000100 |
;         19   |  LX     | 10000100 |
;         20   |  WX     | 10000100 |
;         21   |  YX     | 10000100 |
;         22   |  WH     | 01000100 |
;         23   |  R*     | 01000100 |
;         24   |  L*     | 01000100 |
;         25   |  W*     | 01000100 |
;         26   |  Y*     | 01000100 |
;         27   |  M*     | 01001100 |
;         28   |  N*     | 01001100 |
;         29   |  NX     | 01001100 |
;         30   |  DX     | 01001000 |
;         31   |  Q*     | 01001100 |
;         32   |  S*     | 01000000 |
;         33   |  SH     | 01000000 |
;         34   |  F*     | 01000000 |
;         35   |  TH     | 01000000 |
;         36   |  /H     | 01000000 |
;         37   |  /X     | 01000000 |
;         38   |  Z*     | 01000100 |
;         39   |  ZH     | 01000100 |
;         40   |  V*     | 01000100 |
;         41   |  DH     | 01000100 |
;         42   |  CH     | 01001000 |
;         43   |  **     | 01000000 |
;         44   |  J*     | 01001100 |
;         45   |  **     | 01000100 |
;         46   |  **     | 00000000 |
;         47   |  **     | 00000000 |
;         48   |  EY     | 10110100 |
;         49   |  AY     | 10110100 |
;         50   |  OY     | 10110100 |
;         51   |  AW     | 10010100 |
;         52   |  OW     | 10010100 |
;         53   |  UW     | 10010100 |
;         54   |  B*     | 01001110 |
;         55   |  **     | 01001110 |
;         56   |  **     | 01001110 |
;         57   |  D*     | 01001110 |
;         58   |  **     | 01001110 |
;         59   |  **     | 01001110 |
;         60   |  G*     | 01001110 |
;         61   |  **     | 01001110 |
;         62   |  **     | 01001110 |
;         63   |  GX     | 01001110 |
;         64   |  **     | 01001110 |
;         65   |  **     | 01001110 |
;         66   |  P*     | 01001011 |
;         67   |  **     | 01001011 |
;         68   |  **     | 01001011 |
;         69   |  T*     | 01001011 |
;         70   |  **     | 01001011 |
;         71   |  **     | 01001011 |
;         72   |  K*     | 01001011 |
;         73   |  **     | 01001011 |
;         74   |  **     | 01001011 |
;         75   |  KX     | 01001011 |
;         76   |  **     | 01001011 |
;         77   |  **     | 01001011 |
;         78   |  UL     | 10000000 |
;         79   |  UM     | 11000001 |
;         80   |  UN     | 11000001 |

;         Im wesentlichen werden bis vor der Soundausgabe 3 Tabellen
;         bearbeitet.
;         unsigned char phonemeindex[256];
;         unsigned char stress[256]; //numbers from 0 to 8
;         unsigned char phonemeLength[256]; //tab40160 9ce0
;        
;         phonemeindex ist der link auf obige Tabelle.
;         Nun wird ewig damit herumhantiert; hinzugefќgt und Werte gesetzt
;         abhфngig von dem Flagfeld und von anderen Bedingungen.
;        
;         Die endgќltige Tabellen kann man sich mit dem Befehl -debug mit meinem
;         Programm ansehen.
;        
;         Abфngig von den Lauten werden nun Frequenzen und Amplituden aus Tabellen
;         entnommen und bis auf ein paar Ausnahmen auch so ausgegeben.
;         Wie die Ausnahmen genau behandelt werden weiss ich noch nicht.

loc_A440                                  
loc_A446                                  
locret_A46E                               
loc_BCC1                                  
loc_BCC7                                  
loc_BCD1                                  
loc_BCD7                                  
soundout3
sam.s(2107):  1216:Label defined error    
loc_BC92                                  
sam.s(2112):  1219:Label defined error    
loc_BC98                                  
sam.s(2122):  1220:Label defined error    
loc_BCA2                                  
sam.s(2142):  122e:Label defined error    
loc_BCA8                                  
sam.s(2158):  1233:Label defined error    
unknown_param1=loc_BCA8+1                 
sam.s(2184):  1246:Label defined error    
.endif                                    
sam.s(2185):  1246:Syntax error           
sam.s(37):  0804:Label 'zp_11' not defined
sam.s(38):  0807:Label 'zp_12' not defined
                                          