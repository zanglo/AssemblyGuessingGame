INCLUDE asmlib.inc

.data
wMsg BYTE "Welcome to the dice guess game. It costs $1.00 to play." ,0
prompt BYTE " Would you like to continue? (y/n) " ,0
inprompt BYTE "Please enter your guess for the next roll. It costs $1.00 to play. if you guess correctly I will give you $100.00. " ,0
balance BYTE " Your bank is now $",0
win BYTE "Winner!",0
lose BYTE "Sorry you lose, the dice rolled a " ,0
exitMsg BYTE "Thanks for playing." ,0
bank DWORD 10
guess DWORD ?
response DWORD ?
yes DWORD "y"
numrand DWORD ?

.code

main PROC
mov edx, OFFSET wMsg
call writeLine
mov edx, OFFSET prompt
call writeString
call readChar
mov response, eax
mov edx, yes
cmp edx, response
je L1
jmp MYEXIT

L1:
mov eax, bank
sub eax, 1
mov bank, eax
mov edx, OFFSET inprompt
call writeString
call readInt
endl
mov guess, eax
mov eax, 0
call randSeed
mov eax, 6
call randRange
inc eax
mov numrand, eax
mov eax, numrand
cmp eax, guess
je WINNER
jmp LOSER


WINNER:
mov eax, bank
add eax, 100
mov bank, eax
mov edx, OFFSET win
call writeLine
mov edx, OFFSET balance
call writeString
mov eax, bank
call writeInt
endl
mov edx, OFFSET prompt
call writeString
call readChar
endl
mov response, eax
mov edx, yes
cmp edx, response
je L1
jmp MYEXIT

LOSER:
mov edx, OFFSET lose
call writeString
mov eax, numrand
call writeInt
mov edx, OFFSET balance
call writeString
mov eax, bank
call writeInt
mov edx, OFFSET prompt
call writeString
call readChar
endl
mov response, eax
mov edx, yes
cmp edx, response
je L1
jmp MYEXIT


MYEXIT:
mov edx, OFFSET exitMsg
call writeLine

exit
main ENDP
END main