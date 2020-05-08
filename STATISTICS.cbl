      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. STATISTICS.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
                   SELECT STATISTICS-FILE ASSIGN TO WS-FILE-PATH
                       ORGANIZATION IS SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD STATISTICS-FILE.
           01 STATISTICS-NUMS.
               05 FS-NUMBER PIC 9(38).
       WORKING-STORAGE SECTION.
           01 WS-STATISTICS-NUMS.
               05 WS-NUMBER PIC 9(38).
           01 WS-FILE-PATH PIC X(1000).
           01 WS-COMMAND PIC X(4).
           01 WS-EOF PIC X(1).

           01 WS-SUM PIC 9(38).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Enter file path..."
           ACCEPT WS-FILE-PATH
           DISPLAY "Enter a command. 'stat' or 'edit'..."
           ACCEPT WS-COMMAND

           IF WS-COMMAND = "edit"
               OPEN OUTPUT STATISTICS-FILE
               DISPLAY "Enter file content when prompted..."

               PERFORM GET-FILE-CONTENT
               PERFORM UNTIL STATISTICS-NUMS = "quit"
                   WRITE STATISTICS-NUMS
                   PERFORM GET-FILE-CONTENT
               END-PERFORM
               CLOSE STATISTICS-FILE
           ELSE IF WS-COMMAND = "stat"
               OPEN INPUT STATISTICS-FILE.

               PERFORM UNTIL WS-EOF='Y'
                   READ STATISTICS-FILE INTO WS-STATISTICS-NUMS
                       AT END MOVE 'Y' TO WS-EOF
                       NOT AT END DISPLAY WS-STATISTICS-NUMS
                   END-READ
      * Compute sum
                   ADD WS-NUMBER TO WS-SUM
                   DISPLAY WS-SUM
               END-PERFORM.
               CLOSE STATISTICS-FILE.
           STOP RUN.

       GET-FILE-CONTENT.
           DISPLAY
               "Enter numbers to write. Enter 'quit' to save and quit"
           ACCEPT STATISTICS-NUMS.
      * Given a list of numbers, print the min, max, mean, range, and sum
