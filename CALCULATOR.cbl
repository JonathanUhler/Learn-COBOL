      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULATOR.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-A PIC 9(8).
           01 WS-B PIC 9(8).
           01 WS-ANS PIC 9(8).
           01 WS-OP PIC X(1).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Enter a number a..."
           ACCEPT WS-A
           DISPLAY "Enter a number b..."
           ACCEPT WS-B
           DISPLAY "Enter an operation (+, -, *, /)..."
           ACCEPT WS-OP
           IF WS-OP IS EQUAL TO '+'
               ADD WS-A TO WS-B GIVING WS-ANS
               DISPLAY "The answer is: "WS-ANS
           ELSE IF WS-OP IS EQUAL TO '-'
               SUBTRACT WS-A FROM WS-B GIVING WS-ANS
               DISPLAY "The answer is: "WS-ANS
           ELSE IF WS-OP IS EQUAL TO '*'
               MULTIPLY WS-A BY WS-B GIVING WS-ANS
               DISPLAY "The answer is: "WS-ANS
           ELSE IF WS-OP IS EQUAL TO '/'
               DIVIDE WS-A BY WS-B GIVING WS-ANS
               DISPLAY "The answer is: "WS-ANS
           ELSE
               DISPLAY WS-OP" is not a valid operation..."
           STOP RUN.
       END PROGRAM CALCULATOR.
