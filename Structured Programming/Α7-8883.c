#include <stdio.h>
#include <ctype.h>

int main(void)
{
    int i;
    int count[26];
    for (i=0;i<26;i++)
    {
        count[i]=0;
    }
    int flag=0;
    char character;
    do{
        puts("Give a character(! to exit)");
        do{
            character=getchar();
            character=tolower(character);
            if ((character<97 || character>122)&& character!='!')
            {
                puts("You didn't enter a character, try again");
            }
            //H getchar diavazei apo to buffer, kai patwntas enter sto command line pairnei ton xarakthra \n an de valoume to sygkekrimeno getchar pou ousiastika kanei flush
            //to buffer pairnwntas to \n kai kanwntas to discard
            getchar();
            flag=flag+1;
        }while ((character<97 || character>122)&& character!='!');


        if (character!='!')
        {
            count[character-97]=count[character-97]+1;
        }



    } while (character!='!');

    printf("\nRavdogramma:\n\n");
    for (i=0;i<26;i++)
    {
        if (count[i]!=0)
        {
            printf("%c",(97+i));
            int j;
            for (j=0;j<count[i];j++)
                {
                    printf("*");
                }
            printf("\n\n");
        }

    }

    int min,max,pmin,pmax;
    min=30000;
    max=-1;
    for (i=0;i<26;i++)
    {
        if (count[i]<min && count[i]!=0)
        {
            min=count[i];
            pmin=i;
        }
        if (count[i]>max && count[i]!=0)
        {
            max=count[i];
            pmax=i;
        }
    }
    //Skopos tou flag einai na mhn vgalei lathos apotelesma to programma an o xrhsths eisagei kateytheian thavmastiko
    if (flag>1)
    {
        printf("The character %c appeared the highest number of times: %d\n", pmax+97, max);
        printf("The character %c appeared the lowest number of times: %d\n", pmin+97, min);
    }
    return 0;
}
