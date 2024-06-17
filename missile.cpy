       UPDATE-MISSILE.
         IF NOT game-playing THEN
           NEXT SENTENCE
         END-IF
         PERFORM VARYING missile-i FROM 1 BY 1
         UNTIL missile-i > MAX-MISSILE
           CALL "b_CheckCollisionRecs2" USING BY VALUE
             player-rect m-x(missile-i) m-y(missile-i) 2 30
             RETURNING hit-player
           END-CALL
           IF hit-player EQUALS 1 THEN
             MOVE 3 TO game-state
             MOVE 0 TO m-x(missile-i)
             MOVE 0 TO m-y(missile-i)
             NEXT SENTENCE
           END-IF
           IF m-y(missile-i) GREATER THAN 0 AND LESS THAN 650 THEN
             ADD 5 TO m-y(missile-i)
           ELSE
             IF m-y(missile-i) GREATER OR EQUAL TO 650 THEN
               MOVE 0 TO m-y(missile-i)
               MOVE 0 TO m-x(missile-i)
             END-IF
           END-IF
         END-PERFORM
         SUBTRACT 0.1 FROM shoot-timer
         IF shoot-timer LESS OR EQUAL TO 0 THEN
           COMPUTE shoot-timer =
             7 + (FUNCTION RANDOM() * (enemy-count / 2))
           END-COMPUTE
           PERFORM VARYING enemy-i FROM 1 BY 1
           UNTIL enemy-i > MAX-ENEMY
             COMPUTE rand-m = FUNCTION RANDOM() * MAX-MISSILE
             IF rand-m < 10 AND enemy-rect-list(enemy-i) > 0 THEN
               PERFORM INSERT-MISSILE
               MOVE MAX-ENEMY TO enemy-i
             END-IF
           END-PERFORM
         END-IF.

       RESTART-MISSILE.
         PERFORM VARYING missile-i FROM 1 BY 1
         UNTIL missile-i > MAX-MISSILE
           MOVE 0 TO m-y(missile-i)
           MOVE 0 TO m-x(missile-i)
         END-PERFORM.

       INSERT-MISSILE.
         PERFORM VARYING missile-i FROM 1 BY 1
         UNTIL missile-i > MAX-MISSILE
           IF m-x(missile-i) EQUALS 0 THEN
             MOVE missile-i TO curr-m
             MOVE MAX-MISSILE TO missile-i
           END-IF
         END-PERFORM
         CALL "b_RectangleGetX" USING BY VALUE
           enemy-rect-list(enemy-i)
           RETURNING m-x(curr-m)
         END-CALL
         CALL "b_RectangleGetY" USING BY VALUE
           enemy-rect-list(enemy-i)
           RETURNING m-y(curr-m)
         END-CALL.

       DRAW-MISSILES.
         PERFORM VARYING missile-i FROM 1 BY 1
         UNTIL missile-i > MAX-MISSILE
           IF m-y(missile-i) GREATER THAN 0 THEN
             CALL "b_DrawRectangle" USING BY VALUE
               m-x(missile-i) m-y(missile-i)
               2 30 255 0 0 255
             END-CALL
           END-IF
         END-PERFORM.
