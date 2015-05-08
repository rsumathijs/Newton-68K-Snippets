*-----------------------------------------------------------
* Title      : Newton and the Apple Tree
* Written by : Sumathi Swain
* Date       : 30-sept-2014
* Description: 
*-----------------------------------------------------------

    ORG    $1000
    include "trapcodes.X68"
    include "game_constants.X68"
    include "score_constants.X68"
    include "apple_constants.X68"
    include "newton_constants.X68"

    include "system_code.X68"
    include "bitmap_code.X68"
    include "collision.X68"
    
    include "menu_constants.X68"
    include "menu_code.X68"
    
    include "init.X68"
    include "input.X68"
    include "random.X68"

    include "score_code.X68"
    include "apple_code.X68"
    include "newton_code.X68"
    
   
START:
    
    jsr Sub_Read_Bitmap_Data
    jsr Sub_Set_Screen_Resolution
    jsr Sub_Display_Main_Menu
    jsr Sub_Display_Instructions_Screen
    jsr Sub_Enable_Double_Buffering
    jsr Sub_Draw_Background
    jsr Sub_Play_BGM
    
    jsr Sub_Init_Game
    jsr Sub_Draw_Newton
    jsr Sub_Draw_Apple
    jsr Sub_Draw_Score_And_Lives
    
    move.b #REPAINT_SCREEN_COMMAND,d0
    trap #15
    
Game_Loop
    
    jsr Sub_Get_Player_Input
    
     move.b #GET_TIME_COMMAND,d0
    trap #15
    move.l d1,OLD_TIME
    
    jsr Sub_Update_Newton
    jsr Sub_Update_Apple
    jsr Sub_Check_Collision
    jsr Sub_Update_Score_And_Lives
    
    jsr Sub_Draw_Newton
    jsr Sub_Draw_Apple
    jsr Sub_Draw_Score_And_Lives
    
    move.b #REPAINT_SCREEN_COMMAND,d0
    trap #15
    
    jsr Sub_Check_End
    
    move.b #GET_TIME_COMMAND,d0
    trap #15
    
    sub.l OLD_TIME,d1
    move.l d1,DELTA_TIME
 
    bra Game_Loop
       
    END    START
    























*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
