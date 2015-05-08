*-------------------------------------------------------------------------------
* Subroutine to display the text on the main menu
*-------------------------------------------------------------------------------

Sub_Display_Main_Menu

    ;Text : Newton and the apple tree
    move.l #TITLE_FONT,d2
    move.l #TITLE_COLOR,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea MAIN_MENU_TITLE_TEXT,a1
    move.l #TITLE_XPOS,d1
    move.l #TITLE_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    ;Text : play as newton
    move.l #OPTIONS_FONT_BIG,d2
    move.l #OPTION_NEWTON1_COLOR,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea OPTION_NEWTON_LINE1,a1
    move.l #OPTION_NEWTON1_XPOS,d1
    move.l #OPTION_NEWTON1_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    ;Text : play as hooke
    move.l #OPTIONS_FONT_BIG,d2
    move.l #OPTION_HOOKE1_COLOR,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea OPTION_HOOKE_LINE1,a1
    move.l #OPTION_HOOKE1_XPOS,d1
    move.l #OPTION_HOOKE1_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    ;Text : press 1 to
    move.l #OPTIONS_FONT_SMALL,d2
    move.l #OPTION_NEWTON2_COLOR,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea OPTION_NEWTON_LINE2,a1
    move.l #OPTION_NEWTON2_XPOS,d1
    move.l #OPTION_NEWTON2_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    ;Text : - the hero
    
    lea OPTION_NEWTON_LINE3,a1
    move.l #OPTION_NEWTON3_XPOS,d1
    move.l #OPTION_NEWTON3_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    ;Text : press 2 to
    move.l #OPTIONS_FONT_SMALL,d2
    move.l #OPTION_HOOKE2_COLOR,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea OPTION_HOOKE_LINE2,a1
    move.l #OPTION_HOOKE2_XPOS,d1
    move.l #OPTION_HOOKE2_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    ;Text : -the rival
    lea OPTION_HOOKE_LINE3,a1
    move.l #OPTION_HOOKE3_XPOS,d1
    move.l #OPTION_HOOKE3_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    jsr Sub_Get_Menu_Input
    rts
    
*-------------------------------------------------------------------------------
* Subroutine to display the input for the main menu (1 or 2) and set mode accordingly
*-------------------------------------------------------------------------------

Sub_Get_Menu_Input

GET_MENU_INPUT 
    move.l #MENU_INPUT,d1
    move.b #GET_USER_INPUT_COMMAND,d0
    trap #15
    
    cmpi.b #$FF,d1
    bne CHECK_FOR_1
    
    move.l #MODE_HOOKE,GAME_MODE
    bra END_MENU_INPUT
CHECK_FOR_1
    swap.w d1
    cmpi.b #$FF,d1
    bne GET_MENU_INPUT   
    move.l #MODE_NEWTON,GAME_MODE
END_MENU_INPUT    
    rts

*-------------------------------------------------------------------------------
* Subroutine to display the text on the loading screen
*-------------------------------------------------------------------------------

Sub_Display_Instructions_Screen
    jsr Sub_Clear_Screen
    
    ;Text : Newton and the apple tree
    move.l #TITLE_FONT,d2
    move.l #TITLE_COLOR,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea MAIN_MENU_TITLE_TEXT,a1
    move.l #TITLE_XPOS,d1
    move.l #TITLE_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    ;Text : instructions
    move.l #INSTRUCTIONS_FONT,d2
    move.l #INSTRUCTIONS_COLOR,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea INSTRUCTIONS_TEXT,a1
    move.l #INSTRUCTIONS_XPOS,d1
    move.l #INSTRUCTIONS_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15

    ;Objective text
    ;Varies depends on the game mode
    move.l #OBJECTIVE_FONT,d2
    move.l GAME_MODE,d5
    cmpi.l #MODE_HOOKE,d5
    bne NEWTON_INSTRUCTIONS
    
    move.l #HOOKE_COLOR_MAIN,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea HOOKE_OBJECTIVE_1,a1
    move.l #OBJECTIVE1_XPOS,d1
    move.l #OBJECTIVE1_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    lea HOOKE_OBJECTIVE_2,a1
    move.l #OBJECTIVE2_XPOS,d1
    move.l #OBJECTIVE2_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    bra END_INSTRUCTIONS
NEWTON_INSTRUCTIONS
    move.l #NEWTON_COLOR_MAIN,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea NEWTON_OBJECTIVE_1,a1
    move.l #OBJECTIVE1_XPOS,d1
    move.l #OBJECTIVE1_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    lea NEWTON_OBJECTIVE_2,a1
    move.l #OBJECTIVE2_XPOS,d1
    move.l #OBJECTIVE2_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
