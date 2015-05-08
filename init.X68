*-------------------------------------------------------------------------------
* Subroutine to Initialise Newton and the Apple
*-------------------------------------------------------------------------------
    
Sub_Init_Game
    
    ;newton's initial position is in the middle of the screen
    ;calculate left X
    lea BM_NEWTON_START_X, a0
    move.l BM_BACK_WIDTH,d1
    lsr.l #1,d1
    
    move.l BM_NEWTON_WIDTH,d2
    lsr.l #1,d2
    sub.l d2,d1
    
    ;position is the same left X coordinate in flosting point
    move.l d1,(a0)
    asl.l #8,d1
    asl.l #4,d1
    move.l d1,NEWTON_POSITION
    
    ;calculate right X
    move.l BM_NEWTON_WIDTH,d3
    add.l (a0),d3
    move.l d3,NEWTON_RIGHT_X
             
    ;calculate top Y
    lea BM_NEWTON_START_Y, a0
    move.l BM_BACK_HEIGHT,d1
    move.l BM_NEWTON_HEIGHT,d2
    sub.l d2,d1
    move.l d1,(a0)
    
    ;calculate bottom Y
    move.l BM_NEWTON_HEIGHT,d3
    add.l (a0),d3
    move.l d3, NEWTON_BOTTOM_Y
    
    move.l #3,KEY_PRESSED
    
    move.l #APPLE_INACTIVE,IS_APPLE_ACTIVE
    
    jsr Sub_Init_Rand
    
    jsr Sub_Generate_Random_Apple

    move.l BM_APPLE_START_Y,APPLE_INVAL_START_Y
    move.l BM_APPLE_BOTTOM_Y,APPLE_INVAL_BOTTOM_Y
    
    move.l #NEWTON_UPDATED,WAS_NEWTON_UPDATED
    
    rts




*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
