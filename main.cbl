      * Compile and run in Windows:
      * cobc -xj main.cbl raylib.c -O3 -lraylib -lgdi32 -lwinmm
       IDENTIFICATION DIVISION.
       PROGRAM-ID. INVADERS-BREAKER-COMMAND.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
         01 rl-quit PIC 9 VALUE 0.
         01 bg-color.
           05 bg-r PIC 9(3) VALUE 0.
           05 bg-g PIC 9(3) VALUE 0.
           05 bg-b PIC 9(3) VALUE 0.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
         CALL "InitWindow" USING
           BY VALUE 960 640
           BY REFERENCE "Invaders Breaker Commando"
           ON EXCEPTION
             DISPLAY "Error: raylib not found" UPON SYSERR
         END-CALL
         CALL "SetTargetFPS" USING BY VALUE 60.
         PERFORM UNTIL rl-quit EQUALS 1
           CALL "BeginDrawing"
           CALL "b_ClearBackground" USING BY VALUE 0 0 0 255
           CALL "b_DrawText" USING
             BY REFERENCE "Hello from COBOL!"
             BY VALUE 300 300 30 255 255 255 255
           END-CALL
           CALL "EndDrawing"
           CALL "WindowShouldClose" RETURNING rl-quit
         END-PERFORM
         CALL "CloseWindow"
         GOBACK.
