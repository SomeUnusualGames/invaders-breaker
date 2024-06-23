      * Compile and run on Windows:
      * cobc -xj main.cbl raylib.c -O3 -lraylib -lgdi32 -lwinmm
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
         01 game-data.
           05 restart-game PIC 9.
           05 rl-quit PIC 9 VALUE 0.
           05 game-state PIC 9 VALUE 1.
             88 game-idle VALUE 1.
             88 game-playing VALUE 2.
             88 game-restart VALUE 3.
             88 game-complete VALUE 4.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
         *>CALL "SetConfigFlags" USING BY VALUE 64
         CALL "InitWindow" USING
           BY VALUE 960 640
           BY REFERENCE "Invaders Breaker"
           ON EXCEPTION
             DISPLAY "Error: raylib not found" UPON SYSERR
         END-CALL
         CALL "SetTargetFPS" USING BY VALUE 60
         PERFORM INIT-BACKGROUND
         PERFORM INIT-PLAYER
         PERFORM INIT-ENEMY
         PERFORM UNTIL rl-quit EQUALS 1
           PERFORM UPDATE-PLAYER-MOVEMENT
           PERFORM UPDATE-ENEMY
           PERFORM UPDATE-BALL
           PERFORM UPDATE-MISSILE
           CALL "BeginDrawing"
           *>CALL "b_ClearBackground" USING BY VALUE 0 0 0 255
           CALL "ClearBackground" USING BY VALUE 0
           PERFORM DRAW-BACKGROUND
           EVALUATE TRUE
             WHEN game-idle PERFORM IDLE-SCREEN
             WHEN game-restart PERFORM RESTART-SCREEN
             WHEN game-complete PERFORM COMPLETE-SCREEN
           END-EVALUATE
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

       IDLE-SCREEN.
         CALL "b_DrawText" USING
           BY REFERENCE "Invaders Must Die!"
           BY VALUE 250 200 50 255 149 9 255
         END-CALL
         CALL "b_DrawText" USING
           BY REFERENCE "Press Space to start"
           BY VALUE 380 300 20 255 255 255 255
         END-CALL.

       RESTART-SCREEN.
         CALL "b_IsKeyPressed" USING
           BY VALUE rl-key-r
           RETURNING restart-game
         END-CALL
         IF restart-game EQUALS 1 THEN
           MOVE START-ENEMY-COUNT TO current-count
           PERFORM SET-INITIAL-VALUES
         END-IF
         CALL "b_DrawText" USING
           BY REFERENCE "You lose! Press R to restart"
           BY VALUE 300 200 30 255 0 0 255
         END-CALL.

       SET-INITIAL-VALUES.
         PERFORM RESET-ENEMY-VALUES
         PERFORM RESTART-MISSILE
         MOVE INITIAL-BALL-X TO ball-x
         MOVE INITIAL-BALL-Y TO ball-y
         MOVE INITIAL-PLAYER-X TO player-x
         MOVE ENEMY-SEPARATION-X TO current-mov
         MOVE START-ENEMY-COUNT TO enemy-count
         CALL "b_RectangleSetX" USING BY VALUE player-rect player-x
         MOVE 1 TO leftmost-enemy
         MOVE LINE-MAX TO rightmost-enemy
         MOVE 255 TO player-a
         MOVE 1 TO game-state
         MOVE 0 TO restart-game
         MOVE 3 TO ball-speed-x
         MOVE -3 TO ball-speed-y.

       COMPLETE-SCREEN.
         CALL "b_IsKeyPressed" USING
           BY VALUE rl-key-r
           RETURNING restart-game
         END-CALL
         IF restart-game EQUALS 1 THEN
           IF current-count LESS THAN MAX-ENEMY THEN
             ADD LINE-MAX TO current-count
           END-IF
           PERFORM SET-INITIAL-VALUES
         END-IF
         CALL "b_DrawText" USING
           BY REFERENCE "You won! Press R to continue"
           BY VALUE 300 200 30 0 255 0 255
         END-CALL.

       COPY background.
       COPY player.
       COPY ball.
       COPY missile.
       COPY enemy.
       END PROGRAM INVADERS-BREAKER.
