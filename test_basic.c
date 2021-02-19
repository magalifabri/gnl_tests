#include <fcntl.h>
#include <stdio.h>
#include "../get_next_line.h"
#include <stdlib.h>

int main()
{
    char *line;
    int fd;
    int ret;

    line = NULL;
    fd = open("textfile.txt", O_RDONLY);
    while ((ret = get_next_line(fd, &line) > 0))
    {
        printf("ret: %d | %s\n", ret, line);
        free(line);
        line = NULL;
    }
    printf("ret: %d | %s\n", ret, line);
    if (line)
        free(line);
    close(fd);
    system("leaks a.out > leaks.txt");
}