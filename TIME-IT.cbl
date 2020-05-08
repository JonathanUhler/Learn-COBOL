      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TIME-IT.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01  START-HHMMSSDD.
               05  START-HH PIC 9(2).
               05  START-MM PIC 9(2).
               05  START-SS PIC 9(2).
               05  START-DD PIC 9(2).
           01  END-HHMMSSDD.
               05  END-HH PIC 9(2).
               05  END-MM PIC 9(2).
               05  END-SS PIC 9(2).
               05  END-DD PIC 9(2).

           01  NO-DAYS PIC 9(3).

           01  START-TIME PIC 9(11).
           01  END-TIME PIC 9(11).
           01  DIFF-TIME PIC 9(11).

           01  DIFF-HHMMSSDD.
               05  DIFF-HH PIC 9(2).
               05  FILLER PIC X VALUE ':'.
               05  DIFF-MM PIC 9(2).
               05  FILLER PIC X VALUE ':'.
               05  DIFF-SS PIC 9(2).
               05  FILLER PIC X VALUE '.'.
               05  DIFF-DD PIC 9(2).

           01 WS-INPUT PIC X(10000).
       PROCEDURE DIVISION.
           ACCEPT START-HHMMSSDD FROM TIME.
           DISPLAY "Enter an input..."
           ACCEPT WS-INPUT
           CALL "ECHO-UTIL" USING WS-INPUT.
           ACCEPT END-HHMMSSDD FROM TIME.

           IF END-HHMMSSDD < START-HHMMSSDD
               THEN MOVE 1 TO NO-DAYS
           ELSE
               MOVE 0 TO NO-DAYS
           END-IF.

           MOVE 0 TO START-TIME END-TIME.

           COMPUTE START-TIME = START-HH * 60
           COMPUTE START-TIME = (START-TIME
                              + START-MM) * 60
           COMPUTE START-TIME = (START-TIME
                              + START-SS) * 100
           COMPUTE START-TIME = (START-TIME
                              + START-DD)

           COMPUTE END-TIME = NO-DAYS * 24
           COMPUTE END-TIME = (END-TIME
                              + END-HH) * 60
           COMPUTE END-TIME = (END-TIME
                              + END-MM) * 60
           COMPUTE END-TIME = (END-TIME
                              + END-SS) * 100
           COMPUTE END-TIME = (END-TIME
                               + END-DD)

           COMPUTE DIFF-TIME = (END-TIME - START-TIME).

           DIVIDE DIFF-TIME BY 100 GIVING DIFF-TIME REMAINDER DIFF-DD.
           DIVIDE DIFF-TIME BY 60 GIVING DIFF-TIME REMAINDER DIFF-SS.
           DIVIDE DIFF-TIME BY 60 GIVING DIFF-TIME REMAINDER DIFF-MM.
           MOVE DIFF-TIME TO DIFF-HH.

           DISPLAY "Program start: "START-HHMMSSDD.
           DISPLAY "Program end: "END-HHMMSSDD.
           DISPLAY "Program total run time: "DIFF-HHMMSSDD.

           GOBACK.
       END PROGRAM TIME-IT.
