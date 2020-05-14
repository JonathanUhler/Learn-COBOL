      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. INDEX-TEST.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
                   SELECT INDEX-FILE ASSIGN TO WS-FILE-PATH
                       ORGANIZATION IS INDEXED
                       ACCESS MODE IS RANDOM
                       RECORD KEY IS FILE-CONTENT.
       DATA DIVISION.
           FILE SECTION.
           FD INDEX-FILE.
           01 FILE-CONTENT.
               05 FILE-MESSAGE PIC X(100).
       WORKING-STORAGE SECTION.
           01 WS-FILE-PATH PIC X(100).
           01 WS-FILE-CONTENT.
               05 WS-FILE-MESSAGE PIC X(100).
           01 WS-EOF PIC X(1).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            DISPLAY "Enter file path..."
            ACCEPT WS-FILE-PATH

            OPEN INPUT INDEX-FILE
               READ INDEX-FILE INTO FILE-CONTENT
               KEY IS FILE-CONTENT
            CLOSE INDEX-FILE

            STOP RUN.
       END PROGRAM INDEX-TEST.
