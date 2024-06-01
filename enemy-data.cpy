       01 enemy-data.
         78 MAX-ENEMY VALUE 75.
         78 LINE-MAX VALUE 25.
         78 ENEMY-WIDTH VALUE 26.
         78 ENEMY-HEIGHT VALUE 15.
         05 enemy-rect-list PIC S9(3) OCCURS MAX-ENEMY TIMES
            INDEXED BY rect-i.
         05 loop-data.
           10 enemy-i PIC 9(3).
           10 enemy-j PIC 9(3).
           10 enemy-limit-search PIC 9(3).
         05 posistion-data.
           78 ENEMY-SEPARATION-X VALUE 25.
           78 ENEMY-SEPARATION-Y VALUE 15.
           10 enemy-first-x PIC S9(3) VALUE ENEMY-SEPARATION-X.
           10 enemy-first-y PIC S9(3) VALUE 50.
           10 enemy-x PIC S9(3) VALUE ENEMY-SEPARATION-X.
           10 enemy-y PIC S9(3) VALUE 50.
           10 enemy-check-x PIC 9(3).
           10 enemy-check-y PIC 9(3).
         05 movement-data.
           78 MAX-MOV-TIMER VALUE 90.
           10 enemy-mov-timer PIC 9(3) VALUE MAX-MOV-TIMER.
           10 leftmost-enemy PIC 9(3) VALUE 1.
           10 rightmost-enemy PIC 9(3) VALUE LINE-MAX.
           10 current-mov PIC S9(3) VALUE ENEMY-SEPARATION-X.
