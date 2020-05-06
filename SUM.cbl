      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUM-NUMBERS.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-NUM1 PIC 9(8) VALUE 0.
           01 WS-NUM2 PIC 9(8) VALUE 0.
           01 WS-SUM PIC 9(8) VALUE 0.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            DISPLAY "Input 2 positive integers seperated by a carraige
      -     "return..."
            ACCEPT WS-NUM1
            ACCEPT WS-NUM2
            ADD WS-NUM1 WS-NUM2 TO WS-SUM
            DISPLAY WS-SUM
            STOP RUN.
       END PROGRAM SUM-NUMBERS.
