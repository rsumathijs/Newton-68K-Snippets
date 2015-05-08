*-------------------------------------------------------------------------------
* Subroutine to update score and loves based on the game mode
* In Newton mode,
* an apple hit is counted as score and as a miss is counted as life loss
* In Hooke mode,
* an apple hit is counted as life loss and a miss is counted as score
*-------------------------------------------------------------------------------

Sub_Update_Score_And_Lives
    cmpi.l #APPLE_INACTIVE,IS_APPLE_ACTIVE
    bne END_SCORE_UPDATE
    
    cmpi.l #MODE_HOOKE,GAME_MODE
    bne CHECK_FOR_NEWTON
    
    cmpi.l #APPLE_HIT,IS_APPLE_HIT
    bne HOOKE_NO_HIT
    
    subq.w #1,LIVES
    bra END_SCORE_UPDATE    
HOOKE_NO_HIT
    
    addq.w #1,SCORE
    bra END_SCORE_UPDATE
CHECK_FOR_NEWTON    
    
    cmpi.l #APPLE_HIT,IS_APPLE_HIT
    bne NEWTON_NO_HIT
    
    addq.w #1,SCORE
    bra END_SCORE_UPDATE    
NEWTON_NO_HIT
    
    subq.w #1,LIVES
    bra END_SCORE_UPDATE
END_SCORE_UPDATE
    rts

*-------------------------------------------------------------------------------
* Subroutine to draw the score and lives as 7 segment LED
*-------------------------------------------------------------------------------
Sub_Draw_Score_And_Lives
    ;revert from background or draw color mode
    move.b #DRAW_DEFAULT_CODE,d1
    move.b #SET_DRAWING_MODE_COMMAND,d0
    trap #15
    
    ;to invalidate the score : set background color as pen color
    move.l #SCORE_CLEAR_COLOR,d1
    move.b #SET_PEN_COLOR_COMMAND,d0
    trap #15
    
    ;erase the score
    move.w #SCORE_CLEAR_VALUE,TEMP_SCORE
    move.w #SCORE_START_X,TEMP_START_X
    move.w #SCORE_START_Y,TEMP_START_Y
    jsr Sub_Draw_LED
    
    ;erase the lives
    move.w #LIVES_CLEAR_VALUE,TEMP_SCORE
    move.w #LIVES_START_X,TEMP_START_X
    move.w #LIVES_START_Y,TEMP_START_Y
    jsr Sub_Draw_LED

    ;draw score
    moveq.l #0,d0
    moveq.l #0,d1
    move.l #SCORE_VALUE_COLOR,d1
    move.b #SET_PEN_COLOR_COMMAND,d0
    trap #15
    
    ;draw score
    move.w SCORE,TEMP_SCORE
    move.w #SCORE_START_X,TEMP_START_X
    move.w #SCORE_START_Y,TEMP_START_Y
    jsr Sub_Draw_LED
    
    ;draw lives
    move.w LIVES,TEMP_SCORE
    move.w #LIVES_START_X,TEMP_START_X
    move.w #LIVES_START_Y,TEMP_START_Y
    jsr Sub_Draw_LED
    
    rts
    
    
Sub_Draw_LED
    move.l #SCORE_VALUE_PEN_WIDTH,d1
    move.b #SET_PEN_WIDTH_COMMAND,d0
    trap #15
    
    lea LED_Value_Table,a0
    lea LED_Mask_Table,a1
    lea LED_Positions_Table,a2
        
DRAW_LED
    move.w  TEMP_SCORE,d0
    
    ;get last digit
    divu.w #10,d0
    move.w d0,TEMP_SCORE
    swap.w d0
    move.w d0,d7 ;digit is in D7
    
    move.b  #0,d6 ;loop counter
   
DRAW_SEGMENT_LOOP
    move.b (a0,d7),d3 ;value     
    move.b (a1,d6),d4 ;mask
    
    and.b   d3,d4
    beq DONT_DRAW_SEGMENT
    
    move.l d6,d5
    mulu.w  #8,d5
    
    move.w  0(a2,d5),d1
    add.w  TEMP_START_X,d1
    move.w  2(a2,d5),d2
    add.w   TEMP_START_Y,d2
    move.w  4(a2,d5),d3
    add.w  TEMP_START_X,d3
    move.w  6(a2,d5),d4
    add.w   TEMP_START_Y,d4
    
    move.b #DRAW_LINE_COMMAND,d0
    trap #15    
    
DONT_DRAW_SEGMENT
    add.b #1,d6
    cmpi.b #7,d6
    blt DRAW_SEGMENT_LOOP

    moveq.l #0,d0
    move.w TEMP_START_X,d0
    sub.w #DIGIT_GAP,d0
    sub.w #DIGIT_X_LEN,d0
    move.w d0,TEMP_START_X
    
    cmpi #0,TEMP_SCORE
    bne DRAW_LED
    rts
    



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
