                                    ;;*****************************************************************************;;
                                    ;;                                                                             ;;
                                    ;;                   ********BUBBLE SHOOTING GAME********                      ;;
                                    ;;                                                                             ;;
                                    ;;                                 ***LGU***                                   ;;
                                    ;;                                                                             ;;
                                    ;;                   ********MUHAMMAD AZEEM 310-G********                      ;;
                                    ;;                                                                             ;;
                                    ;;                                                                             ;;
                                    ;;*****************************************************************************;;
                                    
                     ;;****************************************************************************************************;;
                     ;;************   MACRO LINE NUMBER     = 30   ::   VARIABLE LINE NUNBER      = 103       *************;;
                     ;;************   MAIN CODE LINE NUMBER = 300  ::   LOON POSITION LINE NUMBER = 343       *************;;
                     ;;************   KEYBOARD BUTTON       = 433  ::   FILE HANDLING WRITE       = 568       *************;;
                     ;;************   FILE HANDLING READ    = 652  ::   LOADING CODE              = 718       *************;;
                     ;;************   GAME MENU CODE        = 841  ::   PROC FUNCTION             = 900       *************;;
                     ;;************      *****                                                         ****   *************;;
                     ;;************            *  MUST ADD "PRO.TXT" FILE IN (EMU => MYBUILD FOLDER) *        *************;;
                     ;;************      *****                                                         ****   *************;;
                     ;;****************************************************************************************************;;                                    


                            ;**************************============ L I B R A R Y ============************************

INCLUDE "EMU8086.INC"

                            ;***************************============ M A C R O ============***************************

PRINTR MACRO P1
    PUSH CX
    PUSH BX
    MOV AX,900H
    mov bl,0AH
    mov cx,4400h
    INT 10H
    MOV DX,P1
    MOV AH,2
    INT 21H
    POP BX
    POP CX     
ENDM

PRINTW MACRO P1
    PUSH CX 
    PUSH BX
    MOV AX,900H
    mov bl,0CH
    mov cx,4400h
    INT 10H
    MOV DX,P1
    MOV AH,2
    INT 21H
    POP BX
    POP CX     
ENDM

PRINTY MACRO P1
    PUSH CX
    MOV AX,900H
    mov bl,0EH
    mov cx,1h
    INT 10H
    MOV DX,P1
    MOV AH,2
    INT 21H
    POP CX     
ENDM

PRINTC MACRO P1
    PUSH CX
    MOV AX,900H
    mov bl,0BH
    mov cx,1h
    INT 10H
    MOV DX,P1
    MOV AH,2
    INT 21H
    POP CX     
ENDM 

PRINTS MACRO P1
    PUSH CX
    MOV AX,900H
    mov bl,0BH
    mov cx,4400h
    INT 10H
    MOV DX,OFFSET P1
    MOV AH,9
    INT 21H
    POP CX   
ENDM 


                             ;**************************============ S I Z E ============************************

.MODEL LARGE
                               ;================================================================================ 
                               ;|                                                                              |
                               ;|                  ******************VARIABLES********************             |
                               ;|                                                                              |
                               ;================================================================================
