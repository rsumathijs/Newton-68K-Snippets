SCORE           dc.w 0
LIVES           dc.w    MAX_LIVES

TEMP_SCORE      dc.w 0
TEMP_START_X    dc.w 0
TEMP_START_Y    dc.w 0

*background color - to invalidate the score
SCORE_CLEAR_COLOR   equ $00D9CF5C

;redraw 18 and 8888 to invalidate score
LIVES_CLEAR_VALUE   equ 18
SCORE_CLEAR_VALUE   equ 8888

HOTPINK             equ $B469FF
DEEPPINK            equ $9314FF

SCORE_VALUE_COLOR       equ DEEPPINK
SCORE_VALUE_PEN_WIDTH   equ 5

;length of the LED digit in pixels
DIGIT_X_LEN         equ 13
DIGIT_y_LEN         equ 13

;gap between each digit in pixels
DIGIT_GAP           equ 10

SCORE_START_X       equ 750
SCORE_START_Y       equ 10

LIVES_START_X       equ 220
LIVES_START_Y       equ 10

;LED truth table values for 0 to 9
LED_Value_Table     dc.b    126,24,55,61,89,109,111,56,127,125

;Mask values to get segment values
LED_Mask_Table      dc.b     $40,$20,$10,$8,$4,$2,$1

;Coordinates of the line for each segment
LED_Positions_Table dc.w   0,0,0,DIGIT_Y_LEN
                    dc.w   0,0,DIGIT_X_LEN,0
                    dc.w   DIGIT_X_LEN,0,DIGIT_X_LEN,DIGIT_Y_LEN
                    dc.w   DIGIT_X_LEN,DIGIT_Y_LEN,DIGIT_X_LEN,DIGIT_Y_LEN*2
                    dc.w   DIGIT_X_LEN,DIGIT_Y_LEN*2,0,DIGIT_Y_LEN*2
                    dc.w   0,DIGIT_Y_LEN*2,0,DIGIT_Y_LEN
                    dc.w   0,DIGIT_Y_LEN,DIGIT_X_LEN,DIGIT_Y_LEN



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
