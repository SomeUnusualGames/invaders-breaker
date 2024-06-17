       INIT-BACKGROUND.
         PERFORM VARYING dot-i FROM 1 BY 1 UNTIL dot-i > MAX-DOTS
           COMPUTE dot-x(dot-i) = FUNCTION RANDOM() * 960
           COMPUTE dot-y(dot-i) = FUNCTION RANDOM() * 640
         END-PERFORM.

       DRAW-BACKGROUND.
         PERFORM VARYING dot-i FROM 1 BY 1 UNTIL dot-i > MAX-DOTS
           CALL "b_DrawRectangle" USING BY VALUE
             dot-x(dot-i) dot-y(dot-i)
             1 1 255 255 255 255
           END-CALL
         END-PERFORM.
