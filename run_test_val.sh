#! /bin/bash

CC="gcc"
CFLAGS="-g -Wall -Wextra -Werror"
SRC="../get_next_line.c ../get_next_line_utils.c"
VALGRIND="valgrind \
	--leak-check=full \
	--show-leak-kinds=all \
	--track-origins=yes \
	--log-file=valgrind-report.txt"

YELLOW="\033[0;33m"
RED="\033[1;31m"
GREEN="\033[1;32m"
RESET="\033[0m"

# Create the directory to store the output files in
mkdir outputs_actual > /dev/null 2>&1

# Create the compare_files executable
gcc compare_files.c -o compare_files

# Function to test for leaks
f_check_leaks() {
	if [[ $(grep "definitely lost: 0" valgrind-report.txt) \
	&& $(grep "indirectly lost: 0" valgrind-report.txt) ]]
	then
		printf $GREEN"LEAKS: OK\n"$RESET
	else
		printf $RED"LEAKS: KO, exiting\n"$RESET
		exit 1
	fi
}

# Function to compare the actual output to the expected (correct) output
f_check_output () {
	./compare_files ./outputs_actual/$1 ./outputs_expected/$1 \
	&& printf $GREEN"OUTPUT: OK\n"$RESET \
	|| printf $RED"OUTPUT: KO\n"$RESET
}

# Function that runs tests
f_run_test() {
	printf $YELLOW$2"\n"$RESET
	$CC $CFLAGS -D BUFFER_SIZE=$4 $SRC $3
	$VALGRIND ./a.out > ./outputs_actual/$1 2> /dev/null
	f_check_output $1
	f_check_leaks
	printf "\n"
}

# Tests with differing buffer sizes
# function	output file ($1)		test description ($2)		test source file ($3)	buffer size ($4)
f_run_test  buffer_size_-1.txt		test:BUFFER_SIZE=-1			test_basic.c			-1
f_run_test  buffer_size_0.txt		test:BUFFER_SIZE=0			test_basic.c			0
f_run_test  buffer_size_1.txt		test:BUFFER_SIZE=1			test_basic.c			1
f_run_test  buffer_size_8.txt		test:BUFFER_SIZE=8			test_basic.c			8
f_run_test  buffer_size_32.txt		test:BUFFER_SIZE=32			test_basic.c			32
f_run_test  buffer_size_9999.txt	test:BUFFER_SIZE=9999		test_basic.c			9999
f_run_test  buffer_size_1000000.txt	test:BUFFER_SIZE=1000000	test_basic.c			1000000

# Test error management
f_run_test  error_management.txt	test:error_management		test_error.c			8

# Test standard input
printf $YELLOW"test: input from standard input\n"$RESET
printf "go on, write some stuff\n"
printf $RED"(pass 'exit' to exit)\n"$RESET
$CC $CFLAGS -D BUFFER_SIZE=8 $SRC test_stdi.c && ./a.out
f_check_leaks

# Clean up
rm -f a.out
