       INIT-PLAYER.
         CALL "b_CreateRectangle" USING
           BY VALUE player-x 550 75 10
           RETURNING player-rect
         END-CALL.
       
       UPDATE-PLAYER-MOVEMENT.
         CALL "b_IsKeyDown" USING
           BY VALUE rl-key-a
           RETURNING moving-key-1
         END-CALL
         CALL "b_IsKeyDown" USING
           BY VALUE rl-key-left
           RETURNING moving-key-2
         END-CALL
         IF moving-key-1 EQUALS 1 OR moving-key-2 EQUALS 1 THEN
           SUBTRACT PLAYER-MOVEMENT FROM player-x
           CALL "b_RectangleSetX" USING BY VALUE player-rect player-x
         END-IF
         CALL "b_IsKeyDown" USING
           BY VALUE rl-key-d
           RETURNING moving-key-1
         END-CALL
         CALL "b_IsKeyDown" USING
           BY VALUE rl-key-right
           RETURNING moving-key-2
         END-CALL
         IF moving-key-1 EQUALS 1 OR moving-key-2 EQUALS 1 THEN
           ADD PLAYER-MOVEMENT TO player-x
           IF player-x GREATER THAN 885 THEN
             MOVE 885 TO player-x
           END-IF
           CALL "b_RectangleSetX" USING BY VALUE player-rect player-x
         END-IF.

       DRAW-PLAYER.
         CALL "b_DrawRectangleRec" USING
           BY VALUE player-rect 255 255 255 255
         END-CALL.
