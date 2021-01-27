#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int main(void)
{
    time_t t;
    srand(time(&t));
    int one=0,two=0,three=0,four=0,five=0,six=0;
    int dice,i;
    for (i=0;i<1000000;i++)
    {
        dice=1+rand()%6;
        if (dice==1)
        {
            one=one+1;
        }
        else if (dice==2)
        {
            two=two+1;
        }
        else if (dice==3)
        {
            three=three+1;
        }
        else if (dice==4)
        {
            four=four+1;
        }
        else if (dice==5)
        {
            five=five+1;
        }
        else
        {
            six=six+1;
        }

    }
    printf("Each number on the dice appeared the following number of times:\n\n");
    printf(" Ones: %d\n Twos: %d\n Threes: %d\n Fours: %d\n Fives: %d\n Sixes:%d\n",one,two,three,four,five,six);
    printf("Press enter to terminate the program");
    getchar();
    return 0;
}
