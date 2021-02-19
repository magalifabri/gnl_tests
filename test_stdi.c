#include <fcntl.h>
#include <stdio.h>
#include "../get_next_line.h"
#include <stdlib.h>

int compare_strings(char *s1, char *s2)
{
	int i;

	i = 0;
	while (s1[i] && s2[i] && s1[i] == s2[i])
		i++;
	return ((s1[i] - s2[i]) == 0);
}

// TESTING STANDARD INPUT
int main(void)
{
    char    *line;
    int     fd = 0;
    int     ret;

    line = NULL;
    while ((ret = get_next_line(fd, &line) > 0))
    {
        if (compare_strings(line, "exit"))
            break ;
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
