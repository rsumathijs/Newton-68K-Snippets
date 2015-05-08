;colors used in the game
REBECCAPURPLE   equ $993366
CRIMSON         equ $3C14DC
RED             equ $0000FF
BLUE            equ $FF0000
DARKBLUE        equ $CC483F
WHITE           equ $00FFFFFF
BLACK           equ $00000000
FUSCHIA         equ $00FF00FF

HOOKE_COLOR_MAIN    equ BLUE
HOOKE_COLOR_SUB     equ DARKBLUE

NEWTON_COLOR_MAIN   equ RED
NEWTON_COLOR_SUB    equ CRIMSON

;Title properties
MAIN_MENU_TITLE_TEXT    dc.b 'Newton and the Apple Tree',0
TITLE_COLOR             equ REBECCAPURPLE
TITLE_FONT              equ $06180001 ;consolas 18 point bold

TITLE_XPOS              equ  150  
TITLE_YPOS              equ  50

;Options Properties
OPTIONS_FONT_BIG        equ $06160001 ;consolas 16 point bold
OPTIONS_FONT_SMALL      equ $06100000 ;consolas 10 point

;Newton Option properties
OPTION_NEWTON_LINE1     dc.b 'Play as Newton',0
OPTION_NEWTON1_COLOR    equ NEWTON_COLOR_MAIN
OPTION_NEWTON1_XPOS     equ 300
OPTION_NEWTON1_YPOS     equ 200

OPTION_NEWTON_LINE2     dc.b '- The Hero',0
OPTION_NEWTON2_COLOR    equ NEWTON_COLOR_SUB
OPTION_NEWTON2_XPOS     equ 450
OPTION_NEWTON2_YPOS     equ 240

OPTION_NEWTON_LINE3     dc.b 'Press 1 to',0
OPTION_NEWTON3_XPOS     equ 250
OPTION_NEWTON3_YPOS     equ 170

;Hooke option properties
OPTION_HOOKE_LINE1      dc.b 'Play as Hooke',0
OPTION_HOOKE1_COLOR     equ HOOKE_COLOR_MAIN
OPTION_HOOKE1_XPOS      equ 300
OPTION_HOOKE1_YPOS      equ 370

OPTION_HOOKE_LINE2      dc.b '- The Rival',0
OPTION_HOOKE2_COLOR     equ HOOKE_COLOR_SUB
OPTION_HOOKE2_XPOS      equ 450
OPTION_HOOKE2_YPOS      equ 410

OPTION_HOOKE_LINE3      dc.b 'Press 2 to',0
OPTION_HOOKE3_XPOS      equ 250
OPTION_HOOKE3_YPOS      equ 340

;Instructions properties
INSTRUCTIONS_TEXT       dc.b 'Instructions',0
INSTRUCTIONS_XPOS       equ 100
INSTRUCTIONS_YPOS       equ 150
INSTRUCTIONS_COLOR      equ WHITE
INSTRUCTIONS_FONT       equ $04120004 ;lucida console 12 point underlined

;Objective line 1 properties
NEWTON_OBJECTIVE_1      dc.b 'Newton is having a bit of a physics block..',0
HOOKE_OBJECTIVE_1       dc.b 'Your rival Newton is stealing your spotlight too much..',0
OBJECTIVE1_XPOS         equ 60
OBJECTIVE1_YPOS         equ 200
OBJECTIVE_FONT          equ $06120000 ;consolas 12 point

;Objective line 2 properties
NEWTON_OBJECTIVE_2      dc.b 'Hit Newton with falling apples to inspire him!',0
HOOKE_OBJECTIVE_2       dc.b 'Don''t let Newton get inspired by falling apples!',0
OBJECTIVE2_XPOS         equ 60
OBJECTIVE2_YPOS         equ 250

;Controls properties
CONTROLS_TEXT           dc.b 'Controls : Use Left and Right Keys to move Newton',0
CONTROLS_COLOR          equ WHITE
CONTROLS_XPOS           equ 80
CONTROLS_YPOS           equ 300
CONTROLS_FONT           equ $06120000 ;consolas 12 point

;Game over properties
GAMEOVER_TEXT_FONT      equ $06160001 ;consolas 16 point bold
END_GAME_TEXT           dc.b 'Game Over',0
END_GAME_X              equ 300
END_GAME_Y              equ 50

;Ending text properties
END_TEXT_FONT           equ $06120000
END_NEWTON_GOOD_1       dc.b 'You have restored Newton''s acceleration :)',0
END_NEWTON_GOOD_2       dc.b 'Good Job!! May the (m x a) be with you!',0
END_NEWTON_BAD_1        dc.b 'You don''t understand the gravity of the situation here,',0
END_NEWTON_BAD_2        dc.b 'do you? :/ Nice try though!',0
END_HOOKE_GOOD_1        dc.b 'Newton is screwed!',0
END_HOOKE_GOOD_2        dc.b 'Your work here is done >:D',0
END_HOOKE_BAD_1         dc.b 'That wasn''t enough friction to stop Newton :(',0
END_HOOKE_BAD_2         dc.b 'Oh well, an atomic reputation isn''t too bad, right.. :/',0

LINE_1_XPOS             equ 50
LINE_1_YPOS             equ 120

LINE_2_XPOS             equ 50
LINE_2_YPOS             equ 170

extra                   dc.l 0 ;to ensure it is even-aligned for long 

;conclusion images
NEWTON_LOST             incbin "assets\newton_lost.bmp"
NEWTON_FOUND            incbin "assets\newton_found.bmp"

END_IMAGE_WIDTH         ds.l 1
END_IMAGE_HEIGHT        ds.l 1
FOUND_IMAGE_ARRAY_START ds.l 1
LOST_IMAGE_ARRAY_START  ds.l 1
END_IMAGE_START_X       dc.l 280
END_IMAGE_START_Y       dc.l 250





*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
