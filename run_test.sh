#! /bin/bash

CC="gcc"
CFLAGS="-Wall -Wextra -Werror"
SRC="../get_next_line.c ../get_next_line_utils.c"

YELLOW="\033[0;33m"
RED="\033[1;31m"
GREEN="\033[1;32m"
RESET="\033[0m"

f_check_leaks() {
    if [[ $(cat leaks.txt | grep "0 leaks") ]]
    then
        printf $GREEN"NO LEAKS FOUND :)\n"$RESET
    else
        printf $RED"LEAKS FOUND, exiting :(\n"$RESET
        exit 1
    fi
}

printf $YELLOW$YELLOW"test: BUFFER_SIZE=-1\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=-1 $SRC test_basic.c && ./a.out
f_check_leaks
printf "\n"

printf $YELLOW"test: BUFFER_SIZE=0\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=0 $SRC test_basic.c && ./a.out
f_check_leaks
printf "\n"

printf $YELLOW"test: BUFFER_SIZE=1\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=1 $SRC test_basic.c && ./a.out
f_check_leaks
printf "\n"

printf $YELLOW"test: BUFFER_SIZE=8\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=8 $SRC test_basic.c && ./a.out
f_check_leaks
printf "\n"

printf $YELLOW"test: BUFFER_SIZE=32\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=32 $SRC test_basic.c && ./a.out
f_check_leaks
printf "\n"

printf $YELLOW"test: BUFFER_SIZE=9999\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=9999 $SRC test_basic.c && ./a.out
f_check_leaks
printf "\n"

printf $YELLOW"test: BUFFER_SIZE=1000000\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=1000000 $SRC test_basic.c && ./a.out
f_check_leaks
printf "\n"

printf $YELLOW"test: error management\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=8 $SRC test_error.c && ./a.out
f_check_leaks
printf "\n"

printf $YELLOW"test: input from standard input\n"$RESET
printf "go on, write some stuff\n"
printf $RED"(pass 'exit' to exit)\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=8 $SRC test_stdi.c && ./a.out
f_check_leaks

rm -f leaks.txt a.out