
ALL_REGS        reg d0-d7/a0-a6

FRAC_BITS       equ 12

;Game mode
MODE_HOOKE      equ 1
MODE_NEWTON     equ 2
GAME_MODE       dc.l 0

DECENT_SCORE_HOOKE  equ 60
DECENT_SCORE_NEWTON equ 20
MAX_LIVES           equ 10

BM_BACKGROUND_FILE      incbin "assets\BackEd1.bmp"
BM_BACK_WIDTH           ds.l    1
BM_BACK_HEIGHT          ds.l    1
BM_BACK_ARRAY_START     ds.l    1
BM_BACK_START_X         dc.l    0
BM_BACK_START_Y         dc.l    0

NO_KEY_PRESSED          equ 0
RIGHT_KEY_PRESSED       equ 1
LEFT_KEY_PRESSED        equ 2
KEY_PRESSED             dc.l NO_KEY_PRESSED

OLD_TIME            ds.l    1
DELTA_TIME          dc.l    0

LARGE_NUMBER        equ     $5678
RANDOMVAL           ds.l    1
TEMPRANDOMLONG      ds.l    1

KEY_LEFT_CODE       equ $25
KEY_RIGHT_CODE      equ $27
KEY_1_CODE          equ $31
KEY_2_CODE          equ $32
KEY_SPACE_CODE      equ $20 

MENU_INPUT          equ $00310032
GAME_INPUT          equ $00250027

NEWTON_BGM          dc.b 'sound\sunshine in capris mark salona.wav',0
HOOKE_BGM           dc.b 'sound\einaudi-nightbook.wav',0

EXTRA_LONG          dc.l 1





















*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
