      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BIO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-NAME PIC A(30) VALUE "name".
           01 WS-AGE PIC 9(2) VALUE 0.
           01 WS-GRADE PIC 9(2) VALUE 0.
           01 WS-SCHOOL PIC A(40) VALUE "school".
           01 WS-PRINT-INFO PIC A(1) VALUE "y".
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            DISPLAY "Enter your name..."
            ACCEPT WS-NAME
            DISPLAY "Enter your age..."
            ACCEPT WS-AGE
            DISPLAY "Enter your grade number..."
            ACCEPT WS-GRADE
            DISPLAY "Enter the name of your school..."
            ACCEPT WS-SCHOOL

            DISPLAY "Print information? y/n"
            ACCEPT WS-PRINT-INFO
            IF WS-PRINT-INFO = "y"
                DISPLAY "Name: "WS-NAME
                DISPLAY "Age: "WS-AGE
                DISPLAY "Grade: "WS-GRADE
                DISPLAY "School: "WS-SCHOOL

            STOP RUN.
       END PROGRAM BIO.
