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
        printf $GREEN"LEAKS: OK\n"$RESET
    else
        printf $RED"LEAKS: KO, exiting\n"$RESET
        exit 1
    fi
}

f_check_output () {
    ./compare_files ./outputs_actual/$1 ./outputs_expected/$1 \
    && printf $GREEN"OUTPUT: OK\n"$RESET \
    || printf $RED"OUTPUT: KO\n"$RESET
}

OUTPUT_FILE_NAME="buffer_size_-1.txt"
printf $YELLOW$YELLOW"test: BUFFER_SIZE=-1\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=-1 $SRC test_basic.c && ./a.out > ./outputs_actual/$OUTPUT_FILE_NAME
f_check_output $OUTPUT_FILE_NAME
f_check_leaks
printf "\n"

OUTPUT_FILE_NAME="buffer_size_0.txt"
printf $YELLOW"test: BUFFER_SIZE=0\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=0 $SRC test_basic.c && ./a.out > ./outputs_actual/$OUTPUT_FILE_NAME
f_check_output $OUTPUT_FILE_NAME
f_check_leaks
printf "\n"

OUTPUT_FILE_NAME="buffer_size_1.txt"
printf $YELLOW"test: BUFFER_SIZE=1\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=1 $SRC test_basic.c && ./a.out > ./outputs_actual/$OUTPUT_FILE_NAME
f_check_output $OUTPUT_FILE_NAME
f_check_leaks
printf "\n"

OUTPUT_FILE_NAME="buffer_size_8.txt"
printf $YELLOW"test: BUFFER_SIZE=8\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=8 $SRC test_basic.c && ./a.out > ./outputs_actual/$OUTPUT_FILE_NAME
f_check_output $OUTPUT_FILE_NAME
f_check_leaks
printf "\n"

OUTPUT_FILE_NAME="buffer_size_32.txt"
printf $YELLOW"test: BUFFER_SIZE=32\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=32 $SRC test_basic.c && ./a.out > ./outputs_actual/$OUTPUT_FILE_NAME
f_check_output $OUTPUT_FILE_NAME
f_check_leaks
printf "\n"

OUTPUT_FILE_NAME="buffer_size_9999.txt"
printf $YELLOW"test: BUFFER_SIZE=9999\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=9999 $SRC test_basic.c && ./a.out > ./outputs_actual/$OUTPUT_FILE_NAME
f_check_output $OUTPUT_FILE_NAME
f_check_leaks
printf "\n"

OUTPUT_FILE_NAME="buffer_size_1000000.txt"
printf $YELLOW"test: BUFFER_SIZE=1000000\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=1000000 $SRC test_basic.c && ./a.out > ./outputs_actual/$OUTPUT_FILE_NAME
f_check_output $OUTPUT_FILE_NAME
f_check_leaks
printf "\n"

OUTPUT_FILE_NAME="buffer_size_error.txt"
printf $YELLOW"test: error management\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=8 $SRC test_error.c && ./a.out > ./outputs_actual/$OUTPUT_FILE_NAME
f_check_output $OUTPUT_FILE_NAME
f_check_leaks
printf "\n"

# OUTPUT_FILE_NAME="buffer_size_stdin.txt"
printf $YELLOW"test: input from standard input\n"$RESET
printf "go on, write some stuff\n"
printf $RED"(pass 'exit' to exit)\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=8 $SRC test_stdi.c && ./a.out
# f_check_output $OUTPUT_FILE_NAME
f_check_leaks

rm -f leaks.txt a.out