       UPDATE-BALL.
         IF game-idle THEN
           PERFORM UPDATE-IDLE-BALL
         ELSE
           IF game-playing THEN
             PERFORM UPDATE-BALL-MOVEMENT
           END-IF
         END-IF.
       
       UPDATE-IDLE-BALL.
         COMPUTE ball-x = player-x + 60
         MOVE 545 TO ball-y
         CALL "b_IsKeyPressed" USING
           BY VALUE rl-key-space
           RETURNING player-shoot-ball
         END-CALL
         IF player-shoot-ball EQUALS 1 THEN
           MOVE 2 TO game-state
         END-IF.

       UPDATE-BALL-MOVEMENT.
         COMPUTE new-ball-x = ball-x + ball-speed-x
         COMPUTE new-ball-y = ball-y + ball-speed-y
         PERFORM CHECK-BOUNDARIES THROUGH CHECK-ENEMIES
         MOVE new-ball-x TO ball-x
         MOVE new-ball-y TO ball-y
         IF ball-y GREATER THAN 650 THEN
           MOVE 3 TO game-state
         END-IF.

       CHECK-BOUNDARIES.
         IF new-ball-x LESS THAN 0 THEN
           COMPUTE ball-speed-x =
             0 - FUNCTION SIGN(ball-speed-x) * MAX-SPEED
           END-COMPUTE
           COMPUTE new-ball-x = ball-x + ball-speed-x
         END-IF
         IF new-ball-x GREATER THAN 960 THEN
           COMPUTE ball-speed-x =
             0 - FUNCTION SIGN(ball-speed-x) * MAX-SPEED
           END-COMPUTE
           COMPUTE new-ball-x = ball-x + ball-speed-x
         END-IF
         IF new-ball-y LESS THAN 10 THEN
           COMPUTE ball-speed-y =
             0 - FUNCTION SIGN(ball-speed-y) * MAX-SPEED
           END-COMPUTE
           COMPUTE new-ball-y = ball-y + ball-speed-y
         END-IF.

       CHECK-PADDLE.
         CALL "b_CheckCollisionCircleRec" USING
           BY VALUE new-ball-x new-ball-y ball-radius player-rect
           RETURNING ball-collide
         END-CALL
         IF ball-collide EQUALS 1 THEN
           SUBTRACT player-x FROM new-ball-x GIVING distance-paddle
           *> distance-paddle / PLAYER-WIDTH -> [0, 1]
           *> (distance-paddle / PLAYER-WIDTH) - 0.5 -> [-0.5, 0.5]
           COMPUTE ball-offset = (distance-paddle / PLAYER-WIDTH) - 0.5
           COMPUTE ball-speed-y = 0 - ball-speed-y
           *> TODO: is this value ok?  vvvv
           IF ball-offset IS LESS THAN -0.15 THEN
             COMPUTE ball-speed-x = 
               -(FUNCTION ABS(ball-speed-x)) + ball-offset
             END-COMPUTE
           END-IF
           IF ball-offset IS GREATER THAN 0.15 THEN
             COMPUTE ball-speed-x =
               FUNCTION ABS(ball-speed-x) + ball-offset
             END-COMPUTE
           *>ELSE
             *>COMPUTE ball-speed-x = 0 - ball-speed-x
           END-IF
         END-IF.

       CHECK-ENEMIES.
         PERFORM VARYING enemy-i FROM 1 BY 1 UNTIL enemy-i > MAX-ENEMY
           IF enemy-rect-list(enemy-i) GREATER THAN 0 THEN
             CALL "b_CheckCollisionCircleRec" USING BY VALUE
             new-ball-x new-ball-y ball-radius enemy-rect-list(enemy-i)
             RETURNING ball-collide
             END-CALL
             IF ball-collide EQUALS 1 THEN
               CALL "b_RectangleGetX" USING BY VALUE
                 enemy-rect-list(enemy-i)
                 RETURNING brick-x
               END-CALL
               CALL "b_RectangleGetY" USING BY VALUE
                 enemy-rect-list(enemy-i)
                 RETURNING brick-y
               END-CALL
               SUBTRACT 1 FROM enemy-count
               MOVE -1 TO enemy-rect-list(enemy-i)
               IF enemy-count EQUALS 0 THEN
                 MOVE 4 TO game-state
               END-IF
               IF enemy-i EQUALS leftmost-enemy THEN
                 PERFORM SET-NEW-LEFTMOST
               END-IF
               IF enemy-i EQUALS rightmost-enemy THEN
                 PERFORM SET-NEW-RIGHTMOST
               END-IF               
               *> WRONG!
               *>IF enemy-i EQUALS leftmost-enemy THEN
               *>  PERFORM SET-NEW-LEFTMOST
               *>ELSE IF enemy-i EQUALS rightmost-enemy THEN
               *>  PERFORM SET-NEW-RIGHTMOST
               *>END-IF
               ADD brick-y TO ENEMY-HEIGHT GIVING brick-bottom
               EVALUATE TRUE
                 WHEN new-ball-y GREATER OR EQUAL TO brick-bottom
                   COMPUTE ball-speed-y = 
                     0 - FUNCTION SIGN(ball-speed-y) * MAX-SPEED
                   END-COMPUTE
                   COMPUTE new-ball-y = ball-y + ball-speed-y
                 WHEN new-ball-y LESS OR EQUAL TO brick-y
                   COMPUTE ball-speed-y =
                     0 - FUNCTION SIGN(ball-speed-y) * MAX-SPEED
                   END-COMPUTE
                   COMPUTE new-ball-y = ball-y + ball-speed-y
                 WHEN new-ball-x LESS OR EQUAL TO brick-x
                   COMPUTE ball-speed-x = 
                     0 - FUNCTION SIGN(ball-speed-x) * MAX-SPEED
                   END-COMPUTE
                   COMPUTE new-ball-x = ball-x + ball-speed-x
                 WHEN ball-x GREATER THAN brick-x
                   COMPUTE ball-speed-x =
                     0 - FUNCTION SIGN(ball-speed-x) * MAX-SPEED
                   END-COMPUTE
                   COMPUTE new-ball-x = ball-x + ball-speed-x
               END-EVALUATE
               *> This is wrong don't do this or you will be fired
               *>IF new-ball-y GREATER OR EQUAL TO brick-bottom THEN
               *>  COMPUTE ball-speed-y = 
               *>    0 - FUNCTION SIGN(ball-speed-y) * MAX-SPEED
               *>  END-COMPUTE
               *>  COMPUTE new-ball-y = ball-y + ball-speed-y
               *>ELSE IF new-ball-y LESS OR EQUAL TO brick-y THEN
               *>  COMPUTE ball-speed-y =
               *>    0 - FUNCTION SIGN(ball-speed-y) * MAX-SPEED
               *>  END-COMPUTE
               *>  COMPUTE new-ball-y = ball-y + ball-speed-y
               *>ELSE IF new-ball-x LESS OR EQUAL TO brick-x THEN
               *>  COMPUTE ball-speed-x = 
               *>    0 - FUNCTION SIGN(ball-speed-x) * MAX-SPEED
               *>  END-COMPUTE
               *>  COMPUTE new-ball-x = ball-x + ball-speed-x
               *>ELSE IF ball-x GREATER THAN brick-x THEN
               *>  COMPUTE ball-speed-x =
               *>    0 - FUNCTION SIGN(ball-speed-x) * MAX-SPEED
               *>  END-COMPUTE
               *>  COMPUTE new-ball-x = ball-x + ball-speed-x
               *>END-IF
               NEXT SENTENCE
             END-IF
         END-PERFORM.

       DRAW-BALL.
         CALL "b_DrawCircle" USING BY VALUE
           ball-x ball-y ball-radius 90 90 90 255
         END-CALL.