.DATA
    
    ;**********************FILE-HANDLING VARIABLE***********************
    FILE DB "PRO.TXT",0
    MSG DB 16 DUP(?) 
    BUFFER DB 1000 DUP('$')
    HANDLE DW ?    
    COUNT DB 1
    ;******************************************************************* 
    
    EXIT DB 0
    PLAYER_POS DW 1760D                         ;POSITION OF PLAYER

    ARROW_POS DW 0D                             ;POSITION OF ARROW
    ARROW_STATUS DB 0D                          ;0 = ARROW READY TO GO ELSE NOT 
    ARROW_LIMIT DW  22D                         ;150D
    
    LOON_POS DW 3860D                           ;3990D
    LOON_STATUS DB 0D
             
                                                ;DIRECTION OF PLAYER 
                                                ;UP=8, DOWN=2
    DIRECTION DB 0D
    
    STATE_BUF DB 19 DUP('$')                    ;SCORE VERIABLE
    
    NAME1 DB 6 DUP('$')          
    
    HIT_NUM DB 0D                               ;PLAYER NAME
    HITS DW 0D
    MISS DW 0D  

        START DW '  ',10,13
    DW '***************************************************',10,13
    DW '***************************************************',10,13
    DW '                     ***************************************************',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13 
    DW '                     *        PRESS 1 FOR ENTER TOKEN ID               *',10,13
    DW '                     *        PRESS 2 FOR BUY   TOKEN ID               *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13
    DW '                     *                                                 *',10,13 
    DW '                     *                                                 *',10,13
    DW '                     ***************************************************',10,13
    DW '***************************************************',10,13
    DW '***************************************************',10,13
    DW 'ENTER KEY = $'
    
    START_PASSWORD DW '  ',10,13
    DW '******************************************************',10,13
    DW '                             |***************|',10,13
    DW '                             | ^   SCORE   ^ |',10,13
    DW '                             |***************|',10,13
    DW '                                                      ',10,13
    DW '                                                      ',10,13
    DW '                                                      ',10,13
    DW '                     *          *****     ***    **** ',10,13 
    DW '                     *         *     *   *   *   *    ',10,13
    DW '                     *         *     *    *      *    ',10,13
    DW '                     *         *     *      *    ***  ',10,13
    DW '                     *         *     *   *   *   *    ',10,13
    DW '                     ********   *****     ***    **** ',10,13
    DW '                                                      ',10,13
    DW '                                                      ',10,13
    DW '                                                      ',10,13 
    DW '                                GAME OVER',10,13
    DW '                        PRESS ENTER TO START AGAIN$',10,13
    
    GAME_OVER_STR_LOSS DW '  ',10,13
    DW '                             |               |',10,13
    DW '                             |***************|',10,13
    DW '                             | ^   SCORE   ^ |',10,13
    DW '                             |***************|',10,13
    DW '                                                      ',10,13
    DW '                                                      ',10,13
    DW '                                                      ',10,13
    DW '                     *          *****     ***    **** ',10,13 
    DW '                     *         *     *   *   *   *    ',10,13
    DW '                     *         *     *    *      *    ',10,13
    DW '                     *         *     *      *    ***  ',10,13
    DW '                     *         *     *   *   *   *    ',10,13
    DW '                     ********   *****     ***    **** ',10,13
    DW '                                                      ',10,13
    DW '                                                      ',10,13
    DW '                                                      ',10,13 
    DW '                                GAME OVER',10,13
    DW 'PRESS 1 FOR VIEW ALL SCORE',10,13
    DW 'PRESS 2 FOR PLAY AGAIN',10,13
    DW 'PRESS 3 FOR EXITS$',10,13
        
    PASSWORD_USER DW '  ',10,13
    DW '  ',10,13
    DW '  ',10,13
    DW '  ',10,13
    DW '        ************************************************************',10,13
    DW '        *                                                          *',10,13
    DW '        *                                                          *',10,13
    DW '        *      ****************                                    *',10,13
    DW '        *       *****************                                  *',10,13
    DW '        *                    ENTER YOUR TOKEN ID                   *',10,13
    DW '        *                                  ****************        *',10,13
    DW '        *                                   *****************      *',10,13
    DW '        *                                                          *',10,13
    DW '        *                       __________________                 *',10,13
    DW '        *                      | P A S S W O R D  |                *',10,13
    DW '        ***********************|                  |*****************',10,13
    DW '                               | $'
    
    PASSWORD_ADMIN DW '  ',10,13
    DW '  ',10,13
    DW '  ',10,13
    DW '  ',10,13
    DW '        ************************************************************',10,13
    DW '        *                                                          *',10,13
    DW '        *                                                          *',10,13
    DW '        *      ****************                                    *',10,13
    DW '        *       *****************                                  *',10,13
    DW '        *                    ENTER ADMIN PASSWORD (2765)           *',10,13
    DW '        *                                  ****************        *',10,13
    DW '        *                                   *****************      *',10,13
    DW '        *                                                          *',10,13
    DW '        *                       __________________                 *',10,13
    DW '        *                      | P A S S W O R D  |                *',10,13
    DW '        ***********************|                  |*****************',10,13
    DW '                               | $' 
    END_MENU DW '                                |__________________|',10,13,'$' 
    APASSWORD DW '2765$'
    UPASSWORD DW '1234$'
    LOADIN DW '                      LOADING < $' 
    NOTFOUND DW 'PRESS ENTER TO TRY AGAIN$'
    FOUND DW 'WELCOME IN GAME PRESS ANY KEY$'
    FOUND1 DW 'YOUR TOKEN ID IS 1234',10,13,'PRESS ENTER FOR USE TOKEN$'
    PASS1 DW 0
    PASS3 DW 0                                                               
    GAME_OVER_STR_WIN DW '  ',10,13
    DW '                             |               |',10,13
    DW '                             |***************|',10,13
    DW '                             | ^   SCORE   ^ |',10,13
    DW '                             |***************|',10,13
    DW '                                                      ',10,13    
    DW '                                                      ',10,13    
    DW '                                                      ',10,13    
    DW '                      *       *   *********  *       *',10,13 
    DW '                      *       *       *      * *     *',10,13
    DW '                      *       *       *      *  *    *',10,13
    DW '                      *   *   *       *      *    *  *',10,13
    DW '                      * *   * *       *      *     * *',10,13
    DW '                      *       *   *********  *       *',10,13
    DW '                                                      ',10,13  
    DW '                                                      ',10,13  
    DW '                                                      ',10,13  
    DW '                                GAME OVER',10,13
    DW 'PRESS 1 FOR VIEW ALL SCORE',10,13
    DW 'PRESS 2 FOR PLAY AGAIN',10,13
    DW 'PRESS 3 FOR EXITS$',10,13 
                                                                   
                         ;*********0AH = 10, 0DH = 13*********                                 

    GAME_START_STR DW '  ',0AH,0DH
    
    DW '     ******************************************************************',0AH,0DH
    DW '   **********************************************************************',0AH,0DH
    DW '  ************************************************************************',0AH,0DH
    DW ' *********                                                       **********',0AH,0DH
    DW '*********                                                         *********',0AH,0DH                                        
    DW '*********            ***** BALLOON SHOOTING GAME *****            *********',0AH,0DH
    DW '*********                                                         *********',0AH,0DH
    DW '*********                                                         *********',0AH,0DH
    DW '**********                                                       **********',0AH,0DH
    DW '***************************************************************************',0AH,0DH
    DW '***************************************************************************',0AH,0DH          
    DW '**********                                                       **********',0AH,0DH
    DW '*********             USE UP AND DOWN KEY TO MOVE PLAYER          *********',0AH,0DH
    DW '*********                 AND SPACE BUTTON TO SHOOT               *********',0AH,0DH
    DW '*********                                                         *********',0AH,0DH
    DW ' *********                                                       **********',0AH,0DH
    DW '  ************************************************************************',0AH,0DH
    DW '   **********************************************************************',0AH,0DH
    DW '     ******************************************************************',0AH,0DH
    DW '   ',0AH,0DH
    DW 'ENTER YOUR NAME = $'


                              ;================================================================================
                              ;|                                                                              |
                              ;|                  ******************CODE********************                  |
                              ;|                                                                              |
                              ;================================================================================
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AX, 47104D                             ;EXTRA SEGMENT
    MOV ES,AX                                  
    
    
    
    JMP GAME_MENU                              ;DISPLAY MAIN MENU
    
                                                                       
    MAIN_LOOP:                                 ;UPDATE LOGIC AND DISPLAY EVERYTHING
                                               ;CHECK ANY KEY IS PRESSED
        MOV AH,1H
        INT 16H                                ;GO IF PRESSED
        JNZ KEY_PRESSED                        ;GO IF SPACE, UP, DOWN KEY PRESS, Line = 219
        JMP INSIDE_LOOP                        ;OR JUST CONTINUE
        
        INSIDE_LOOP:                           ;CHECKING EVERY THING
            
            CMP MISS,9                         ;IF BALOON MISS 9 TIMES.GO TO GAME OVER SECTION
            JGE GAME_OVER
            
            CMP HITS,9                         ;IF BALOON MISS 9 TIMES.GO TO GAME OVER SECTION
            JGE GAME_OVER
            
            MOV DX,ARROW_POS                   ;CHECKING COLLITIONS
            CMP DX, LOON_POS
            JE HIT
            
            CMP DIRECTION,8D                   ;UPDATE PLAYER POSITION
            JE PLAYER_UP
            CMP DIRECTION,2D                   ;UP OR DOWN BASED ON DIRECTION VERIABLE
            JE PLAYER_DOWN
            
            MOV DX,ARROW_LIMIT                 ;HIDE ARROW 
            CMP ARROW_POS, DX
            JGE HIDE_ARROW
            
            CMP LOON_POS, 0D                   ;CHECK MISSED LOON
            JLE MISS_LOON
            JNE RENDER_LOON 
        
            HIT:                               ;PLAY SOUND IF HIT
                PRINTC 7D                      ;BEEP
                
                INC HITS                       ;UPDATE SCORE
                
                LEA BX,STATE_BUF               ;DISPLAY SCORE
                CALL SHOW_SCORE 
                
                PRINTS STATE_BUF
                
                PRINTC 0DH                     ;NEWLINE
                
                JMP FIRE_LOON                  ;NEW LOON POPS UP
        
            RENDER_LOON:                       ;DRAW LOON
                MOV CL, ' '                    ;HIDE OLD LOON
                MOV CH, 1111B                  ;LOON POSITION
            
                MOV BX,LOON_POS 
                MOV ES:[BX], CX
                    
                SUB LOON_POS,160D              ;AND DRAW NEW ONE IN NEW POSITION
                MOV CL, 15D                    ;LOON SHAPE
                MOV CH, 1101B                  ;LOON COLOR
            
                MOV BX,LOON_POS 
                MOV ES:[BX], CX
                
                CMP ARROW_STATUS,1D            ;CHECK ANY ARROW TO RANDER
                JE RENDER_ARROW
                JNE INSIDE_LOOP2 
            
            RENDER_ARROW:                      ;RENDER ARROW
            
                MOV CL, ' '
                MOV CH, 1111B
            
                MOV BX,ARROW_POS               ;HIDE OLD POSITION
                MOV ES:[BX], CX
                    
                ADD ARROW_POS,4D               ;DRAW NEW POSITION
                MOV CL, 26D
                MOV CH, 1001B
            
                MOV BX,ARROW_POS 
                MOV ES:[BX], CX
            
            INSIDE_LOOP2:
                
                MOV CL, 125D                  ;DRAW PLAYER 
                MOV CH, 1100B
                
                MOV BX,PLAYER_POS 
                MOV ES:[BX], CX
                
                 
                           
        CMP EXIT,0
        JE MAIN_LOOP                          ;END MAIN LOOP
        JMP EXIT_GAME
     
    JMP INSIDE_LOOP2
        
    PLAYER_UP:                                ;HIDE PLAYER OLD POSITION
        MOV CL, ' '
        MOV CH, 1111B
            
        MOV BX,PLAYER_POS 
        MOV ES:[BX], CX
        
        SUB PLAYER_POS, 160D                  ;SET NEW POSTION OF PLAYER
        MOV DIRECTION, 0    
    
        JMP INSIDE_LOOP2                      ;IT WILL DRAW IN MAIN LOOP
        
    PLAYER_DOWN:
        MOV CL, ' '                           ;SAME AS PLAYER UP
        MOV CH, 1111B                         ;HIDE OLD ONE AND SET NEW POSTION
                                              
        MOV BX,PLAYER_POS 
        MOV ES:[BX], CX
        
        ADD PLAYER_POS,160D                   ;AND MAIN LOOP DRAW THAT
        MOV DIRECTION, 0
        
        JMP INSIDE_LOOP2
    
    KEY_PRESSED:                              ;INPUT HANALING SECTION
        MOV AH,0
        INT 16H
    
        CMP AH,48H                            ;GO UPKEY IF UP BUTTON IS PRESSED
        JE UPKEY
        CMP AH, 50H
        JE DOWNKEY
        
        CMP AH,39H                            ;GO SPACEKEY IF UP BUTTON IS PRESSED
        JE SPACEKEY
        
        CMP AH,4BH                            ;GO LEFTKEY (THIS IS FOR DEBUGING)
        JE LEFTKEY
        
        CMP AH,4DH                            ;GO LEFTKEY (THIS IS FOR DEBUGING)
        JE RIGHTKEY
         
                                              ;IF NO KEY IS PRESSED GO TO INSIDE OF LOOP
        JMP INSIDE_LOOP
    
    LEFTKEY:                                  ;WE USE IT FOR DEBUGING 
        ;JMP GAME_OVER
        INC MISS                              ;IF YOU WANT TO TERMINATE YOUR PROGRAM SO UNCOMMENT THIS
                
        LEA BX,STATE_BUF
        CALL SHOW_SCORE                       ;CALL SHOW SCROE PROC FUNCTION
        PRINTS STATE_BUF
        
        PRINTC 0DH
    JMP INSIDE_LOOP
    
    RIGHTKEY:                                  ;WE USE IT FOR DEBUGING 
        ;JMP GAME_OVER
        INC HITS
                
        LEA BX,STATE_BUF
        CALL SHOW_SCORE 
        PRINTS STATE_BUF
        
        PRINTC 0DH
    JMP INSIDE_LOOP
        
    UPKEY:                                    ;SET PLAYER DIRECTION TO UP
        MOV DIRECTION, 8D
        JMP INSIDE_LOOP
    
    DOWNKEY:
        MOV DIRECTION, 2D                     ;SET PLAYER DIRECTION TO DOWN
        JMP INSIDE_LOOP
        
    SPACEKEY:                                 ;SHOOT A ARROW
        CMP ARROW_STATUS,0
        JE  FIRE_ARROW
        JMP INSIDE_LOOP
    
    FIRE_ARROW:                               ;SET ARROW POSTION IN PLAYER POSITION
        MOV DX, PLAYER_POS                    ;SO ARROW FIRE FROM PLAYER POSTION
        MOV ARROW_POS, DX
        
        MOV DX,PLAYER_POS                     ;WHEN FIRE AN ARROW IT ALSO SET LIMIT
        MOV ARROW_LIMIT, DX                   ;OF ARROW. WHERE IT SHOULD BE HIDE
        ADD ARROW_LIMIT, 22D                  ;150
        
        MOV ARROW_STATUS, 1D                  ;SET ARROW STATUS.IT PREVENTS MULTIPLE 
        JMP INSIDE_LOOP                       ;SHOOTING 
    
    MISS_LOON:
        ADD MISS,1                            ;UPDATE SCORE
    
        LEA BX,STATE_BUF                      ;DISPLAY SCORE
        CALL SHOW_SCORE 
        PRINTS STATE_BUF
                                              ;NEW LINE
        PRINTC 0DH 
        
    JMP FIRE_LOON
        
    FIRE_LOON:                                ;FIRE NEW BALLOON
        MOV LOON_STATUS, 1D
        MOV LOON_POS, 3860D                   ;3990D
        JMP RENDER_LOON
        
    HIDE_ARROW:
        MOV ARROW_STATUS, 0                   ;HIDE ARROW
        
        MOV CL, ' '
        MOV CH, 1111B
        
        MOV BX,ARROW_POS 
        MOV ES:[BX], CX
        
        CMP LOON_POS, 0D 
        JLE MISS_LOON
        JNE RENDER_LOON 
        
        JMP INSIDE_LOOP2
                                              ;PRINT GAME OVER SCREEN
    GAME_OVER:
        XOR BX,BX
        MOV SI,OFFSET NAME1
        MOV BX,OFFSET MSG
        O:
        CMP [SI],'$'
        JE DEAD  
        MOV DX,[SI]
        MOV [BX],DX
        
        INC SI
        INC BX
        JMP O
        DEAD:
        MOV [BX],' '                          ;INITIALIZE SCORE VARIABLE
        INC BX                                ;____________*____________
        MOV [BX],'S'                          ;____________*____________
        INC BX                                ;____________*____________
        MOV [BX],'C'                          ;____________*____________
        INC BX                                ;____________*____________
        MOV [BX],'O'                          ;____________*____________
        INC BX                                ;____________*____________
        MOV [BX],'R'                          ;____________*____________
        INC BX                                ;____________*____________
        MOV [BX],'E'                          ;____________*____________
        INC BX                                ;____________*____________
        MOV [BX],' '                          ;____________*____________
        INC BX                                ;____________*____________
        MOV DX,HITS                           ;____________*____________
        ADD DX,48D                            ;____________*____________
        MOV [BX],DX                           ;____________*____________
        INC BX
        MOV [BX],'*'
        INC BX
        MOV [BX],13 
        XOR BX,BX
        ;******************************************
        ;LOAD FILE HANDLER
        MOV DX,OFFSET FILE
        MOV AL,1
        MOV AH,3DH
        INT 21H
        
        ;APPENDING FILE
        MOV BX,AX
        MOV CX,0
        MOV AH,42H
        MOV AL,02H
        INT 21H
        
        ;WRITING FILE
        MOV CX,16; SHOULD HAVE BEEN 1 LESS THAN LENGTH OF MSG.
        MOV DX,OFFSET MSG
        MOV AH,40H
        INT 21H
        
        ;CLOSE FILE
        MOV AH,3EH
        INT 21H
        ;******************************************
        CMP MISS, 9
        JE LOSS
        JMP WIN
        LOSS:
        MOV DX, OFFSET GAME_OVER_STR_LOSS
        MOV AH,09H
        INT 21H
        JMP AGAIN
        WIN:
        MOV DX, OFFSET GAME_OVER_STR_WIN
        MOV AH,09H
        INT 21H
         
         
         
        AGAIN:
        MOV CL, ' '                           ;HIDE LAST OF SCREEN BALLOON
        MOV CH, 1111B 
        MOV BX,ARROW_POS                      
        
        MOV CL, ' '                           ;HIDE PLAYER
        MOV CH, 1111B 
        MOV BX,PLAYER_POS  
     
        
        ;RESET VALUE                          ;UPDATE VERIABLE FOR START AGAIN
        MOV MISS, 0D
        MOV HITS,0D
        
        MOV PLAYER_POS, 1760D
    
        MOV ARROW_POS, 0D
        MOV ARROW_STATUS, 0D 
        MOV ARROW_LIMIT, 22D                  ;150D
    
        MOV LOON_POS, 3860D                   ;3990D
        MOV LOON_STATUS, 0D
             
        MOV DIRECTION, 0D
                                               ;WAIT FOR INPUT
        INPUT:  
            CALL NEWLINE
            
            MOV AH,1
            INT 21H
            CMP AL,'1'
            JE SHOW
            
            CMP AL,'2'
            JE AGAIN1
            
            CMP AL,'3'
            JE EXITS
            
            JMP INPUT
            
            CALL NEWLINE  
            
            SHOW:
            CALL CLEAR_SCREEN
            ;*****READ FILE
            MOV AH,3DH
            MOV DX,OFFSET(FILE)
            MOV AL,0
            INT 21H
            MOV HANDLE,AX
            
            MOV AH,3FH
            MOV BX,HANDLE
            MOV DX,OFFSET(BUFFER)
            MOV CX,1000
            INT 21H
            
            ;****DISPLY 10 BYTES
            MOV SI,OFFSET(BUFFER)
            L1:
            CMP [SI],'*'
            JE SPACE
            CMP [SI],'$'
            JE DEAD2
            
            PRINTC [SI]
            JMP DOWN
            
            SPACE:
            CALL NEWLINE
            DOWN: 
            INC SI
            DEC COUNT
            LOOP L1
            DEAD2:
            CALL NEWLINE
            PRINT "PRESS ENTER FOR EXIT"
            INPU:
            MOV AH,1
            INT 21H
            CMP AL,13D
            JNE INPU
            CALL CLEAR_SCREEN 
            JMP EXITS
            
            AGAIN1:
            CALL CLEAR_SCREEN
            JMP GAME_MENU
            
            EXITS:   
            CALL CLEAR_SCREEN
            MOV AH,4CH
            INT 21H
            
    HAVE_TOKEN:         
    CALL CLEAR_SCREEN
    PRINTS PASSWORD_USER
    MOV CX,4
    MOV SI,OFFSET UPASSWORD
    PASS:
    MOV AH,8
    INT 21H
    CMP AL,[SI]
    JNE WRONG 
    MOV BL,AL
    
    PRINTR '*'
    CMP CX,1
    JE CORRECT
    
    JMP Z1
                                           ;____________*LOADING CODE____________
    WRONG: 
    INC PASS1
    PRINTW '*'
    CMP CX,1
    JE CORRECT
    Z1:
    PRINTY '-'
    PRINTY '-'
    PRINTY '-'
    PRINTY '-' 
    
    INC SI
    LOOP PASS  
    CORRECT:
    PRINTC ' '
    PRINTC '|' 
    CALL NEWLINE         
    PRINTS END_MENU
    CALL NEWLINE 
    CALL NEWLINE
    
    MOV CX,20
    PRINTS LOADIN
    LOADING:
    PRINTR '|'
    LOOP LOADING
    PRINTC ' '
    PRINTC '>'
    PRINTY '.'
    PRINTW '.'
    PRINTR '.'
    CALL NEWLINE
    CMP PASS1,0
    JE TRUE
    
    PRINTS NOTFOUND
    MOV AH,8
    INT 21H
    MOV PASS1,0
    MOV AL,0
    CALL CLEAR_SCREEN
    JMP GAME_MENU
     
    TRUE: 
    PRINTS FOUND
    MOV AH,8
    INT 21H
    MOV PASS1,0
    MOV AL,0
    CALL CLEAR_SCREEN
    JMP BACK_MENU
    ;****************************************************************************************************************
    NO_TOKEN:
    CALL CLEAR_SCREEN
    PRINTS PASSWORD_ADMIN
    MOV CX,4
    MOV SI,OFFSET APASSWORD
    PASS0:
    MOV AH,8
    INT 21H
    CMP AL,[SI]
    JNE WRONG1 
    MOV BL,AL
    
    PRINTR '*'
    CMP CX,1
    JE CORRECT1
    
    JMP Z2
    
    WRONG1: 
    INC PASS3
    PRINTW '*'
    CMP CX,1
    JE CORRECT1
    Z2:
    PRINTY '-'
    PRINTY '-'
    PRINTY '-'
    PRINTY '-' 
    
    INC SI
    LOOP PASS0  
    CORRECT1:
    PRINTC ' '
    PRINTC '|'
    CALL NEWLINE          
    PRINTS END_MENU
    CALL NEWLINE 
    CALL NEWLINE
    
    MOV CX,20
    PRINTS LOADIN
    LOADING1:
    PRINTR '|'
    LOOP LOADING1
    PRINTC ' '
    PRINTC '>'
    PRINTY '.'
    PRINTW '.'
    PRINTR '.'
    CALL NEWLINE
    CMP PASS3,0
    JE TRUE1
    
    PRINTS NOTFOUND
    MOV AH,8
    INT 21H
    MOV PASS3,0
    MOV AL,0
    CALL CLEAR_SCREEN
    JMP GAME_MENU
     
    TRUE1: 
    PRINTS FOUND1
    MOV AH,8
    INT 21H
    MOV PASS3,0
    MOV AL,0
    CALL CLEAR_SCREEN
    JMP GAME_MENU   
    ;****************************************************************************************************************
    GAME_MENU:
                                               ;GAME MENU SCREEN
        
        
        PRINTS START
        MNU:
        MOV AH,1
        INT 21H
        
        CMP AL,'1'
        JE  HAVE_TOKEN
        
        CMP AL,'2'
        JE  NO_TOKEN
        JMP MNU
        
        
        BACK_MENU:
        PRINTS GAME_START_STR
        MOV SI,OFFSET NAME1                                       
        INPUT2:                                       ;WAIT FOR INPUT
            MOV AH,1
            INT 21H  
            
            CMP AL,13D
            JE  NEXT
            
            MOV [SI],AL
            INC SI
            
            JMP INPUT2
            
            NEXT:
            CALL CLEAR_SCREEN
            
            LEA BX,STATE_BUF                   ;DISPLAY SCORE
            CALL SHOW_SCORE 
            PRINTS STATE_BUF
        
            PRINTC 0DH
            
            JMP MAIN_LOOP
    
    EXIT_GAME:                                  ;END OF OUR SWEET GAME :)
    MOV EXIT,10D

