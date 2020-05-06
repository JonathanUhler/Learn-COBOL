      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
      * Write/read the specified file
                   SELECT ACCOUNT-DETAILS ASSIGN TO "/Users/jonathan/Doc
      -            "uments/OpenCobolIDE/IO Files/accountinfo.txt"
                       ORGANIZATION IS LINE SEQUENTIAL.
                   SELECT TRANSACTION-LOG ASSIGN TO "/Users/jonathan/Doc
      -            "uments/OpenCobolIDE/IO Files/transactions.txt"
                       ORGANIZATION IS LINE SEQUENTIAL.
                   SELECT BALANCE-LOG ASSIGN TO "/Users/jonathan/Documen
      -            "ts/OpenCobolIDE/IO Files/balance.txt"
                       ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD ACCOUNT-DETAILS.
      * Account write variables and information
           01 CREATION-CONTENT.
               05 CREATE-USER PIC X(100).
               05 CREATE-PASS PIC X(100).
               05 CREATE-PASS-VALID PIC A(1).
      * Used to wipe a file during 'deletion'
           01 CLEAR-FILE.
               05 NULL-FILE-DATA PIC A(4) VALUE "null".
           FD TRANSACTION-LOG.
      * Transaction write information
           01 TRANSACTION-CONTENT.
               05 TRANSACTION-TO-LOG PIC S9(7).
               05 TRANSACTION-SIGN PIC X(1).
      * Balance write information
           FD BALANCE-LOG.
           01 BALANCE-CONTENT.
               05 CURRENT-BALANCE PIC S9(10).
               05 BALANCE-SIGN PIC X(1).

       WORKING-STORAGE SECTION.
      * WS-PASSWORD is used to confirm password creation
           01 WS-BANK-COMMAND PIC A(10).
           01 WS-PASSWORD-CHECK PIC X(100).
           01 WS-END-OF-FILE PIC A(1).
           01 WS-LOGGED-IN-CHECK PIC A(1).
      * WS-READ-CONTENT is used to store the file data during the read
           01 WS-READ-CONTENT.
               05 WS-READ-USER PIC X(100).
               05 WS-READ-PASS PIC X(100).
               05 WS-READ-PASS-VALID PIC A(1).
      * File read/sign in variables
           01 READ-CONTENT.
               05 READ-USER PIC X(100).
               05 READ-PASS PIC X(100).
               05 READ-PASS-VALID PIC A(1) VALUE "y".
      * Accoung manipulatioin
           01 WS-DEPOSIT-AMMOUNT PIC 9(7).
           01 WS-WITHDRAW-AMMOUNT PIC 9(7).
           01 WS-ACCOUNT-VALUE PIC S9(10).
           01 WS-ACCOUNT-INTEREST PIC 9(1) VALUE 1.
           01 WS-DELETE-CONFIRM PIC A(1).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
      * Welcome screen accept si/su
           DISPLAY "Welcome to 'secure' banking"
           DISPLAY "Sign in or sign up? si/su"
           ACCEPT WS-BANK-COMMAND

      * Create new account - sign up and write file if password is valid
           IF WS-BANK-COMMAND = "su"
               DISPLAY "Enter information when prompted."
               PERFORM GET-ACCOUNT-CREATION
               IF CREATE-PASS-VALID = "y"
                   OPEN OUTPUT ACCOUNT-DETAILS
                   WRITE CREATION-CONTENT
                   CLOSE ACCOUNT-DETAILS
               END-IF

      * Sign up using presaved details
           ELSE IF WS-BANK-COMMAND = "si"
               DISPLAY "Enter information when prompted."
               PERFORM GET-ACCOUNT-LOGIN
               IF WS-LOGGED-IN-CHECK = "y"
      * Read account balance
                   OPEN INPUT BALANCE-LOG
                   READ BALANCE-LOG INTO WS-ACCOUNT-VALUE
                   CLOSE BALANCE-LOG
                   DISPLAY "Enter 'help' for command help..."
                   ACCEPT WS-BANK-COMMAND
      * Account management command look up
                   IF WS-BANK-COMMAND = "help"
                       PERFORM UNTIL WS-BANK-COMMAND = "so"
                           DISPLAY "Command help: deposit, withdraw, bal
      -                    "ance, interest, sign off (so), delete"
                           ACCEPT WS-BANK-COMMAND

                           IF WS-BANK-COMMAND = "deposit"
                               DISPLAY "Enter an ammount to deposit..."
                               ACCEPT WS-DEPOSIT-AMMOUNT
                               ADD WS-DEPOSIT-AMMOUNT
                                   TO WS-ACCOUNT-VALUE
                               MOVE WS-DEPOSIT-AMMOUNT
                                   TO TRANSACTION-TO-LOG
                               MOVE "+" TO TRANSACTION-SIGN
                               OPEN EXTEND TRANSACTION-LOG
                               WRITE TRANSACTION-CONTENT
                               CLOSE TRANSACTION-LOG
                               DISPLAY WS-DEPOSIT-AMMOUNT" has been adde
      -                        "d to your account"

                           ELSE IF WS-BANK-COMMAND = "withdraw"
                               DISPLAY "Enter an ammount to withdraw..."
                               ACCEPT WS-WITHDRAW-AMMOUNT
                               IF WS-WITHDRAW-AMMOUNT <=
                                   WS-ACCOUNT-VALUE
                                   SUBTRACT WS-WITHDRAW-AMMOUNT
                                       FROM WS-ACCOUNT-VALUE
                                   MOVE WS-WITHDRAW-AMMOUNT
                                       TO TRANSACTION-TO-LOG
                                   MOVE "-" TO TRANSACTION-SIGN
                                   OPEN EXTEND TRANSACTION-LOG
                                   WRITE TRANSACTION-CONTENT
                                   CLOSE TRANSACTION-LOG
                                   DISPLAY WS-WITHDRAW-AMMOUNT" has been rem
      -                            "oved from your account"
                               ELSE
                                   DISPLAY "You do not have sufficient f
      -                            "unds..."
                               END-IF


                           ELSE IF WS-BANK-COMMAND = "interest"
                               DISPLAY "Your interest rate is: "
                                   WS-ACCOUNT-INTEREST"%"

                           ELSE IF WS-BANK-COMMAND = "balance"
                               DISPLAY "Your current balance is: "
                                   WS-ACCOUNT-VALUE

                           ELSE IF WS-BANK-COMMAND = "delete"
                               DISPLAY "Are you sure you want to permina
      -                        "tely delete your account? y/n"
                               ACCEPT WS-DELETE-CONFIRM
                               IF WS-DELETE-CONFIRM = "y"
                                   DISPLAY "Deleting account..."
                                   OPEN OUTPUT ACCOUNT-DETAILS
                                   WRITE CLEAR-FILE
                                   CLOSE ACCOUNT-DETAILS
                               END-IF

                           ELSE IF WS-BANK-COMMAND = "so"
                               DISPLAY "Signing off..."
                               MOVE WS-ACCOUNT-VALUE TO BALANCE-CONTENT
                               OPEN OUTPUT BALANCE-LOG
                               WRITE BALANCE-CONTENT
                               CLOSE BALANCE-LOG
                       END-PERFORM
                   END-IF
               ELSE
                   DISPLAY "Account not recognized. Login failed..."
               END-IF

      * Terminate if command is invalid
           ELSE
               DISPLAY "Command not recognized...".

            STOP RUN.

      * Get account details to create and write to new account
       GET-ACCOUNT-CREATION.
           IF WS-BANK-COMMAND = "su"
               DISPLAY "Enter username..."
               ACCEPT CREATE-USER.
               DISPLAY "Enter password..."
               ACCEPT WS-PASSWORD-CHECK.
               DISPLAY "Save password..."
               ACCEPT CREATE-PASS.
               DISPLAY "Confirm password..."
               ACCEPT CREATE-PASS.
               IF CREATE-PASS IS NOT EQUAL WS-PASSWORD-CHECK
                   DISPLAY "Passwords do not match..."
                   MOVE "n" TO CREATE-PASS-VALID
               ELSE
                   MOVE "y" TO CREATE-PASS-VALID.

      * Get account login details to sign in
       GET-ACCOUNT-LOGIN.
           IF WS-BANK-COMMAND = "si"
               DISPLAY "Enter username..."
               ACCEPT READ-USER.
               DISPLAY "Enter password..."
               ACCEPT READ-PASS.
               OPEN INPUT ACCOUNT-DETAILS.
                   PERFORM UNTIL WS-END-OF-FILE='Y'
                       READ ACCOUNT-DETAILS INTO WS-READ-CONTENT
                       AT END MOVE 'Y' TO WS-END-OF-FILE
                       IF READ-CONTENT = WS-READ-CONTENT
                           DISPLAY "Information accepted. Login complete
      -                    "..."
                           MOVE "y" TO WS-LOGGED-IN-CHECK
                       END-READ
                   END-PERFORM.
               CLOSE ACCOUNT-DETAILS.
