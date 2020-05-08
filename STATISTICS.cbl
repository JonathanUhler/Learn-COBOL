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
                       ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD STATISTICS-FILE.
           01 STATISTICS-NUMS.
               05 FS-NUMBER PIC 9(10).
       WORKING-STORAGE SECTION.
           01 WS-STATISTICS-NUMS.
               05 WS-NUMBER PIC 9(10).
           01 WS-FILE-PATH PIC X(1000).
           01 WS-COMMAND PIC X(4).
           01 WS-EOF PIC X(1).

           01 WS-SUM PIC 9(10) VALUE 0.
           01 WS-SUM-FINAL PIC 9(10) VALUE 0.
           01 WS-MEAN PIC 9(10) VALUE 0.
           01 WS-NUMBER-COUNT PIC 9(10) VALUE 0.
           01 WS-MAX PIC 9(10) VALUE 0.
           01 WS-MIN PIC 9(10) VALUE 9999999999999999.
           01 WS-RANGE PIC 9(10) VALUE 0.
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
               PERFORM UNTIL WS-COMMAND = "quit"
                   WRITE STATISTICS-NUMS
                   PERFORM GET-FILE-CONTENT
               END-PERFORM
               CLOSE STATISTICS-FILE
           ELSE IF WS-COMMAND = "stat"
               OPEN INPUT STATISTICS-FILE

               PERFORM UNTIL WS-EOF='Y'
                   READ STATISTICS-FILE INTO WS-STATISTICS-NUMS
                       AT END MOVE 'Y' TO WS-EOF
                       NOT AT END ADD 1 TO WS-NUMBER-COUNT
                   END-READ

               ADD FS-NUMBER TO WS-SUM
               SUBTRACT FS-NUMBER FROM WS-SUM GIVING WS-SUM-FINAL
               IF FS-NUMBER > WS-MAX
                   MOVE FS-NUMBER TO WS-MAX
               END-IF
               IF FS-NUMBER < WS-MIN
                   MOVE FS-NUMBER TO WS-MIN
               END-IF

               SUBTRACT WS-MAX FROM WS-MIN GIVING WS-RANGE
               DIVIDE WS-SUM-FINAL BY WS-NUMBER-COUNT GIVING WS-MEAN

               END-PERFORM
               CLOSE STATISTICS-FILE

               DISPLAY "Ammount of numbers: "WS-NUMBER-COUNT
               DISPLAY "Sum: "WS-SUM-FINAL
               DISPLAY "Max: "WS-MAX
               DISPLAY "Min: "WS-MIN
               DISPLAY "Range: "WS-RANGE
               DISPLAY "Mean: "WS-MEAN

           END-IF.
           STOP RUN.

       GET-FILE-CONTENT.
           DISPLAY "Enter numbers (less than 1e10 in length) to write. E
      -         "nter 'quit' to save and quit"
           ACCEPT WS-COMMAND.
           IF WS-COMMAND IS NOT EQUAL TO "quit"
               MOVE WS-COMMAND TO FS-NUMBER
           END-IF.
