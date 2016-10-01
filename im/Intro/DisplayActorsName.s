;DisplayActorsName.s

DisplayActorsName
	;Actors name will appear to the side
	ldx ActorID
	lda FirstNameStartX,x
	sta Object_X
	lda FirstNameStartY,x
	sta Object_Y
	lda ActorsNameAddressLo,x
	sta text
	lda ActorsNameAddressHi,x
	sta text+1
	ldy #00
	jsr DisplayName
	lda SurNameStartX,x
	sta Object_X
	lda SurNameStartY,x
	sta Object_Y
DisplayName
	dec Object_X
	lda #YELLOWCOLUMN
	sta Object_V
	jsr PlotObject
	inc Object_X
.(
loop1	lda (text),y
	bmi skip1
	sta Object_V
	jsr PlotObject
	inc Object_X
	inc Object_X
	iny
	jmp loop1
skip1	iny
.)
	rts
	
	
FirstNameStartX
 .byt 28	;PeterLupus
 .byt 25	;MartinLandau
 .byt 26	;LeonardNimoy
 .byt 30	;GregMorris
 .byt 18	;BarbaraBain
 .byt 27	;PeterGraves
FirstNameStartY
 .byt 120	;PeterLupus
 .byt 132	;MartinLandau
 .byt 36	;LeonardNimoy
 .byt 120	;GregMorris
 .byt 6	;BarbaraBain
 .byt 144	;PeterGraves
SurNameStartX
 .byt 29	;PeterLupus
 .byt 26	;MartinLandau
 .byt 30	;LeonardNimoy
 .byt 28	;GregMorris
 .byt 26	;BarbaraBain
 .byt 28	;PeterGraves
SurNameStartY
 .byt 137	;PeterLupus
 .byt 150	;MartinLandau
 .byt 55	;LeonardNimoy
 .byt 139	;GregMorris
 .byt 24	;BarbaraBain
 .byt 161	;PeterGraves

ActorsNameAddressLo
 .byt <Text_PeterLupus	;h_mipl
 .byt <Text_MartinLandau	;h_miml
 .byt <Text_LeonardNimoy	;h_miln
 .byt <Text_GregMorris	;h_migm
 .byt <Text_BarbaraBain	;h_mibb
 .byt <Text_PeterGraves	;h_mipg
ActorsNameAddressHi
 .byt >Text_PeterLupus	;h_mipl
 .byt >Text_MartinLandau	;h_miml
 .byt >Text_LeonardNimoy	;h_miln
 .byt >Text_GregMorris	;h_migm
 .byt >Text_BarbaraBain	;h_mibb
 .byt >Text_PeterGraves	;h_mipg

Text_MartinLandau	;h_miml
 .byt LETTER_M
 .byt LETTER_A
 .byt LETTER_R
 .byt LETTER_T
 .byt LETTER_I
 .byt LETTER_N
 .byt 128

 .byt LETTER_L
 .byt LETTER_A
 .byt LETTER_N
 .byt LETTER_D
 .byt LETTER_A
 .byt LETTER_U
 .byt 128
Text_PeterGraves	;h_mipg
 .byt LETTER_P
 .byt LETTER_E
 .byt LETTER_T
 .byt LETTER_E
 .byt LETTER_R
 .byt 128
 .byt LETTER_G
 .byt LETTER_R
 .byt LETTER_A
 .byt LETTER_V
 .byt LETTER_E
 .byt LETTER_S
 .byt 128
Text_LeonardNimoy	;h_miln
 .byt LETTER_L
 .byt LETTER_E
 .byt LETTER_O
 .byt LETTER_N
 .byt LETTER_A
 .byt LETTER_R
 .byt LETTER_D
 .byt 128
 .byt LETTER_N
 .byt LETTER_I
 .byt LETTER_M
 .byt LETTER_O
 .byt LETTER_Y
 .byt 128
Text_GregMorris	;h_migm
 .byt LETTER_G
 .byt LETTER_R
 .byt LETTER_E
 .byt LETTER_G
 .byt 128
 .byt LETTER_M
 .byt LETTER_O
 .byt LETTER_R
 .byt LETTER_R
 .byt LETTER_I
 .byt LETTER_S
 .byt 128
Text_BarbaraBain	;h_mibb
 .byt LETTER_B
 .byt LETTER_A
 .byt LETTER_R
 .byt LETTER_B
 .byt LETTER_A
 .byt LETTER_R
 .byt LETTER_A
 .byt 128
 .byt LETTER_B
 .byt LETTER_A
 .byt LETTER_I
 .byt LETTER_N
 .byt 128
Text_PeterLupus	;h_mipl
 .byt LETTER_P
 .byt LETTER_E
 .byt LETTER_T
 .byt LETTER_E
 .byt LETTER_R
 .byt 128
 .byt LETTER_L
 .byt LETTER_U
 .byt LETTER_P
 .byt LETTER_U
 .byt LETTER_S
 .byt 128
