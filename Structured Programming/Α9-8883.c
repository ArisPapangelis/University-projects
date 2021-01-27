#include <stdio.h>
#include <stdlib.h>

typedef struct{
    int number;
    char name[20];
    float balance;
}record;

int main(void)
{
    int choice;
    FILE *fp;
    //Creates the file bank.txt if it doesn't already exist
    fp=fopen("bank.txt", "a+");
    fclose(fp);
    char letter;
    record account;
    do
    {

        puts("Enter option, 1,2,3 or 4");
        scanf("%d", &choice);
        printf("\n");
        if (choice==1)
        {
            fp=fopen("bank.txt", "a+");
            puts("Enter account number,name and balance, in this order");
            scanf("%d%s%f",&account.number,account.name,&account.balance);
            fprintf(fp,"%-10d\t%-20s\t%-15.2f\n", account.number,account.name,account.balance);
            fclose(fp);
            system("cls");
        }

        else if (choice==2)
        {
            fp=fopen("bank.txt", "r+");
            printf("All accounts:\n\n");
            if (feof(fp)==0)
            {
                do
                {
                    letter=fgetc(fp);
                    printf("%c",letter);
                }while (feof(fp)==0);
            }
            printf("\n");
            fclose(fp);
        }

        else if (choice==3)
        {
            fp=fopen("bank.txt", "r+");
            printf("Accounts with zero balance:\n\n");
            int number1;
            char name1[50];
            float balance1;
            while (feof(fp)==0)
            {
                fscanf(fp,"%d\t%s\t%f\n", &number1,name1,&balance1);

                if (balance1==0)
                    printf("%-10d\t%-20s\t%-15.2f\n", number1,name1,balance1);

            }
            printf("\n");
        }

    }while (choice!=4);

    return 0;
}
