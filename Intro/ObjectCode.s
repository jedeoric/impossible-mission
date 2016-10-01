;ObjectCode.s

;Object_X
;Object_Y
;Object_V
PlotObject
	stx ObjTempX
	sty ObjTempY
	sta ObjTempA
	
	;Calculate Screen location
	lda Object_X
	ldy Object_Y
	jsr RecalcScreen
	
	;Fetch Objects source address
	ldy Object_V
	lda Object_SourceLo,y
	sta source
	lda Object_SourceHi,y
	sta source+1
	
	;Fetch dimensions
	ldx Object_Height,y
	
	lda Object_Width,y
	sta ObjTempWidth
.(	
loop2	ldy ObjTempWidth
	dey
	
loop1	lda (source),y
	sta (screen),y
	dey
	bpl loop1
	
	lda ObjTempWidth
	jsr AddSource
	jsr nl_screen
	dex
	bne loop2
.)
	ldx ObjTempX
	ldy ObjTempY
	lda ObjTempA
	rts


;A == X(0-39)
;Y == Y(0-137)
RecalcScreen
	;(Yx40)+X+$A000
	sta TempRX
	lda #00
	sta screen+1
	tya
	
	;Yx8
	asl
	rol screen+1
	asl
	rol screen+1
	asl
	rol screen+1
	sta TempLo
	ldy screen+1
	
	;Yx32
	asl
	rol screen+1
	asl
	rol screen+1
	
	;Yx8 + Yx32
	adc TempLo
	sta screen
	tya
	adc screen+1
	tay
	
	;+X
	lda screen
	adc TempRX
	sta screen
	
	;+$A000
	tya
	adc #$A0
	sta screen+1
	rts

AddSource
	clc
	adc source
	sta source
	lda source+1
	adc #00
	sta source+1
	rts

nl_screen
	lda screen
	clc
	adc #40
	sta screen
	lda screen+1
	adc #00
	sta screen+1
	rts
