*-------------------------------------------------------------------------------
* Subroutine to get left or right key press input
*-------------------------------------------------------------------------------
   
Sub_Get_Player_Input

    move.l #GAME_INPUT,d1
    move.b #GET_USER_INPUT_COMMAND,d0
    trap #15
    
    move.l KEY_PRESSED,d7
    cmpi.b #NO_KEY_PRESSED,d7
    bne NO_INPUT
    
    cmpi.b #$FF,d1 ;check for right
    bne CHECK_FOR_LEFT_KEY
    
    move.b #0,d1
    move.l #RIGHT_KEY_PRESSED,KEY_PRESSED
    bra NO_INPUT
    
CHECK_FOR_LEFT_KEY
    
    swap.w d1
    cmpi.b #$FF,d1 ;check for left
    bne NO_INPUT
    
    move.b #0,d1
    move.l #LEFT_KEY_PRESSED,KEY_PRESSED
    
NO_INPUT
    rts
 



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
