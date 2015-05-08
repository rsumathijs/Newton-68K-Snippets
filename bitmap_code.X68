*-------------------------------------------------------------------------------
* Subroutine to read Width, Height and Pixel Start of the bitmaps
*-------------------------------------------------------------------------------

Sub_Read_Bitmap_Data

    ;Read Background Image data
    lea BM_BACKGROUND_FILE, A0
    
    lea BM_BACK_WIDTH, A1
    move.l 18(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    move.l D1, (a1)

    lea BM_BACK_HEIGHT, A1
    move.l 22(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    move.l D1, (a1)

    lea BM_BACK_ARRAY_START, A1
    move.l 10(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    add.l a0,d1     ; Start Address of pixel array = start of file + number of pixels from start
    move.l d1,(a1) 
    
    ;Read apple data
    lea BM_APPLE_FILE, A0
    
    lea BM_APPLE_WIDTH, A1
    move.l 18(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    move.l D1, (a1)

    lea BM_APPLE_HEIGHT, A1
    move.l 22(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    move.l D1, (a1)

    lea BM_APPLE_ARRAY_START, A1
    move.l 10(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    add.l a0,d1   
    move.l d1,(a1) 
    
    ;Read Newton data
    lea BM_NEWTON_FILE, A0
    
    lea BM_NEWTON_WIDTH, A1
    move.l 18(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    move.l D1, (a1)

    lea BM_NEWTON_HEIGHT, A1
    move.l 22(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    move.l D1, (a1)

    lea BM_NEWTON_ARRAY_START, A1
    move.l 10(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    add.l a0,d1    
    move.l d1,(a1)
    
    ;Read End image data
    lea NEWTON_FOUND, A0
    
    lea END_IMAGE_WIDTH, A1
    move.l 18(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    move.l D1, (a1)

    lea END_IMAGE_HEIGHT, A1
    move.l 22(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    move.l D1, (a1)

    lea FOUND_IMAGE_ARRAY_START, A1
    move.l 10(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    add.l a0,d1   
    move.l d1,(a1) 
    
    lea NEWTON_LOST, A0
    lea LOST_IMAGE_ARRAY_START, A1
    move.l 10(A0), D1
    bsr SUB_LITTLE_TO_BIG_ENDIAN
    add.l a0,d1    
    move.l d1,(a1) 
    rts


*-------------------------------------------------------------------------------
* Subroutine to set parameters to draw the background image and draw it
*-------------------------------------------------------------------------------

Sub_Draw_Background
    movem.l ALL_REGS,-(sp)
	
	move.l BM_BACK_ARRAY_START,a0
    
    move.l BM_BACK_START_X,d6
    move.l BM_BACK_START_Y,d7
    
    move.l d6,d4 ;copy of start x
    
    move.l BM_BACK_WIDTH,d3
    add.l d6,d3 ; width +startx
    
    move.l BM_BACK_HEIGHT,d5
    subq.l #1,d5
    add.l d7,d5 ; bottom + starty
    
    JSR Sub_Draw_Image
    
    move.b #REPAINT_SCREEN_COMMAND,d0
    trap #15
    movem.l (sp)+,ALL_REGS
    rts
    
    
*-------------------------------------------------------------------------------
* Subroutine to draw a 32 bit bitmap image with the specified parameters
*-------------------------------------------------------------------------------   
Sub_Draw_Image
    ; Parameters :
    ; d3 - width + start
    ; d4 - start x copy
    ; d5 - height + start
    ; d6 - start x
    ; d7 - start y
    ; a0 - array start
DRAW_BITMAP_LOOP

    move.l (a0)+,d1
    move.l d1,d2
    
    ;Fuschia is used as mask color. Draw background if it is the mask color
    ;Images contain white and other colors, so fuschia is used as a mask color 
    ;Can be changed to a color not present in the pallete
    cmpi.l #FUSCHIA,d2
    bne IGNORE_MASK 
    
    ;Setting this ensures that we draw the background always, if the draw color is white
    move.b #BACKGROUND_AND_DRAW_CODE,d1
    move.b #SET_DRAWING_MODE_COMMAND,d0
    trap #15
    
    ;set pen color as white
    move.l #WHITE,d2
    bra CONTINUE
IGNORE_MASK
    
    ;Need to revert back to the usual drawing mode if the pen color is not the mask color
    move.b #DRAW_DEFAULT_CODE,d1
    move.b #SET_DRAWING_MODE_COMMAND,d0
    trap #15
    
CONTINUE
    move.l d2,d1
    move.b #SET_PEN_COLOR_COMMAND,d0
    trap #15
    
    ;set coordinates of the pixel
    move.l d4,d1
    
    move.l d5,d2
    
    move.b #DRAW_PIXEL_COMMAND,d0
    trap #15
    
    addq.l #1,d4
    
    cmp.l d3, d4
    bne DRAW_BITMAP_LOOP
    
    move.l d6,d4
    subq.l #1,d5
    
    cmp.l d7, d5
    bge DRAW_BITMAP_LOOP   
    rts   

*-------------------------------------------------------------------------------
* Subroutine to Invalidate a previously drawn bitmap with the specified parameters
*-------------------------------------------------------------------------------
Sub_Inval_Rect
    ; Parameters :
    ; 92 - leftx of image
    ; 88 - bottomy of image
    ; 84 - rightx of image
    ; 80 - topy of image
    ; 76 - startx of background
    ; 72 - starty of background
    ; 68 - width of background
    ; 64 - height of background
    
    movem.l ALL_REGS,-(sp)

    move.b #DRAW_DEFAULT_CODE,d1
    move.b #SET_DRAWING_MODE_COMMAND,d0
    trap #15
    
    move.l BM_BACK_ARRAY_START,a0
        
    move.l 92(sp),d4
    move.l 88(sp),d5
    subq.l #1,d5
    move.l 84(sp),d6
    move.l 80(sp),d7
    
REDRAW_BITMAP_OUTER_LOOP

    ;find location of the first color in row in the pixel array
    ;row start = 4*width + 4*width*(height-y position -1)
    ;4 because of 32 bit
    
    moveq.l #0,d0
    moveq.l #0,d3
        
    move.l d5,d3
    neg.l d3
    add.l 64(sp),d3
    sub.l #1,d3 ;height - ypos-1

    move.l 68(sp),d1
    mulu.w d3,d1 ;width * (ht-ypos-1)
        
    move.l d1,d3
    ;mulu.w #4,d3 
    add.l d1,d3
    add.l d1,d3
    add.l d1,d3

    move.l d4,d0
    mulu.w #4,d0
    add.l d0,d3 
    
REDRAW_BITMAP_INNER_LOOP

    move.l a0,a5
    add.l d3,a5
    
    move.l (a5),d1
    
    move.b #SET_PEN_COLOR_COMMAND,d0
    trap #15
    
    move.l d4,d1
    add.l 76(sp),d1
    
    move.l d5,d2
    add.l 72(sp),d2
    
    move.b #DRAW_PIXEL_COMMAND,d0
    trap #15
    
    addq.l #1,d4
    addq.l #4,d3
    
    cmp.l d6, d4
    bne REDRAW_BITMAP_INNER_LOOP
    
    move.l 92(sp),d4
    
    subq.l #1,d5
    cmp.l d7, d5
    bge REDRAW_BITMAP_OUTER_LOOP
    
    movem.l (sp)+,ALL_REGS  

    rts

	





*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
