      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MY-SORT.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
                   SELECT INPUT-FILE ASSIGN TO WS-FILE-PATH
                       ORGANIZATION IS LINE SEQUENTIAL.
                   SELECT WORK-FILE ASSIGN TO "Users/jonathan/Documents
      -            "/OpenCobolIDE/IO Files/sortwork.txt".
       DATA DIVISION.
           FILE SECTION.
           FD INPUT-FILE.
               01 NUMBER-IN PIC 9(10).
           SD WORK-FILE.
               01 NUMBER-WRK PIC 9(10).
       WORKING-STORAGE SECTION.
           01 WS-FILE-PATH PIC X(1000).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Enter file path..."
           ACCEPT WS-FILE-PATH

           SORT WORK-FILE ON ASCENDING KEY NUMBER-IN
               USING INPUT-FILE
               GIVING INPUT-FILE

           STOP RUN.
       END PROGRAM MY-SORT.
