#include <stdio.h>

int yyparse(void);

int main()
{
    if (yyparse() == 0)
    {
        printf("Parsing completed successfully.\n");
    }

    return 0;
}