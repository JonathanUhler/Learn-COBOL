      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ECHO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-STATEMENT PIC X(250).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            DISPLAY "Input an alphanumeric statement..."
            ACCEPT WS-STATEMENT
            DISPLAY "Your statement was: "WS-STATEMENT
            STOP RUN.
       END PROGRAM ECHO.
