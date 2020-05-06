      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIZZ-BUZZ.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-NUM PIC 9(3) VALUE 0.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

       FIZZ-BUZZ-PRINT.
           IF FUNCTION MOD(WS-NUM, 15) = 0
                DISPLAY "fizzbuzz"

           ELSE IF FUNCTION MOD(WS-NUM, 3) = 0
                DISPLAY "fizz"

           ELSE IF FUNCTION MOD(WS-NUM, 5) = 0
                DISPLAY "buzz"

           ELSE
                DISPLAY WS-NUM
           END-IF.

           ADD 1 TO WS-NUM

       PERFORM FIZZ-BUZZ-PRINT UNTIL WS-NUM > 100

            STOP RUN.
       END PROGRAM FIZZ-BUZZ.
