#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct{
    int real;
    int imag;
}COMPLEX;

COMPLEX add(COMPLEX a, COMPLEX b)
{
    COMPLEX result;
    result.real=a.real+b.real;
    result.imag=a.imag+b.imag;
    return result;
}

COMPLEX sub(COMPLEX a, COMPLEX b)
{
    COMPLEX result;
    result.real=a.real-b.real;
    result.imag=a.imag-b.imag;
    return result;
}


int main(void)
{
    time_t t;
    srand(time(&t));
    COMPLEX addArray[50];
    COMPLEX subArray[50];
    int i;
    for (i=0;i<50;i++)
    {
        COMPLEX complex1;
        COMPLEX complex2;
        complex1.real=rand();
        complex1.imag=rand();
        complex2.real=rand();
        complex2.imag=rand();
        addArray[i]=add(complex1,complex2);
        subArray[i]=sub(complex1,complex2);
        printf("Loop number %d\n",i+1);
        printf("Result of addition: %d + %di\n", addArray[i].real, addArray[i].imag);
        printf("Result of subtraction: %d + %di\n\n", subArray[i].real, subArray[i].imag);
    }
    return 0;
}

