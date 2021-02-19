#include <fcntl.h> // open
#include <unistd.h> // read
#include <stdlib.h> // exit

int main(int ac, char **av)
{
    int     fd[2];
    char    buf[2][1];
    int     ret[2];

    fd[0] = open(av[1], O_RDONLY);
    fd[1] = open(av[2], O_RDONLY);
    while ((ret[0] = read(fd[0], buf[0], 1) > 0)
    && (ret[1] = read(fd[1], buf[1], 1) > 0))
        if (buf[0][0] != buf[1][0])
            return (1);
    // make sure fd[1] is caught up in case while stopped because fd[0] reached eof
    if (!ret[0])
        ret[1] = read(fd[1], buf[1], 1);
    // check if fd's match and return result
    if (buf[0][0] == buf[1][0] && ret[0] == ret[1])
        exit (0);
    else
        exit (1);
}