*-------------------------------------------------------------------------------
* Subroutine to set parameters and redraw the apple
*-------------------------------------------------------------------------------
Sub_Draw_Apple
    
    ;erase the apple
    move.l BM_APPLE_START_X,-(sp)
    move.l APPLE_INVAL_BOTTOM_Y,-(sp)
    move.l BM_APPLE_RIGHT_X,-(sp)
    move.l APPLE_INVAL_START_Y,-(sp)   

    move.l BM_BACK_START_X,-(sp)
    move.l BM_BACK_START_Y,-(sp)
    move.l BM_BACK_WIDTH,-(sp)
    move.l BM_BACK_HEIGHT,-(sp)  

    jsr Sub_Inval_Rect
     
    add.l #32,sp

    ;draw the apple if it is active
    cmpi.l #APPLE_INACTIVE,IS_APPLE_ACTIVE
    beq DONT_DRAW_APPLE
 
    movem.l ALL_REGS,-(sp)
    move.l BM_APPLE_ARRAY_START,a0
    
    move.l BM_APPLE_START_X,d6
    move.l BM_APPLE_START_Y,d7
    
    move.l d6,d4 ;copy of start x
    
    move.l BM_APPLE_WIDTH,d3
    add.l d6,d3 ; width +startx
    
    move.l BM_APPLE_HEIGHT,d5
    subq.l #1,d5
    add.l d7,d5 ; bottom + starty
    
    jsr Sub_Draw_Image
    movem.l (sp)+,ALL_REGS
DONT_DRAW_APPLE
    rts


*-------------------------------------------------------------------------------
* Subroutine to create a new apple or update apple position
*-------------------------------------------------------------------------------

Sub_Update_Apple

    ;if apple is inactive create a new one
    cmpi.l #APPLE_INACTIVE,IS_APPLE_ACTIVE
    bne UPDATE_APPLE
    jsr Sub_Generate_Random_Apple
   
UPDATE_APPLE
    movem.l ALL_REGS,-(sp)
    move.l BM_APPLE_START_Y,APPLE_INVAL_START_Y
    move.l BM_APPLE_BOTTOM_Y,APPLE_INVAL_BOTTOM_Y
    
    ;final velocity = initial velocity + gravity * delta time
    move.l DELTA_TIME,d0
    lsl.l #6,d0 ;d0 is in hundreth secs (>>2 to convert to secs), <<12 to convert to float,  preshift by >>4 for mul, so <<6,
    ;equal to lsl 12 lsr 2 lsr 4
    ;dt is already preshifted - dt x 2^8
    
    move.l GRAVITY,d1
    lsr.l #4,d1 ;preshift for multiplication
    
    mulu.w d0,d1 ;d1=gt
    lsr.l #4,d1 ;post shift to get gt x 2^12
    
    move.l APPLE_INITIAL_VELOCITY,d2 ;already in 2^12

    move.l d2,d3
    add.l d1,d3 ;vi+gt = vf
    move.l d3,APPLE_FINAL_VELOCITY
    
    ;distance = (initial velocity + final velocity/2) * delta time
    move.l d3,d4
    add.l d2,d4 ;vi+vf
    lsr.l #1,d4 ;vi+vf/2
    lsr.l #4,d4 
    mulu.w d0,d4 ;vi+vf/2 *t
    
    lsr.l #4,d4 ;post shift to get d * 2^12
    move.l d4,APPLE_DISTANCE
    lsr.l #8,d4
    lsr.l #4,d4 ;d in int
    
    ;update start position
    move.l BM_APPLE_START_Y,d5
    add.l d4,d5
    move.l d5,BM_APPLE_START_Y
    
    move.l APPLE_FINAL_VELOCITY,APPLE_INITIAL_VELOCITY
    
    move.l BM_APPLE_START_Y,d6
    move.l BM_BACK_HEIGHT,d7
    
    ;if apple if off screen, set apple as inactive
    cmp.l d7,d6
    blt END_UPDATE
    
    ;set apple inactive 
    move.l #APPLE_INACTIVE,IS_APPLE_ACTIVE
    
END_UPDATE
    
    move.l BM_APPLE_HEIGHT,d0
    add.l BM_APPLE_START_Y,d0
    move.l d0,BM_APPLE_BOTTOM_Y
    movem.l (sp)+,ALL_REGS
    rts

*-------------------------------------------------------------------------------
* Subroutine to generate random x and y positions for a new apple
*-------------------------------------------------------------------------------

Sub_Generate_Random_Apple
    movem.l ALL_REGS,-(sp)
   
    move.l #APPLE_MISS,IS_APPLE_HIT
    
    ;get random x position
    jsr getRandomLongIntoD6
    lsr.l #8,d6
    lsr.l #8,d6

    ;find random number mod xrange
    move.l #APPLE_XRANGE,d7
    jsr Sub_D6_Mod_D7
    
    ;add that to the start x position
    add.l #APPLE_XPOS_START,d7
    move.l d7,BM_APPLE_START_X
    
    move.l BM_APPLE_WIDTH,d0
    add.l d7,d0
    move.l d0,BM_APPLE_RIGHT_X
    
    ;get random y position
    jsr getRandomLongIntoD6
    lsr.l #8,d6
    lsr.l #8,d6
    
    ;find random number mod yrange
    move.l #APPLE_YRANGE,d7
    jsr Sub_D6_Mod_D7
    
    ;add that to the start y position
    add.l #APPLE_YPOS_START,d7
    move.l d7,BM_APPLE_START_Y
    
    move.l BM_APPLE_HEIGHT,d0
    add.l d7,d0
    move.l d0,BM_APPLE_BOTTOM_Y
   
    move.l #APPLE_ACTIVE,IS_APPLE_ACTIVE
    
    movem.l (sp)+,ALL_REGS
    rts    





*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
