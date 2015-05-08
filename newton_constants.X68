BM_NEWTON_FILE         incbin "assets\newton.bmp"
BM_NEWTON_WIDTH        ds.l    1
BM_NEWTON_HEIGHT       ds.l    1
BM_NEWTON_ARRAY_START  ds.l    1

BM_NEWTON_START_X         ds.l  1 
BM_NEWTON_START_Y         ds.l  1
NEWTON_RIGHT_X             ds.l 1
NEWTON_BOTTOM_Y             ds.l 1

NEWTON_INVAL_START_X    dc.l 0
NEWTON_INVAL_RIGHT_X    dc.l 0
NEWTON_INVAL_BOTTOM_Y   dc.l 0

NEWTON_STEP_OFFSET equ 20<<FRAC_BITS
NEWTON_POSITION dc.l 0

NEWTON_UPDATED equ 1
NEWTON_NOT_UPDATED equ 0
WAS_NEWTON_UPDATED  dc.l NEWTON_NOT_UPDATED

DONT_INVAL_NEWTON dc.l 1


*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