MAIN ENDP



                                     ;;--------------------------------------------------------------------;;
                                     ;;                                                                    ;;
                                     ;;  SHOW SCORE IN SAME POSTION ON SCREEN                              ;;
                                     ;;  USING BASE POINTER TO GET SEGMENT OF VERIABLE                     ;;
                                     ;;                                                                    ;;
                                     ;;____________________________________________________________________;;



PROC SHOW_SCORE
    LEA BX,STATE_BUF
    
    MOV DX, HITS
    ADD DX,48D        ;48 ASCII = 0
    
    MOV [BX], 9D      ;9D ASCII = 4 SPACE
    MOV [BX+1], 9D
    MOV [BX+2], 9D
    MOV [BX+3], 9D
    MOV [BX+4], 'H'
    MOV [BX+5], 'I'                                        
    MOV [BX+6], 'T'
    MOV [BX+7], 'S'
    MOV [BX+8], ':'
    MOV [BX+9], DX
    
    MOV DX, MISS
    ADD DX,48D
    MOV [BX+10], ' '
    MOV [BX+11], 'M'
    MOV [BX+12], 'I'
    MOV [BX+13], 'S'
    MOV [BX+14], 'S'
    MOV [BX+15], ':'
    MOV [BX+16], DX
RET    
SHOW_SCORE ENDP 


                                    ;;--------------------------------------------------------------------;;
                                    ;;                                                                    ;;
                                    ;;  CLEAR THE SCEEN                                                   ;;
                                    ;;  JUST SET NEW TEXT MOOD FOR AVOIDING COMPLEXICITY                  ;;
                                    ;;                                                                    ;;
                                    ;;____________________________________________________________________;;
NEWLINE PROC
    PRINTC 0AH
    PRINTC 0DH
    RET
NEWLINE ENDP

CLEAR_SCREEN PROC
        MOV AH,0
        MOV AL,3
        INT 10H        
        RET
CLEAR_SCREEN ENDP

END MAIN
