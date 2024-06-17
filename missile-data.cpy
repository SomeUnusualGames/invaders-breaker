       01 missile-data.
         78 MAX-MISSILE VALUE 100.
         05 curr-m PIC 9(3) VALUE 0.
         05 missile-i PIC 9(3).
         05 m-x PIC S9(4) OCCURS MAX-MISSILE TIMES.
         05 m-y PIC S9(4) OCCURS MAX-MISSILE TIMES.
         05 rand-m USAGE COMP-1.
         05 shoot-timer USAGE COMP-1 VALUE 5.0.
         05 hit-player PIC 9 VALUE 0.