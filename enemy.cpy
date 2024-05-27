       INIT-ENEMY.
         MOVE enemy-first-x TO enemy-x
         MOVE enemy-first-y TO enemy-y
         PERFORM VARYING enemy-i FROM 1 BY 1 UNTIL enemy-i > MAX-ENEMY
           CALL "b_CreateRectangle" USING
             BY VALUE enemy-x enemy-y 26 15
             RETURNING enemy-rect-list(enemy-i)
           END-CALL
           ADD 30 TO enemy-x
           IF FUNCTION MOD(enemy-i, LINE-MAX) EQUALS 0 THEN
             MOVE enemy-first-x TO enemy-x
             ADD 30 TO enemy-y
           END-IF
         END-PERFORM.
       
       UPDATE-ENEMY.
         SUBTRACT 1 FROM enemy-mov-timer
         IF enemy-mov-timer EQUALS 0 THEN
           MOVE MAX-MOV-TIMER TO enemy-mov-timer
           IF current-mov GREATER THAN 0 THEN
             CALL "b_RectangleGetX" USING
               BY VALUE enemy-rect-list(rightmost-enemy)
               RETURNING enemy-check-x
             END-CALL
             IF enemy-check-x GREATER THAN 890 THEN
               ADD 30 TO enemy-first-y
               *>SUBTRACT 30 FROM enemy-first-x
               COMPUTE current-mov = current-mov - 2 * current-mov
             ELSE
               ADD current-mov TO enemy-first-x
             END-IF
           ELSE
             CALL "b_RectangleGetX" USING
               BY VALUE enemy-rect-list(leftmost-enemy)
               RETURNING enemy-check-x
             END-CALL
             IF enemy-check-x LESS OR EQUAL TO 20 THEN
               ADD 30 TO enemy-first-y
               COMPUTE current-mov = current-mov - 2 * current-mov
             ELSE
               ADD current-mov TO enemy-first-x
             END-IF
           END-IF
           MOVE enemy-first-x TO enemy-x
           MOVE enemy-first-y TO enemy-y
           PERFORM VARYING enemy-i FROM 1 BY 1 UNTIL enemy-i > MAX-ENEMY
             CALL "b_RectangleSetXY" USING
               BY VALUE enemy-rect-list(enemy-i) enemy-x enemy-y
             END-CALL
             ADD ENEMY-SEPARATION TO enemy-x
             IF FUNCTION MOD(enemy-i, LINE-MAX) EQUALS 0 THEN
               MOVE enemy-first-x TO enemy-x
               ADD ENEMY-SEPARATION TO enemy-y
             END-IF
           END-PERFORM
         END-IF.

       DRAW-ENEMY.
         MOVE enemy-first-x TO enemy-x
         MOVE enemy-first-y TO enemy-y
         PERFORM VARYING enemy-i FROM 1 BY 1 UNTIL enemy-i > MAX-ENEMY
           >>IF DEBUG = 1
           CALL "b_DrawRectangleRec" USING
             BY VALUE enemy-rect-list(enemy-i) 255 0 0 255
           >>END-IF
           CALL "DRAW-ENEMY-BODY" USING
             BY REFERENCE enemy-x enemy-y
           END-CALL
           ADD 30 TO enemy-x
           IF FUNCTION MOD(enemy-i, LINE-MAX) EQUALS 0 THEN
             MOVE enemy-first-x TO enemy-x
             ADD 30 TO enemy-y
           END-IF
         END-PERFORM.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. DRAW-ENEMY-BODY.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
         01 enemy-origin-x PIC 9(3).
         01 enemy-origin-y PIC 9(3).
         01 enemy-i PIC 9(3).
         01 enemy-offset-x PIC 9(3).
         01 enemy-offset-y PIC 9(3).
       LINKAGE SECTION.
         01 pos-x PIC 9(3).
         01 pos-y PIC 9(3).
       PROCEDURE DIVISION USING BY REFERENCE pos-x pos-y.
         PERFORM DRAW-BODY THROUGH DRAW-EYES
         GOBACK.

       DRAW-BODY.
         ADD 6 TO pos-x GIVING enemy-origin-x
         ADD 4 TO pos-y GIVING enemy-origin-y
         CALL "b_DrawRectangle" USING
           BY VALUE enemy-origin-x enemy-origin-y 14 8 255 255 255 255
         END-CALL.
       
       DRAW-ARMS.
         ADD 12 TO pos-y GIVING enemy-origin-y
         MOVE pos-x TO enemy-origin-x
         PERFORM VARYING enemy-i FROM 1 BY 1 UNTIL enemy-i > 12
           CALL "b_DrawPixel" USING
             BY VALUE enemy-origin-x enemy-origin-y 255 255 255 255
           END-CALL
           IF enemy-i LESS OR EQUAL TO 6 THEN
             ADD 25 TO pos-x GIVING enemy-offset-x
           ELSE
             COMPUTE enemy-offset-x = pos-x + 25 - (enemy-i - 6)
           END-IF
           CALL "b_DrawPixel" USING
             BY VALUE enemy-offset-x enemy-origin-y 255 255 255 255
           END-CALL
           IF enemy-i LESS THAN 6 THEN
             SUBTRACT 1 FROM enemy-origin-y
           ELSE
             ADD 1 TO enemy-origin-x
           END-IF
         END-PERFORM.

       DRAW-ANTENNAS.
         MOVE pos-y TO enemy-origin-y
         ADD 9 TO pos-x GIVING enemy-origin-x
         MOVE enemy-origin-x TO enemy-offset-x
         MOVE enemy-origin-y TO enemy-offset-y
         PERFORM VARYING enemy-i FROM 1 BY 1 UNTIL enemy-i > 5
           CALL "b_DrawPixel" USING
             BY VALUE enemy-origin-x enemy-origin-y 255 255 255 255
           END-CALL
           ADD 6 TO enemy-origin-x GIVING enemy-offset-x
           CALL "b_DrawPixel" USING
             BY VALUE enemy-offset-x enemy-origin-y 255 255 255 255
           END-CALL
           IF enemy-i LESS THAN 5 THEN
            ADD 12 TO enemy-origin-y GIVING enemy-offset-y
           ELSE
            ADD 8 TO enemy-origin-y GIVING enemy-offset-y
           END-IF
           CALL "b_DrawPixel" USING
             BY VALUE enemy-origin-x enemy-offset-y 255 255 255 255
           END-CALL
           CALL "b_DrawPixel" USING
             BY VALUE enemy-offset-x enemy-offset-y 255 255 255 255
           END-CALL
           IF enemy-i EQUALS 2 THEN
             ADD 1 TO enemy-origin-x
           ELSE
             ADD 1 TO enemy-origin-y
           END-IF
         END-PERFORM.

       DRAW-EYES.
         ADD 10 TO pos-x GIVING enemy-offset-x
         ADD 6 TO pos-y GIVING enemy-offset-y
         CALL "b_DrawRectangle" USING
           BY VALUE enemy-offset-x enemy-offset-y 2 2 0 0 0 255
         END-CALL
         ADD 4 TO enemy-offset-x
         CALL "b_DrawRectangle" USING
           BY VALUE enemy-offset-x enemy-offset-y 2 2 0 0 0 255
         END-CALL.
       END PROGRAM DRAW-ENEMY-BODY.