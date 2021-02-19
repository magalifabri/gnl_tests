#include <fcntl.h>
#include <stdio.h>
#include "../get_next_line.h"
#include <stdlib.h>

// TESTING STANDARD INPUT
int main()
{
    char *line;
    int fd = 0;
    int ret;

    line = NULL;
    while ((ret = get_next_line(fd, &line) > 0))
    {
        printf("ret: %d | %s\n", ret, line);
        system("leaks a.out > leaks_test_stdi.txt");
        free(line);
        line = NULL;
    }
    printf("ret: %d | %s\n", ret, line);
    if (line)
        free(line);
    close(fd);
}
