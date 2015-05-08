*---------------------------------------------------------------------------
* Subroutine to convert the value in D1 from little endian to big endian
*--------------------------------------------------------------------------

SUB_LITTLE_TO_BIG_ENDIAN   ;example : 01020304
    rol.w #8,D1        ;swap 03 and 04
     
    swap.w D1          ;swap 0102 and 0403

    rol.w #8,D1        ;swap 01 and 02
    rts                ;result : 04030201
    

*---------------------------------------------------------------------------
* Subroutine to set screen resolutions to the size of the background
*--------------------------------------------------------------------------
  
Sub_Set_Screen_Resolution
    move.l BM_BACK_WIDTH, D1
    swap.w D1
    move.l BM_BACK_HEIGHT,D2
    move.w d2,d1
    move.b #SET_SCREEN_RESOLUTION_COMMAND,D0
    trap #15
    rts
    
*---------------------------------------------------------------------------
* Subroutine to allow drawing on screen buffer to avoid flickering
*--------------------------------------------------------------------------

Sub_Enable_Double_Buffering
    move.b	#ENABLE_DOUBLE_BUFFERING_CODE,D1
	move.l	#SET_DRAWING_MODE_COMMAND,D0
	trap	#15
	rts
	
*---------------------------------------------------------------------------
* Subroutine to clear screen buffer (in double buffer mode)
*--------------------------------------------------------------------------
	
Sub_Clear_Screen
    move.b #CLEAR_SCREEN_COMMAND, D0
    move.l #$FF00, D1
    trap #15
    rts
  
*---------------------------------------------------------------------------
* Subroutine to play DirectX Background Music depending on the mode
*--------------------------------------------------------------------------

Sub_Play_BGM
    move.l GAME_MODE,d7
    cmpi.l #MODE_NEWTON,d7
    bne HOOKE_MUSIC
    lea NEWTON_BGM,a1
    bra END_MUSIC
HOOKE_MUSIC
    lea HOOKE_BGM,a1
END_MUSIC

    move.b #PLAY_DIRECTX_SOUND_COMMAND,d0
    trap #15
    rts
    
*---------------------------------------------------------------------------
* Subroutine to return the modulus of D6 by D7 in D7
*--------------------------------------------------------------------------

Sub_D6_Mod_D7
    divu.w  d7,d6
    swap.w  d6
    move.w  d6,d7
    rts
    
    



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
