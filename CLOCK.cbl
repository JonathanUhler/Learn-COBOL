      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CLOCK.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-CURRENT-DATE-DATA.
               05 WS-CURRENT-DATE.
                   10 WS-CURRENT-YEAR PIC 9(4).
                   10 WS-CURRENT-MONTH PIC 9(2).
                   10 WS-CURRENT-DAY PIC 9(2).
               05 WS-CURRENT-TIME.
                   10 WS-CURRENT-HOURS PIC 9(2).
                   10 WS-CURRENT-MINUTE PIC 9(2).
                   10 WS-CURRENT-SECOND PIC 9(2).
                   10 WS-CURRENT-MILLISECONDS PIC 9(2).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           MOVE FUNCTION CURRENT-DATE to WS-CURRENT-DATE-DATA
           DISPLAY "The current time is: "WS-CURRENT-YEAR"-"WS-CURRENT-M
      -    ONTH"-"WS-CURRENT-DAY" "WS-CURRENT-HOURS":"WS-CURRENT-MINUTE
      -    ":"WS-CURRENT-SECOND":"WS-CURRENT-MILLISECONDS.
       END PROGRAM CLOCK.
