*-------------------------------------------------------------------------------
* Subroutine to draw newton if he was updated
*-------------------------------------------------------------------------------

Sub_Draw_Newton
    ;check if newton was updated, else dont draw newton
    move.l WAS_NEWTON_UPDATED,d7
    cmpi.l #NEWTON_NOT_UPDATED,d7
    beq DONT_DRAW_NEWTON
    
    ;dont invalidate newton the first time
    cmpi.l #1, DONT_INVAL_NEWTON
    beq DRAW_NEWTON
    
    ;erase newton
    move.l NEWTON_INVAL_START_X,-(sp)
    move.l NEWTON_BOTTOM_Y,-(sp)
    move.l NEWTON_INVAL_RIGHT_X,-(sp)
    move.l BM_NEWTON_START_Y,-(sp)   

    move.l BM_BACK_START_X,-(sp)
    move.l BM_BACK_START_Y,-(sp)
    move.l BM_BACK_WIDTH,-(sp)
    move.l BM_BACK_HEIGHT,-(sp)  

    jsr Sub_Inval_Rect
     
    add.l #32,sp
    
DRAW_NEWTON
    move.l #0,DONT_INVAL_NEWTON
    
    ;draw newton
    movem.l ALL_REGS,-(sp)
    move.l BM_NEWTON_ARRAY_START,a0
    
    move.l BM_NEWTON_START_X,d6
    move.l BM_NEWTON_START_Y,d7
    
    move.l d6,d4 ;copy of start x
    
    move.l BM_NEWTON_WIDTH,d3
    add.l d6,d3 ; width +startx
    
    move.l BM_NEWTON_HEIGHT,d5
    subq.l #1,d5
    add.l d7,d5 ; bottom + starty
    
    jsr Sub_Draw_Image
    movem.l (sp)+,ALL_REGS
    
    move.l #NEWTON_NOT_UPDATED,WAS_NEWTON_UPDATED
    move.l #NO_KEY_PRESSED,KEY_PRESSED
DONT_DRAW_NEWTON
    rts
    
*-------------------------------------------------------------------------------
* Subroutine to check which key was pressed and handle it
*-------------------------------------------------------------------------------       
Sub_Update_Newton
    movem.l ALL_REGS,-(sp)
    
    move.l KEY_PRESSED,d7
    cmpi.l #RIGHT_KEY_PRESSED,d7
    bne LEFT_KEY_PRESS_CHECK
    
    jsr Sub_Move_Right
    move.l #NEWTON_UPDATED,WAS_NEWTON_UPDATED
    bra END_NEWTON_UPDATE
LEFT_KEY_PRESS_CHECK
   
    move.l KEY_PRESSED,d7
    cmpi.l #LEFT_KEY_PRESSED,d7
    bne NO_NEWTON_UPDATE
    
    jsr Sub_Move_Left
    move.l #NEWTON_UPDATED,WAS_NEWTON_UPDATED
    bra END_NEWTON_UPDATE

NO_NEWTON_UPDATE    
    move.l #NEWTON_NOT_UPDATED,WAS_NEWTON_UPDATED
END_NEWTON_UPDATE
    movem.l (sp)+,ALL_REGS
    rts

*-------------------------------------------------------------------------------
* Subroutine to move newton to the right and adjust his position if he goes out of screen
*-------------------------------------------------------------------------------

Sub_Move_Right

    ;update old location before update
    move.l BM_NEWTON_START_X,NEWTON_INVAL_START_X
    move.l NEWTON_RIGHT_X,NEWTON_INVAL_RIGHT_X
    move.l NEWTON_BOTTOM_Y,NEWTON_INVAL_BOTTOM_Y
    
    ;calculate new position
    move.l NEWTON_POSITION,d1
    move.l #NEWTON_STEP_OFFSET,d2
    add.l d2,d1
    move.l d1,NEWTON_POSITION
    
    ;update startx and right x
    lsr.l #8,d1
    lsr.l #4,d1 ;position in not fixed point
    
    move.l d1,BM_NEWTON_START_X
        
    add.l BM_NEWTON_WIDTH,d1
    move.l d1,NEWTON_RIGHT_X
    
    ;check limits
    cmp.l BM_BACK_WIDTH,d1
    blt RIGHT_LIMITS_FINE
    
    ;adjust startx and rightx if beyond screen
    move.l BM_BACK_WIDTH,d1
    move.l d1,NEWTON_RIGHT_X
    
    move.l BM_NEWTON_WIDTH,d2
    sub.l d2,d1
    
    move.l d1,BM_NEWTON_START_X
    
    ;adjust position
    lsl.l #8,d1
    lsl.l #4,d1
    move.l d1,NEWTON_POSITION
    
RIGHT_LIMITS_FINE
    rts

*-------------------------------------------------------------------------------
* Subroutine to move newton to the left and adjust his position if he goes out of screen
*-------------------------------------------------------------------------------

Sub_Move_Left
    ;update old values before update
    move.l BM_NEWTON_START_X,NEWTON_INVAL_START_X
    move.l NEWTON_RIGHT_X,NEWTON_INVAL_RIGHT_X
    move.l NEWTON_BOTTOM_Y,NEWTON_INVAL_BOTTOM_Y
    
    ;calculate new position
    move.l NEWTON_POSITION,d1
    move.l #NEWTON_STEP_OFFSET,d2
    sub.l d2,d1
    move.l d1,NEWTON_POSITION
    
    ;update startx and rightx
    lsr.l #8,d1
    lsr.l #4,d1 ;position in not fixed point
    
    move.l d1,BM_NEWTON_START_X
    
    add.l BM_NEWTON_WIDTH,d1
    move.l d1,NEWTON_RIGHT_X
    
    ;check limits
    move.l NEWTON_POSITION,d0
    cmpi.l #0,d0
    bpl LEFT_LIMITS_FINE
    
    ;adjust startx and rightx if beyond screen
    move.l #1,BM_NEWTON_START_X
    
    move.l BM_NEWTON_START_X,d0 
    move.l BM_NEWTON_WIDTH,d2
    add.l d2,d0
    
    move.l d0,NEWTON_RIGHT_X
    
    ;adjust position
    move.l #1,d0
    lsl.l #8,d0
    lsl.l #4,d0
    move.l d0,NEWTON_POSITION
    
LEFT_LIMITS_FINE

    rts
    
 
*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
