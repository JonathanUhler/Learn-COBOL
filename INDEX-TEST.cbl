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
                   SELECT OPTIONAL INDEX-FILE ASSIGN TO WS-FILE-PATH
                       ORGANIZATION IS INDEXED
                       ACCESS MODE IS DYNAMIC
                       FILE STATUS IS WS-FILE-STATUS
                       RECORD KEY IS MESSAGE-ID.
       DATA DIVISION.
           FILE SECTION.
           FD INDEX-FILE.
           01 FILE-CONTENT.
               05 FILE-MESSAGE PIC X(100).
               05 MESSAGE-ID PIC X(10).
       WORKING-STORAGE SECTION.
           01 WS-FILE-STATUS PIC 9(2).
           01 WS-FILE-PATH PIC X(100).
           01 WS-FILE-CONTENT.
               05 WS-FILE-MESSAGE PIC X(100).
               05 WS-MESSAGE-ID PIC X(10).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Enter file path..."
           ACCEPT WS-FILE-PATH
            
           DISPLAY "Enter search ID..."
           ACCEPT WS-MESSAGE-ID
           MOVE WS-MESSAGE-ID TO MESSAGE-ID
           OPEN INPUT INDEX-FILE
           READ INDEX-FILE INTO FILE-CONTENT
               INVALID KEY DISPLAY "Search unknown..."
               NOT INVALID KEY DISPLAY FILE-MESSAGE
              END-READ.
           CLOSE INDEX-FILE
       
       
      *>      DISPLAY "Enter message..."
      *>      ACCEPT FILE-MESSAGE
      *>      DISPLAY "Enter ID..."
      *>      ACCEPT MESSAGE-ID
      *>          OPEN I-O INDEX-FILE
      *>          REWRITE FILE-CONTENT
      *>          CLOSE INDEX-FILE
            
           STOP RUN.
       END PROGRAM INDEX-TEST.

