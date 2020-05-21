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
      * Initialize the account details file
                   SELECT ACCOUNT-DETAILS ASSIGN TO "/Users/jonathan/Doc
      -            "uments/OpenCobolIDE/IO Files/accountinfo.txt"
                       ORGANIZATION IS INDEXED
                       ACCESS MODE IS DYNAMIC
                       RECORD KEY IS CREATE-ACCOUNT-ID.
                   SELECT BALANCE-DETAILS ASSIGN TO "/Users/jonathan/Doc
      -            "uments/OpenCobolIDE/IO Files/balance.txt"
                       ORGANIZATION IS INDEXED
                       ACCESS MODE IS DYNAMIC
                       RECORD KEY IS BALANCE-ID.
                   SELECT TRANSACTION-DETAILS ASSIGN TO "/Users/jonathan
      -            "/Documents/OpenCobolIDE/IO Files/transactions.txt"
                       ORGANIZATION IS INDEXED
                       ACCESS MODE IS DYNAMIC
                       RECORD KEY IS TRANSACTION-NUMBER
                       ALTERNATE RECORD KEY IS TRANSACTION-ID
                           WITH DUPLICATES.
       DATA DIVISION.
           FILE SECTION.
      * Account creation variables
           FD ACCOUNT-DETAILS.
               01 CREATE-ACCOUNT.
                   05 CREATE-PASSWORD PIC X(100).
                   05 CREATE-USERNAME PIC X(100).
                   05 CREATE-PASS-VALID PIC A(1).
                   05 CREATE-ACCOUNT-ID PIC 9(8).
           FD BALANCE-DETAILS.
               01 BALANCES.
                   05 BALANCE-ID PIC 9(8).
                   05 BALANCE-AMMOUNT PIC S9(10)V9(2).
           FD TRANSACTION-DETAILS.
               01 TRANSACTIONS.
                   05 TRANSACTION-NUMBER PIC 9(10).
                   05 TRANSACTION-DATE PIC 9(6).
                   05 TRANSACTION-ID PIC 9(8).
                   05 TRANSACTION-AMMOUNT PIC 9(10)V9(2).
                   05 TRANSACTION-SIGN PIC X(1).
       WORKING-STORAGE SECTION.
           01 WS-BANK-COMMAND PIC A(10).
           01 WS-PASSWORD-CHECK PIC X(100).
           01 WS-LOGGED-IN-CHECK PIC A(1).
      * File read/sign in variables
           01 READ-CONTENT.
               05 READ-PASSWORD PIC X(100).
               05 READ-USERNAME PIC X(100).
     *         05 READ-PASS-VALID PIC A(1).
               05 READ-ACCOUNT-ID PIC 9(8).
      * WS-READ-CONTENT is used to store the file data during the read
           01 WS-READ-CONTENT.
               05 WS-READ-USER PIC X(100).
               05 WS-READ-PASS PIC X(100).
               05 WS-READ-PASS-VALID PIC A(1).
               05 WS-READ-ACCOUNT-ID PIC 9(8).
      * Accoung manipulatioin
           01 WS-DEPOSIT-AMMOUNT PIC 9(10)V9(2).
           01 WS-WITHDRAW-AMMOUNT PIC 9(10)V9(2).
           01 WS-ACCOUNT-VALUE PIC S9(10)V9(2).
           01 WS-ACCOUNT-INTEREST PIC 9(1) VALUE 1.
           01 WS-DELETE-CONFIRM PIC A(1).
      * Transaction display information
           01 WS-EOF PIC 9(1).
           01 WS-AUDIT-MONTH PIC 9(2).
           01 WS-TRANSACTION-DATE PIC 9(8).
           01 WS-TRANSACTION-TIME PIC 9(8).
           01 WS-TRANSACTION-DATE-DATA PIC 9(16).
           01 WS-TRANSACTION-SUM PIC S9(10)V9(2).
           01 WS-TRANSACTIONS.
               05 WS-TRANSACTION-NUMBER PIC 9(10).
               05 WS-TRANSACTION-YEAR PIC 9(4).
               05 WS-TRANSACTION-MONTH PIC 9(2).
               05 WS-TRANSACTION-ID PIC 9(8).
               05 WS-TRANSACTION-AMMOUNT PIC 9(10)V9(2).
               05 WS-TRANSACTION-SIGN PIC X(1).
      * Auto generate seed
           01 WS-CURRENT-DATE-DATA.
               05 WS-CURRENT-DATE.
                 10 WS-CURRENT-YEAR PIC 9(4).
                 10 WS-CURRENT-MONTH PIC 9(2).
                 10  WS-CURRENT-DAY PIC 9(2).
               05  WS-CURRENT-TIME.
                   10  WS-CURRENT-HOURS PIC 9(2).
                   10  WS-CURRENT-MINUTE PIC 9(2).
                   10  WS-CURRENT-SECOND PIC 9(2).
                   10  WS-CURRENT-MILLISECONDS PIC 9(2).
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
                   MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-DATA
                   MOVE WS-CURRENT-TIME TO CREATE-ACCOUNT-ID
      * Set default balance info
                   MOVE CREATE-ACCOUNT-ID TO BALANCE-ID
                   MOVE 0 TO BALANCE-AMMOUNT
                   OPEN I-O BALANCE-DETAILS
                       WRITE BALANCES
                       INVALID KEY REWRITE BALANCES
                       END-REWRITE
                       END-WRITE
                   CLOSE BALANCE-DETAILS
      * Save new account info
                   OPEN I-O ACCOUNT-DETAILS
                       WRITE CREATE-ACCOUNT
                       INVALID KEY REWRITE CREATE-ACCOUNT
                       END-REWRITE
                       END-WRITE
                   CLOSE ACCOUNT-DETAILS
                   DISPLAY "Information saved! Your account ID is: "
                       CREATE-ACCOUNT-ID
               END-IF
           ELSE IF WS-BANK-COMMAND = "si"
               DISPLAY "Enter information when prompted"
               PERFORM GET-ACCOUNT-LOGIN
      * Check if user is logged in. If so display command reference
               IF WS-LOGGED-IN-CHECK = "y"
      * Fetch balance data
                   OPEN INPUT BALANCE-DETAILS
                       READ BALANCE-DETAILS INTO BALANCES
                       INVALID KEY
                           DISPLAY "Error: unknown balance, contact supp
      -                    "ort!"
                       NOT INVALID KEY MOVE BALANCE-AMMOUNT
                           TO WS-ACCOUNT-VALUE
                   CLOSE BALANCE-DETAILS
      * Command reference
                   DISPLAY "Enter 'help' for command help..."
                   ACCEPT WS-BANK-COMMAND
                   IF WS-BANK-COMMAND = "help"
                       PERFORM UNTIL WS-BANK-COMMAND = "so"
                           DISPLAY "Command help: deposit, withdraw, bal
      -                    "ance, interest, audit, sign off (so), delete
      -                    ""
                           ACCEPT WS-BANK-COMMAND
      * Deposit command
                           IF WS-BANK-COMMAND = "deposit"
                               DISPLAY "Enter an amount to deposit..."
                               ACCEPT WS-DEPOSIT-AMMOUNT
                               ADD WS-DEPOSIT-AMMOUNT
                                   TO WS-ACCOUNT-VALUE
      * Handling transaction for deposit
                               MOVE FUNCTION CURRENT-DATE
                                   TO WS-CURRENT-DATE-DATA
                               MOVE WS-CURRENT-DATE
                                   TO TRANSACTION-DATE
                               MOVE CREATE-ACCOUNT-ID
                                   TO TRANSACTION-ID
                               MOVE WS-DEPOSIT-AMMOUNT
                                   TO TRANSACTION-AMMOUNT
                               MOVE "+"
                                   TO TRANSACTION-SIGN
      * Generate a unique transaction number
                               MOVE WS-CURRENT-DATE
                                   TO WS-TRANSACTION-DATE
                               MOVE WS-CURRENT-TIME
                                   TO WS-TRANSACTION-TIME
                               ADD WS-TRANSACTION-DATE
                                   TO WS-TRANSACTION-TIME
                                   GIVING WS-TRANSACTION-DATE-DATA
                               ADD WS-TRANSACTION-DATE-DATA
                                   TO TRANSACTION-ID
                                   GIVING TRANSACTION-NUMBER
      * Write the transaction
                               OPEN I-O TRANSACTION-DETAILS
                                   WRITE TRANSACTIONS
                                   INVALID KEY
                                       DISPLAY
                                       "Transaction is being logged..."
                                       REWRITE TRANSACTIONS
                                   NOT INVALID KEY
                                       DISPLAY "Transaction logged succe
      -                                "ssfully..."
                                   END-REWRITE
                                   END-WRITE
                               CLOSE TRANSACTION-DETAILS
                               DISPLAY WS-DEPOSIT-AMMOUNT" has been adde
      -                        "d to your account"
      * Withdraw command
                           ELSE IF WS-BANK-COMMAND = "withdraw"
                               DISPLAY "Enter an amount to withdraw..."
                               ACCEPT WS-WITHDRAW-AMMOUNT
      * Handling transaction for withdraw
                               MOVE FUNCTION CURRENT-DATE
                                   TO WS-CURRENT-DATE-DATA
                               MOVE WS-CURRENT-DATE
                                   TO TRANSACTION-DATE
                               MOVE CREATE-ACCOUNT-ID
                                   TO TRANSACTION-ID
                               MOVE WS-WITHDRAW-AMMOUNT
                                   TO TRANSACTION-AMMOUNT
                               MOVE "-"
                                   TO TRANSACTION-SIGN
      * Generate a unique transaction number
                               MOVE WS-CURRENT-DATE
                                   TO WS-TRANSACTION-DATE
                               MOVE WS-CURRENT-TIME
                                   TO WS-TRANSACTION-TIME
                               ADD WS-TRANSACTION-DATE
                                   TO WS-TRANSACTION-TIME
                                   GIVING WS-TRANSACTION-DATE-DATA
                               ADD WS-TRANSACTION-DATE-DATA
                                   TO TRANSACTION-ID
                                   GIVING TRANSACTION-NUMBER
      * Write the transaction
                               OPEN I-O TRANSACTION-DETAILS
                                   WRITE TRANSACTIONS
                                   INVALID KEY
                                       DISPLAY
                                       "Transaction is being logged..."
                                       REWRITE TRANSACTIONS
                                   NOT INVALID KEY
                                       DISPLAY "Transaction logged succe
      -                                "ssfully..."
                                   END-REWRITE
                                   END-WRITE
                               CLOSE TRANSACTION-DETAILS
                               IF WS-WITHDRAW-AMMOUNT <=
                                   WS-ACCOUNT-VALUE
                                   SUBTRACT WS-WITHDRAW-AMMOUNT
                                       FROM WS-ACCOUNT-VALUE
                                   DISPLAY WS-WITHDRAW-AMMOUNT" has been
      -                            " removed from your account"
                               ELSE
                                   DISPLAY "You do not have sufficient f
      -                            "unds..."
                               END-IF
      * Interest print command
                           ELSE IF WS-BANK-COMMAND = "interest"
                               DISPLAY "Your interest rate is: "
                                   WS-ACCOUNT-INTEREST"%"
      * Balance command
                           ELSE IF WS-BANK-COMMAND = "balance"
                               DISPLAY "Your current balance is: "
                                   WS-ACCOUNT-VALUE
      * Monthly statement command
                           ELSE IF WS-BANK-COMMAND = "audit"
                               MOVE 0
                                   TO WS-EOF
                               MOVE 0
                                   TO WS-TRANSACTION-SUM
                               DISPLAY "Enter a month to recieve an audi
      -                        "t (enter the numeric value of the month)
      -                        "..."
                               ACCEPT WS-AUDIT-MONTH
                               MOVE READ-ACCOUNT-ID
                                   TO TRANSACTION-ID
                               OPEN INPUT TRANSACTION-DETAILS
                                   START TRANSACTION-DETAILS KEY
                                       IS EQUAL TO TRANSACTION-ID
                                       INVALID KEY DISPLAY "No transacti
      -                                "on history found for this user..
      -                                "."
                                   END-START
                                   READ TRANSACTION-DETAILS
                                       AT END SET WS-EOF TO 1
                                   END-READ
                                   PERFORM UNTIL WS-EOF IS EQUAL TO 1
                                       MOVE TRANSACTIONS
                                           TO WS-TRANSACTIONS
                                       IF READ-ACCOUNT-ID IS EQUAL
                                           TO TRANSACTION-ID
                                           IF WS-TRANSACTION-SIGN = "+"
                                               ADD
                                                  WS-TRANSACTION-AMMOUNT
                                                  TO WS-TRANSACTION-SUM
                                           ELSE
                                               SUBTRACT
                                                 WS-TRANSACTION-AMMOUNT
                                                 FROM WS-TRANSACTION-SUM
                                           END-IF
                                       END-IF
                                       IF READ-ACCOUNT-ID IS EQUAL
                                           TO TRANSACTION-ID
                                           IF WS-AUDIT-MONTH IS EQUAL
                                           TO WS-TRANSACTION-MONTH
                                               DISPLAY
                                                  WS-TRANSACTION-MONTH
                                                  "-"WS-TRANSACTION-YEAR
                                                   ": "
                                                  WS-TRANSACTION-SIGN
                                                  WS-TRANSACTION-AMMOUNT
                                          END-IF
                                       END-IF
                                       READ TRANSACTION-DETAILS
                                           AT END SET WS-EOF TO 1
                                       END-READ
                                   END-PERFORM
                               CLOSE TRANSACTION-DETAILS
                               IF WS-AUDIT-MONTH IS EQUAL
                                   TO WS-TRANSACTION-MONTH
                                   DISPLAY "Ammount changed: "
                                       WS-TRANSACTION-SUM
                               ELSE IF WS-AUDIT-MONTH IS NOT EQUAL
                                   TO WS-TRANSACTION-MONTH
                                   DISPLAY "No transactions found for th
      -                            "is month..."
                               END-IF
      * Delete account command
                           ELSE IF WS-BANK-COMMAND = "delete"
                               DISPLAY "Are you sure you want to permina
      -                        "tely delete your account? y/n"
                               ACCEPT WS-DELETE-CONFIRM
                               IF WS-DELETE-CONFIRM = "y"
                                   DISPLAY "Deleting account..."
                                   OPEN I-O ACCOUNT-DETAILS
                                       DELETE ACCOUNT-DETAILS RECORD
                                           INVALID KEY
                                               DISPLAY "Error: account d
      -                                        "oes not exist!"
                                           NOT INVALID KEY
                                               DISPLAY "Account: "
                                               CREATE-ACCOUNT-ID
                                               " removed..."
                                               MOVE "so"
                                                   TO WS-BANK-COMMAND
                                   CLOSE ACCOUNT-DETAILS
                               END-IF
      * Sign off command and save balance info
                           ELSE IF WS-BANK-COMMAND = "so"
                               DISPLAY "Signing off..."
                               MOVE WS-ACCOUNT-VALUE TO BALANCE-AMMOUNT
                               OPEN I-O BALANCE-DETAILS
                                   WRITE BALANCES
                                   INVALID KEY DISPLAY "Saving new balan
      -                            "ce..."
                                       REWRITE BALANCES
                                   NOT INVALID KEY DISPLAY "Information
      -                            "saved..."
                                   END-REWRITE
                                   END-WRITE
                               CLOSE BALANCE-DETAILS
                           ELSE
                               DISPLAY "Command not recognized..."
                           END-IF
                       END-PERFORM
                   END-IF
               END-IF
           ELSE
               DISPLAY "Command not recognized..."
           END-IF.
           STOP RUN.


      * Get account details to create and write to new account
       GET-ACCOUNT-CREATION.
           IF WS-BANK-COMMAND = "su"
               DISPLAY "Enter username..."
               ACCEPT CREATE-USERNAME.
               DISPLAY "Enter password..."
               ACCEPT WS-PASSWORD-CHECK.
               MOVE WS-PASSWORD-CHECK TO CREATE-PASSWORD
               DISPLAY "Confirm password..."
               ACCEPT CREATE-PASSWORD.
               IF CREATE-PASSWORD IS NOT EQUAL WS-PASSWORD-CHECK
                   DISPLAY "Passwords do not match..."
                   MOVE "n" TO CREATE-PASS-VALID
               ELSE
                   MOVE "y" TO CREATE-PASS-VALID
               END-IF.
      * Get account information and check with accountinfo.txt file
       GET-ACCOUNT-LOGIN.
           IF WS-BANK-COMMAND = "si"
               DISPLAY "Enter username..."
               ACCEPT READ-USERNAME.
               DISPLAY "Enter password..."
               ACCEPT READ-PASSWORD.
               DISPLAY "Enter account ID..."
               ACCEPT READ-ACCOUNT-ID
               MOVE READ-ACCOUNT-ID TO CREATE-ACCOUNT-ID
               MOVE READ-ACCOUNT-ID TO BALANCE-ID
               MOVE "y" TO READ-PASS-VALID
               OPEN INPUT ACCOUNT-DETAILS
               READ ACCOUNT-DETAILS INTO WS-READ-CONTENT
                   INVALID KEY DISPLAY "Account not recognized..."
                   NOT INVALID KEY DISPLAY
                       "ID accepted. Verrifying sign in..."
                       IF READ-CONTENT = WS-READ-CONTENT
                           DISPLAY
                               "Information accepted! Sign in complete"
                           MOVE "y" to WS-LOGGED-IN-CHECK
                       ELSE
                           DISPLAY "Information invalid. Try again..."
                       END-IF
               END-READ
               CLOSE ACCOUNT-DETAILS.
