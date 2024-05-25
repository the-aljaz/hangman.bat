@echo off
setlocal EnableDelayedExpansion

rem Set the word to be guessed
set "WORD=hangman"

rem Set the maximum number of attempts
set "MAX_ATTEMPTS=6"

rem Initialize variables
set "guessed_word="
set "attempts=0"

:game_loop
cls

rem Display the hangman figure based on the number of attempts
echo Attempts left: %MAX_ATTEMPTS%
echo.
if %attempts% equ 0 (
    echo   _________
    echo   ^|       ^|
    echo   ^|
    echo   ^|
    echo   ^|
    echo   ^|
    echo  _^|_
) 
if %attempts% equ 1 (
    echo   _________
    echo   ^|       ^|
    echo   ^|       O
    echo   ^|
    echo   ^|
    echo   ^|
    echo  _^|_
) 
if %attempts% equ 2 (
    echo   _________
    echo   ^|       ^|
    echo   ^|       O
    echo   ^|       ^|
    echo   ^|
    echo   ^|
    echo  _^|_
) 
if %attempts% equ 3 (
    echo   _________
    echo   ^|       ^|
    echo   ^|       O
    echo   ^|      /^|
    echo   ^|
    echo   ^|
    echo  _^|_
) 
if %attempts% equ 4 (
    echo   _________
    echo   ^|       ^|
    echo   ^|       O
    echo   ^|      /^|\
    echo   ^|
    echo   ^|
    echo  _^|_
) 
if %attempts% equ 5 (
    echo   _________
    echo   ^|       ^|
    echo   ^|       O
    echo   ^|      /^|\
    echo   ^|      /
    echo   ^|
    echo  _^|_
) 
if %attempts% equ 6 (
    echo   _________
    echo   ^|       ^|
    echo   ^|       O
    echo   ^|      /^|\
    echo   ^|      / \
    echo   ^|
    echo  _^|_
)

echo.
echo Guessed Word: !guessed_word!
echo.

rem Check if the player has guessed the word
if "!guessed_word!" equ "%WORD%" (
    echo Congratulations! You've guessed the word: %WORD%
    goto :end_game
)

rem Check if the player has run out of attempts
if %attempts% geq %MAX_ATTEMPTS% (
    echo Game Over! The word was: %WORD%
    goto :end_game
)

rem Prompt the player for a guess
set /p "guess=Enter a letter guess: "

rem Validate the input
if not defined guess (
    echo Please enter a valid letter.
    pause
    goto :game_loop
)
if not "%guess%"=="" (
    set "valid_guess=false"
    for %%a in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
        if /i "%guess%"=="%%a" set "valid_guess=true"
    )
    if "!valid_guess!"=="false" (
        echo Please enter a valid letter.
        pause
        goto :game_loop
    )
)

rem Check if the guessed letter is in the word
set "found=false"
set "current_word=%WORD%"
for /l %%i in (0,1,6) do (
    set "letter=!current_word:~%%i,1!"
    if "!letter!"=="!guess!" (
        set "guessed_word=!guessed_word!!guess!"
        set "found=true"
    ) else (
        if not "!guessed_word:%%letter%%=!"=="!guessed_word!" (
            set "guessed_word=!guessed_word!!letter!"
        ) else (
            set "guessed_word=!guessed_word!_"
        )
    )
)


if "!found!"=="false" (
    echo Incorrect guess: %guess%
    set /a "attempts+=1"
)

pause
goto :game_loop

:end_game
pause
