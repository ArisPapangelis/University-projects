#include <stdio.h>

int main()
{
    int a,b,s,c;
    printf("Input the value of bit A:\n");
    scanf("%d", &a);
    printf("Input the value of bit B:\n");
    scanf("%d", &b);

    if (a==0 && b==0)
    {
        s=0;
        c=0;
    }
    else if (a==0 && b==1)
    {
        s=1;
        c=0;
    }
    else if (a==1 && b==0)
    {
        s=1;
        c=0;

    }
    else
    {
        s=0;
        c=1;
    }

    printf("The value of s is %d\n", s);
	printf("The value of c is %d", c);
	return 0;
}
