#include <fcntl.h>
#include <stdio.h>
#include "../get_next_line.h"
#include <stdlib.h>

int main()
{
    char *line;

    // TEST: FD = -1
    printf("with fd = -1, get_next_line returns: %d\n", get_next_line(-1, &line));
    // TEST: FD = 1000000000
    printf("with fd = 1000000000, get_next_line returns: %d\n", get_next_line(1000000000, &line));

    system("leaks a.out > leaks.txt");
}
