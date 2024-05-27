      * Compile and run in Windows:
      * cobc -xj main.cbl raylib.c -O3 -lraylib -lgdi32 -lwinmm
      * -fstatic-call -> statically link the program at compile time
       >>DEFINE DEBUG AS 0
       IDENTIFICATION DIVISION.
       PROGRAM-ID. INVADERS-BREAKER-COMMAND.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
         COPY player-data.
         COPY rl-keys.
         COPY enemy-data.
         01 rl-quit PIC 9 VALUE 0.
         01 bg-color.
           05 bg-r PIC 9(3) VALUE 0.
           05 bg-g PIC 9(3) VALUE 0.
           05 bg-b PIC 9(3) VALUE 0.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
         CALL "InitWindow" USING
           BY VALUE 960 640
           BY REFERENCE "Invaders Breaker Command"
           ON EXCEPTION
             DISPLAY "Error: raylib not found" UPON SYSERR
         END-CALL
         CALL "SetTargetFPS" USING BY VALUE 60.
         PERFORM INIT-PLAYER
         PERFORM INIT-ENEMY
         PERFORM UNTIL rl-quit EQUALS 1
           PERFORM UPDATE-PLAYER-MOVEMENT
           PERFORM UPDATE-ENEMY
           CALL "BeginDrawing"
           CALL "b_ClearBackground" USING BY VALUE 0 0 0 255
           PERFORM DRAW-PLAYER
           PERFORM DRAW-ENEMY
           >>IF DEBUG = 1
           CALL "DrawFPS" USING BY VALUE 0 0
           >>END-IF
           CALL "EndDrawing"
           CALL "WindowShouldClose" RETURNING rl-quit
         END-PERFORM
         CALL "CloseWindow"
         GOBACK.

       COPY player.
       COPY enemy.
