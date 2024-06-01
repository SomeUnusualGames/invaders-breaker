       01 ball-data.
         78 MAX-SPEED VALUE 3.
         05 state-idle PIC 9 VALUE 1.
         05 ball-collide PIC 9 VALUE 0.
         05 distance-paddle PIC S9(3).
         05 ball-x PIC S9(3) VALUE 360.
         05 ball-y PIC S9(3) VALUE 545.
         05 new-ball-x PIC S9(3).
         05 new-ball-y PIC S9(3).
         05 ball-speed-x USAGE COMP-1 VALUE 3.
         05 ball-speed-y USAGE COMP-1 VALUE -3.
         05 ball-radius USAGE COMP-1 VALUE 4.
         05 ball-offset USAGE COMP-1.
         05 ball-factor USAGE COMP-1.
         05 player-shoot-ball PIC 9.
         05 brick-x PIC S9(3).
         05 brick-y PIC S9(3).
         05 brick-right PIC S9(3).
         05 brick-bottom PIC S9(3).
