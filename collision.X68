*-------------------------------------------------------------------------------
* Subroutine to detect collision between newton and the apple
*-------------------------------------------------------------------------------

Sub_Check_Collision
    movem.l ALL_REGS,-(sp)
    
    ;check if apple is below newton
    move.l BM_APPLE_BOTTOM_Y,d1
    cmp.l BM_NEWTON_START_Y,d1
    blt NO_COLLISION
    
    ;check if apple is within newton's left boundary
    move.l BM_APPLE_START_X,d1
    cmp.l NEWTON_RIGHT_X,d1
    bgt NO_COLLISION
    
    ;check if apple is within newton's right boundary
    move.l BM_APPLE_RIGHT_X,d1
    cmp.l BM_NEWTON_START_X,d1
    blt NO_COLLISION
    
    ;set flags
    move.l #APPLE_HIT,IS_APPLE_HIT
    move.l #APPLE_INACTIVE,IS_APPLE_ACTIVE
    
NO_COLLISION
    movem.l (sp)+,ALL_REGS
    rts
    
    
*-------------------------------------------------------------------------------
* Subroutine to check end condition, stop the game and stop the music
*-------------------------------------------------------------------------------

Sub_Check_End
    
    cmpi.w #0,LIVES
    bgt NO_GAME_OVER
    
    jsr Sub_Clear_Screen
    jsr Sub_Display_End_Screen
    
    move.l #STOP_SOUND_CODE,d2
    move.b #STOP_DIRECTX_SOUND_COMMAND,d0
    trap #15
    
    move.b #TERMINATE_COMMAND,d0
    trap #15
    
NO_GAME_OVER
    rts

    












*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
