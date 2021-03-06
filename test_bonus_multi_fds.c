#include <fcntl.h>
#include <stdio.h>
#include "../get_next_line_bonus.h"
#include <stdlib.h>

// TEST WITH MULTIPLE FDS
int main()
{
    char *line;
    int fd1;
    int fd2;

    line = NULL;
    fd1 = open("textfile1.txt", O_RDONLY);
    fd2 = open("textfile2.txt", O_RDONLY);
    get_next_line(fd1, &line);
    printf("%s\n", line);
    if (line)
    {
        free(line);
        line = NULL;
    }
    get_next_line(fd2, &line);
    printf("%s\n", line);
    if (line)
    {
        free(line);
        line = NULL;
    }
    get_next_line(fd1, &line);
    printf("%s\n", line);
    if (line)
    {
        free(line);
        line = NULL;
    }
    get_next_line(fd2, &line);
    printf("%s\n\n", line);
    if (line)
    {
        free(line);
        line = NULL;
    }
    close(fd1);
    close(fd2);
    system("leaks a.out > leaks.txt");
}
