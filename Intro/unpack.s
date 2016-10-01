PackedDataAddressLo
 .byt <h_mipl	;00
 .byt <h_miml       ;01
 .byt <h_miln       ;02
 .byt <h_migm       ;03
 .byt <h_mibb       ;04
 .byt <h_mipg       ;05
                    
 .byt <h_mit00      ;06
 .byt <h_mit01      ;07
 .byt <h_mit02      ;08
 .byt <h_mit03      ;09
 .byt <h_mit04      ;10
 .byt <h_mit05      ;11
 .byt <h_mit06      ;12
 .byt <h_mit07      ;13
 .byt <h_mit08      ;14
 .byt <h_mit09      ;15
 .byt <h_mit10      ;16
 .byt <h_mit11      ;17
 .byt <h_mit12      ;18
                    
 .byt <h_mit12      ;19
 .byt <h_mit12      ;20
 .byt <h_mit12      ;21
 .byt <h_mit12      ;22
 .byt <h_mit12      ;23

PackedDataAddressHi
 .byt >h_mipl
 .byt >h_miml
 .byt >h_miln
 .byt >h_migm
 .byt >h_mibb
 .byt >h_mipg
 .byt >h_mit00
 .byt >h_mit01
 .byt >h_mit02
 .byt >h_mit03
 .byt >h_mit04
 .byt >h_mit05
 .byt >h_mit06
 .byt >h_mit07
 .byt >h_mit08
 .byt >h_mit09
 .byt >h_mit10
 .byt >h_mit11
 .byt >h_mit12

 .byt >h_mit12
 .byt >h_mit12
 .byt >h_mit12
 .byt >h_mit12
 .byt >h_mit12

PackedDataStartDestinationLo
 .byt <$A028	;h_mipl
 .byt <$A000	;h_miml
 .byt <$A000	;h_miln
 .byt <$A4D8	;h_migm
 .byt <$A190	;h_mibb
 .byt <$A1B8	;h_mipg
 .byt <$A000	;h_mit00
 .byt <$A000	;h_mit01
 .byt <$A078	;h_mit02
 .byt <$A2D0	;h_mit03
 .byt <$A6B8	;h_mit04
 .byt <$AA50	;h_mit05
 .byt <$AAC8	;h_mit06
 .byt <$AAA0	;h_mit07
 .byt <$AAA0	;h_mit08
 .byt <$AAA0	;h_mit09
 .byt <$AAA0	;h_mit10
 .byt <$AAA0	;h_mit11
 .byt <$AAA0	;h_mit12

 .byt <$A000+51*40	;h_mit12
 .byt <$A000+39*40	;h_mit12
 .byt <$A000+27*40	;h_mit12
 .byt <$A000+15*40	;h_mit12
 .byt <$A000+3*40	;h_mit12
PackedDataStartDestinationHi
 .byt >$A028	;h_mipl
 .byt >$A000	;h_miml
 .byt >$A000	;h_miln
 .byt >$A4D8	;h_migm
 .byt >$A190	;h_mibb
 .byt >$A1B8	;h_mipg
 .byt >$A000	;h_mit00
 .byt >$A000	;h_mit01
 .byt >$A078	;h_mit02
 .byt >$A2D0	;h_mit03
 .byt >$A6B8	;h_mit04
 .byt >$AA50	;h_mit05
 .byt >$AAC8	;h_mit06
 .byt >$AAA0	;h_mit07
 .byt >$AAA0	;h_mit08
 .byt >$AAA0	;h_mit09
 .byt >$AAA0	;h_mit10
 .byt >$AAA0	;h_mit11
 .byt >$AAA0	;h_mit12

 .byt >$A000+51*40	;h_mit12
 .byt >$A000+39*40	;h_mit12
 .byt >$A000+27*40	;h_mit12
 .byt >$A000+15*40	;h_mit12
 .byt >$A000+3*40	;h_mit12
PackedDataEndDestinationLo
 .byt <$A028+$1bf8-1	;h_mipl
 .byt <$A000+$1ab8-1	;h_miml
 .byt <$A000+$1a40-1	;h_miln
 .byt <$A4D8+$14f0-1	;h_migm
 .byt <$A190+$1a90-1	;h_mibb
 .byt <$A1B8+$1a68-1	;h_mipg
 .byt <$A000+$1c20-1	;h_mit00
 .byt <$A000+$1c20-1	;h_mit01
 .byt <$A078+$1ba8-1	;h_mit02
 .byt <$A2D0+$15e0-1	;h_mit03
 .byt <$A6B8+$e60-1		;h_mit04
 .byt <$AA50+$640-1		;h_mit05
 .byt <$AAC8+$eb0-1		;h_mit06
 .byt <$AAA0+$ed8-1		;h_mit07
 .byt <$AAA0+$eb0-1		;h_mit08
 .byt <$AAA0+$e88-1		;h_mit09
 .byt <$AAA0+$ed8-1		;h_mit10
 .byt <$AAA0+$ed8-1		;h_mit11
 .byt <$AAA0+$ed8-1		;h_mit12

 .byt <$A7F8+$ed8-1		;h_mit12
 .byt <$A618+$ed8-1		;h_mit12
 .byt <$A438+$ed8-1		;h_mit12
 .byt <$A258+$ed8-1		;h_mit12
 .byt <$A078+$ed8-1		;h_mit12