END_INSTRUCTIONS

    ;Text : controls : ....
    move.l #CONTROLS_FONT,d2
    move.l #CONTROLS_COLOR,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
    
    lea CONTROLS_TEXT,a1
    move.l #CONTROLS_XPOS,d1
    move.l #CONTROLS_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    rts

*-------------------------------------------------------------------------------
* Subroutine to display the text on the ending screen and draw the ending image
*-------------------------------------------------------------------------------

Sub_Display_End_Screen
    ;Text : game over
    move.l #GAMEOVER_TEXT_FONT,d2
    move.l #WHITE,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15

    lea END_GAME_TEXT,a1
    move.l #END_GAME_X,d1
    move.l #END_GAME_Y,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    ;draw text and end image
    move.l GAME_MODE,d6
    cmpi.l #MODE_HOOKE,d6
    bne NEWTON_END
HOOKE_END    
    ;if decent score, it is considered as win
    move.w SCORE,d7
    cmpi.w #DECENT_SCORE_HOOKE,SCORE
    ble HOOKE_BAD_END
HOOKE_GOOD_END    
    move.l #END_TEXT_FONT,d2
    move.l #HOOKE_COLOR_MAIN,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
     
    lea END_HOOKE_GOOD_1,a1
    move.l #LINE_1_XPOS,d1
    move.l #LINE_1_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    move.l #END_TEXT_FONT,d2
    move.l #HOOKE_COLOR_SUB,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
     
    lea END_HOOKE_GOOD_2,a1
    move.l #LINE_2_XPOS,d1
    move.l #LINE_2_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
     
    move.l LOST_IMAGE_ARRAY_START,a0
    bra END_END
    
HOOKE_BAD_END
    move.l #END_TEXT_FONT,d2
    move.l #HOOKE_COLOR_MAIN,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
     
    lea END_HOOKE_BAD_1,a1
    move.l #LINE_1_XPOS,d1
    move.l #LINE_1_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    move.l #END_TEXT_FONT,d2
    move.l #HOOKE_COLOR_SUB,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
     
    lea END_HOOKE_BAD_2,a1
    move.l #LINE_2_XPOS,d1
    move.l #LINE_2_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    move.l FOUND_IMAGE_ARRAY_START,a0
    bra END_END
NEWTON_END
    move.w SCORE,d7
    cmpi.w #DECENT_SCORE_NEWTON,SCORE
    ble NEWTON_BAD_END
NEWTON_GOOD_END

    move.l #END_TEXT_FONT,d2
    move.l #NEWTON_COLOR_MAIN,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
     
    lea END_NEWTON_GOOD_1,a1
    move.l #LINE_1_XPOS,d1
    move.l #LINE_1_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    move.l #END_TEXT_FONT,d2
    move.l #NEWTON_COLOR_SUB,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
     
    lea END_NEWTON_GOOD_2,a1
    move.l #LINE_2_XPOS,d1
    move.l #LINE_2_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    move.l FOUND_IMAGE_ARRAY_START,a0
    bra END_END
NEWTON_BAD_END

    move.l #END_TEXT_FONT,d2
    move.l #NEWTON_COLOR_MAIN,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
     
    lea END_NEWTON_BAD_1,a1
    move.l #LINE_1_XPOS,d1
    move.l #LINE_1_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15
    
    move.l #END_TEXT_FONT,d2
    move.l #NEWTON_COLOR_SUB,d1
    move.b #SET_FONT_PROPERTIES_COMMAND,d0
    trap #15
     
    lea END_NEWTON_BAD_2,a1
    move.l #LINE_2_XPOS,d1
    move.l #LINE_2_YPOS,d2
    move.b #DRAW_TEXT_COMMAND,d0
    trap #15

    move.l LOST_IMAGE_ARRAY_START,a0
END_END 
   
    ;set parameters to draw the ending image
    move.l END_IMAGE_START_X,d6
    move.l END_IMAGE_START_Y,d7
    
    move.l d6,d4 ;copy of start x
    
    move.l END_IMAGE_WIDTH,d3
    add.l d6,d3 ; width +startx
    
    move.l END_IMAGE_HEIGHT,d5
    subq.l #1,d5
    add.l d7,d5 ; bottom + starty
    
    jsr Sub_Draw_Image

    move.b #REPAINT_SCREEN_COMMAND,d0
    trap #15
    rts






*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
