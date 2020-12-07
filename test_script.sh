YELLOW="\033[0;33m"
RESET="\033[0m"

printf $YELLOW$YELLOW"test: BUFFER_SIZE=-1\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=-1 ../get_next_line.c ../get_next_line_utils.c test_basic.c && ./a.out
printf "\n"
printf $YELLOW"test: BUFFER_SIZE=0\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=0 ../get_next_line.c ../get_next_line_utils.c test_basic.c && ./a.out
printf "\n"
printf $YELLOW"test: BUFFER_SIZE=1\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=1 ../get_next_line.c ../get_next_line_utils.c test_basic.c && ./a.out
printf "\n"
printf $YELLOW"test: BUFFER_SIZE=8\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=8 ../get_next_line.c ../get_next_line_utils.c test_basic.c && ./a.out
printf "\n"
printf $YELLOW"test: BUFFER_SIZE=32\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=32 ../get_next_line.c ../get_next_line_utils.c test_basic.c && ./a.out
printf "\n"
printf $YELLOW"test: BUFFER_SIZE=9999\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=9999 ../get_next_line.c ../get_next_line_utils.c test_basic.c && ./a.out
printf "\n"
printf $YELLOW"test: BUFFER_SIZE=1000000\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=1000000 ../get_next_line.c ../get_next_line_utils.c test_basic.c && ./a.out
printf "\n"
printf $YELLOW"test: error management\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=8 ../get_next_line.c ../get_next_line_utils.c test_error.c && ./a.out
printf "\n"
printf $YELLOW"test: input from standard input\n"$RESET
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=8 ../get_next_line.c ../get_next_line_utils.c test_stdi.c && ./a.out