PackedDataEndDestinationHi
 .byt >$A028+$1bf8-1	;h_mipl
 .byt >$A000+$1ab8-1	;h_miml
 .byt >$A000+$1a40-1	;h_miln
 .byt >$A4D8+$14f0-1	;h_migm
 .byt >$A190+$1a90-1	;h_mibb
 .byt >$A1B8+$1a68-1	;h_mipg
 .byt >$A000+$1c20-1	;h_mit00
 .byt >$A000+$1c20-1	;h_mit01
 .byt >$A078+$1ba8-1	;h_mit02
 .byt >$A2D0+$15e0-1	;h_mit03
 .byt >$A6B8+$e60-1		;h_mit04
 .byt >$AA50+$640-1		;h_mit05
 .byt >$AAC8+$eb0-1		;h_mit06
 .byt >$AAA0+$ed8-1		;h_mit07
 .byt >$AAA0+$eb0-1		;h_mit08
 .byt >$AAA0+$e88-1		;h_mit09
 .byt >$AAA0+$ed8-1		;h_mit10
 .byt >$AAA0+$ed8-1		;h_mit11
 .byt >$AAA0+$ed8-1		;h_mit12

 .byt >$A7F8+$ed8-1		;h_mit12
 .byt >$A618+$ed8-1		;h_mit12
 .byt >$A438+$ed8-1		;h_mit12
 .byt >$A258+$ed8-1		;h_mit12
 .byt >$A078+$ed8-1		;h_mit12

UnpackData
	lda PackedDataAddressLo,x
	sta ptr_source
	lda PackedDataAddressHi,x
	sta ptr_source+1
	
	lda PackedDataStartDestinationLo,x
	sta ptr_destination
	lda PackedDataStartDestinationHi,x
	sta ptr_destination+1
	
	lda PackedDataEndDestinationLo,x
	sta ptr_destination_end
	lda PackedDataEndDestinationHi,x
	sta ptr_destination_end+1
	
	jmp _file_unpack



; void file_unpack(void *ptr_dst,void *ptr_src)

_file_unpack
.(
	; Initialise variables
	; We try to keep "y" null during all the code,
	; so the block copy routine has to be sure that
	; y is null on exit
	ldy #0
	lda #1
	sta mask_value
	 
unpack_loop
	; Handle bit mask
	lsr mask_value
	bne end_reload_mask

	; Read from source stream
	lda (ptr_source),y 		

	.(
	; Move stream pointer (one byte)
	inc ptr_source  		
	bne skip
	inc ptr_source+1
skip
	.)
	ror 
	sta mask_value   
end_reload_mask
	bcc back_copy

write_byte
	; Copy one byte from the source stream
	lda (ptr_source),y
	sta (ptr_destination),y

	.(
	; Move stream pointer (one byte)
	inc ptr_source
	bne skip
	inc ptr_source+1
skip
	.)

	lda #1
	sta nb_dst



_UnpackEndLoop
	;// We increase the current destination pointer,
	;// by a given value, white checking if we reach
	;// the end of the buffer.
	clc
	lda ptr_destination
	adc nb_dst
	sta ptr_destination

	.(
	bcc skip
	inc ptr_destination+1
skip
	.)
	cmp ptr_destination_end
	lda ptr_destination+1
	sbc ptr_destination_end+1
	bcc unpack_loop  
	rts
	

back_copy
	;BreakPoint jmp BreakPoint	
	; Copy a number of bytes from the already unpacked stream
	; Here we know that y is null. So no need for clearing it.
	; Just be sure it's still null at the end.
	; At this point, the source pointer points to a two byte
	; value that actually contains a 4 bits counter, and a 
	; 12 bit offset to point back into the depacked stream.
	; The counter is in the 4 high order bits.
	;clc  <== No need, since we access this routie from a BCC
	lda (ptr_source),y
	adc #1
	sta offset
	iny
	lda (ptr_source),y
	tax
	and #$0f
	adc #0
	sta offset+1

	txa
	lsr
	lsr
	lsr
	lsr
	clc
	adc #3
	sta nb_dst

	sec
	lda ptr_destination
	sbc offset
	sta ptr_source_back
	lda ptr_destination+1
	sbc offset+1
	sta ptr_source_back+1

	; Beware, in that loop, the direction is important
	; since RLE like depacking is done by recopying the
	; very same byte just copied... Do not make it a 
	; reverse loop to achieve some speed gain...
	; Y was equal to 1 after the offset computation,
	; a simple decrement is ok to make it null again.
	dey
	.(
copy_loop
	lda (ptr_source_back),y	; Read from already unpacked stream
	sta (ptr_destination),y	; Write to destination buffer
	iny
	cpy nb_dst
	bne copy_loop
	.)
	ldy #0

	;// C=1 here
	lda ptr_source
	adc #1
	sta ptr_source
	bcc _UnpackEndLoop
	inc ptr_source+1
	bne _UnpackEndLoop
	rts
.)


; Taille actuelle du code 279 octets
; 0x08d7 - 0x07e8 => 239 octets
; 0x08c8 - 0x07e5 => 227 octets
; 0x08d5 - 0x0800 => 213 octets
; 0x08c9 - 0x0800 => 201 octets
; 0x08c5 - 0x0800 => 197 octets
; 0x08c3 - 0x0800 => 195 octets
; 0x08c0 - 0x0800 => 192 octets
; => 146 octets
