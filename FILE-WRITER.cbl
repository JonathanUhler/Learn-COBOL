      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILE-WRITER.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
                   SELECT FILE-TO-WRITE ASSIGN TO WS-FILE-PATH
                       ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD FILE-TO-WRITE.
           01 FILE-CONTENT.
               05 FILE-LINE PIC X(250).
       WORKING-STORAGE SECTION.
           01 WS-FILE-PATH PIC X(100).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Enter file path..."
           ACCEPT WS-FILE-PATH

           OPEN OUTPUT FILE-TO-WRITE
           DISPLAY "Enter file content when prompted..."

           PERFORM GET-FILE-CONTENT
           PERFORM UNTIL FILE-CONTENT = "save"
               WRITE FILE-CONTENT
               PERFORM GET-FILE-CONTENT
           END-PERFORM
           CLOSE FILE-TO-WRITE

            STOP RUN.

       GET-FILE-CONTENT.
           DISPLAY
               "Enter file information. Enter 'save' to save and quit"
           ACCEPT FILE-CONTENT.
