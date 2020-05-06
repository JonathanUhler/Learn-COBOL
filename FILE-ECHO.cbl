      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILE-ECHO.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
                   SELECT FILE-TO-ECHO ASSIGN TO WS-FILE-PATH
                       ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD FILE-TO-ECHO.
           01 FILE-CONTENT.
               05 FILE-LINE PIC X(100).

       WORKING-STORAGE SECTION.
           01 WS-FILE-CONTENT.
               05 WS-FILE-LINE PIC X(100).
           01 WS-END-OF-FILE PIC A(1).
           01 WS-FILE-PATH PIC X(100).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Enter file path..."
           ACCEPT WS-FILE-PATH

           OPEN INPUT FILE-TO-ECHO.
               PERFORM UNTIL WS-END-OF-FILE='Y'
                   READ FILE-TO-ECHO INTO WS-FILE-CONTENT
                    AT END MOVE 'Y' TO WS-END-OF-FILE
                    NOT AT END DISPLAY WS-FILE-CONTENT
                   END-READ
               END-PERFORM.
           CLOSE FILE-TO-ECHO.
           STOP RUN.

       END PROGRAM FILE-ECHO.
