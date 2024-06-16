      * Compile and run in Windows:
      * cobc -xj main.cbl raylib.c -O3 -lraylib -lgdi32 -lwinmm
      * -fstatic-call -> statically link the program at compile time
       >>DEFINE DEBUG AS 0
       IDENTIFICATION DIVISION.
       PROGRAM-ID. INVADERS-BREAKER.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
         COPY player-data.
         COPY rl-keys.
         COPY enemy-data.
         COPY ball-data.
         COPY background-data.
         COPY missile-data.
         01 rl-quit PIC 9 VALUE 0.
         01 bg-color.
           05 bg-r PIC 9(3) VALUE 0.
           05 bg-g PIC 9(3) VALUE 0.
           05 bg-b PIC 9(3) VALUE 0.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
         CALL "InitWindow" USING
           BY VALUE 960 640
           BY REFERENCE "Invaders Breaker"
           ON EXCEPTION
             DISPLAY "Error: raylib not found" UPON SYSERR
         END-CALL
         CALL "SetTargetFPS" USING BY VALUE 60.
         PERFORM INIT-BACKGROUND
         PERFORM INIT-PLAYER
         PERFORM INIT-ENEMY
         PERFORM UNTIL rl-quit EQUALS 1
           PERFORM UPDATE-PLAYER-MOVEMENT
           PERFORM UPDATE-ENEMY
           PERFORM UPDATE-BALL
           PERFORM UPDATE-MISSILE
           CALL "BeginDrawing"
           CALL "b_ClearBackground" USING BY VALUE 0 0 0 255
           PERFORM DRAW-BACKGROUND
           IF state-idle EQUALS 1 THEN
             CALL "b_DrawText" USING
               BY REFERENCE "Invaders Must Die!"
               BY VALUE 250 200 50 255 149 9 255
             END-CALL
             CALL "b_DrawText" USING
               BY REFERENCE "Press Space to start"
               BY VALUE 380 300 20 255 255 255 255
             END-CALL
           END-IF
           PERFORM DRAW-PLAYER
           PERFORM DRAW-ENEMY
           PERFORM DRAW-BALL
           PERFORM DRAW-MISSILES
           >>IF DEBUG = 1
           CALL "DrawFPS" USING BY VALUE 0 0
           >>END-IF
           CALL "EndDrawing"
           CALL "WindowShouldClose" RETURNING rl-quit
         END-PERFORM
         CALL "CloseWindow"
         GOBACK.

       COPY background.
       COPY player.
       COPY ball.
       COPY missile.
       COPY enemy.
