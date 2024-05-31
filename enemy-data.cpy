       01 enemy-data.
         78 MAX-ENEMY VALUE 125.
         78 LINE-MAX VALUE 25.
         78 MAX-MOV-TIMER VALUE 90.
         78 ENEMY-SEPARATION VALUE 30.
         05 enemy-i PIC 9(3).
         05 enemy-first-x PIC 9(3) VALUE 20.
         05 enemy-first-y PIC 9(3) VALUE 50.
         05 enemy-x PIC S9(3) VALUE 20.
         05 enemy-y PIC S9(3) VALUE 50.
         05 enemy-check-x PIC 9(3).
         05 enemy-check-y PIC 9(3).
         05 enemy-rect-list PIC S9(4) OCCURS MAX-ENEMY TIMES
            INDEXED BY rect-i.
         05 enemy-mov-timer PIC 9(3) VALUE MAX-MOV-TIMER.
         05 leftmost-enemy PIC 9(3) VALUE 1.
         05 rightmost-enemy PIC 9(3) VALUE 25.
         05 current-mov PIC S9(3) VALUE 30.
