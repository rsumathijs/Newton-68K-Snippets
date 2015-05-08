BM_APPLE_FILE          incbin "assets\apple.bmp"
BM_APPLE_WIDTH         ds.l    1
BM_APPLE_HEIGHT        ds.l    1
BM_APPLE_ARRAY_START   ds.l    1

BM_APPLE_START_X       ds.l    1
BM_APPLE_START_Y       ds.l    1
BM_APPLE_RIGHT_X       ds.l 1
BM_APPLE_BOTTOM_Y      ds.l 1

; Range of valid apple positions on screen
APPLE_XPOS_START    equ 20
APPLE_XPOS_END      equ 750
APPLE_YPOS_START    equ 150
APPLE_YPOS_END      equ 350

APPLE_XRANGE        equ APPLE_XPOS_END-APPLE_XPOS_START
APPLE_YRANGE        equ APPLE_YPOS_END-APPLE_YPOS_START

; Old apple values
APPLE_INVAL_START_X     dc.l 0
APPLE_INVAL_START_Y     dc.l 0
APPLE_INVAL_BOTTOM_Y    dc.l 0

GRAVITY                 equ 6<<FRAC_BITS   

APPLE_INITIAL_VELOCITY  dc.l 5<<FRAC_BITS
APPLE_FINAL_VELOCITY    ds.l 1
APPLE_DISTANCE          dc.l 0<<FRAC_BITS

;to store if the apple is off screen or needs to be regenerated
IS_APPLE_ACTIVE         ds.l 1
APPLE_ACTIVE            equ 1
APPLE_INACTIVE          equ 0

;to store if the apple has hit newton or not
IS_APPLE_HIT        ds.l 1
APPLE_HIT           equ 1
APPLE_MISS          equ 2

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
