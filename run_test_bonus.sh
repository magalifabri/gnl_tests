#! /bin/bash

YELLOW="\033[0;33m"
RED="\033[1;31m"
GREEN="\033[1;32m"
RESET="\033[0m"

f_check_leaks() {
    if [[ $(cat leaks.txt | grep "0 leaks") ]]
    then
        printf $GREEN"LEAKS: OK\n"$RESET
    else
        printf $RED"LEAKS: KO, exiting\n"$RESET
        exit 1
    fi
}

printf $YELLOW"test: bonus: multiple fds\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=8 ../get_next_line_bonus.c ../get_next_line_utils_bonus.c test_bonus_multi_fds.c && ./a.out
f_check_leaks
