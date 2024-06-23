        >>SOURCE FORMAT IS FREE
*> Compile and run in Windows:
*> cobc -xj -free game-free.cbl raylib.c -O3 -lraylib -lgdi32 -lwinmm
identification division.
program-id. Invaders-Breaker.
data division.
working-storage section.
  01 downer pic S9 value -1.
  01 rl-quit pic 9 value 0.
  01 bg-color.
    05 bg-r pic 9(3) value 0.
    05 bg-g pic 9(3) value 0.
    05 bg-b pic 9(3) value 0.
procedure division.
main-procedure.
  call "InitWindow" using
    by value 960 640
    by reference "Invaders Breaker"
    on exception display "Error: raylib not found" upon syserr
  end-call
  call "SetTargetFPS" using by value 60.
  perform until rl-quit EQUALS 1
    call "BeginDrawing"
    call "b_ClearBackground" using by value 0 0 0 255
    call "b_DrawText" using
      by reference "Hello from COBOL!"
      by value 300 300 30 255 255 255 255
    end-call
    call "EndDrawing"
    call "WindowShouldClose" RETURNING rl-quit
  end-perform
  call "CloseWindow"
  goback.
