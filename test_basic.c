#include <fcntl.h>
#include <stdio.h>
#include "../get_next_line.h"
#include <stdlib.h>

int main()
{
    char *line;
    int fd;
    int ret;

    fd = open("textfile.txt", O_RDONLY);
    while ((ret = get_next_line(fd, &line) > 0))
    {
        printf("ret: %d | %s\n", ret, line);
        free(line);
    }
    printf("ret: %d | %s\n", ret, line);
    if (ret != 0)
        free(line);
    close(fd);
    system("leaks a.out > leaks_test_basic.txt");
}