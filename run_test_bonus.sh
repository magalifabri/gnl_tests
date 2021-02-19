#! /bin/bash

YELLOW="\033[0;33m"
RESET="\033[0m"

printf $YELLOW"test: bonus: multiple fds\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=8 ../get_next_line_bonus.c ../get_next_line_utils_bonus.c test_bonus_multi_fds.c && ./a.out
