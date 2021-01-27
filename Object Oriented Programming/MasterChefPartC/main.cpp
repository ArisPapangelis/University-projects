/*  �������������: ������ ���������
    ���:8858
    ��������:6972464204
    Email: Thejokergr@hotmail.gr

    �������������: ����-���������� ����������
    ���:8883
    ��������:6946126130
    Email: aris.papagelis@gmail.com

    �������������: �������� �������
    ���:8885
    ��������:6987112819
    Email: stefanospapadam@gmail.com
*/

#include "Team.h"
#include <random>
#include <time.h>
#include "TeamCompetition.h"
#include "ImmunityCompetition.h"
#include "CreativityCompetition.h"
#include "FoodAward.h"
#include "ImmunityAward.h"
#include "ExcursionAward.h"

using namespace std;



// Index 0 = Red Team, Index 1 = Blue Team
Team teams[2] = {Team("Red"), Team("Blue")};
int competitionId = 0;
int loser=-1;   //�� ������� ������ ���� �� ��� ���������� � ImmunityDay �� ��� ������� ����� ������ ����� ��� ���� �����.
void menu();
void normalDay();
void teamCompetitionDay();
void immunityCompetitionDay();
void creativityCompetitionDay();

int main()
{
    time_t t;                           //������� initialize ��� random number generator.
    srand((unsigned)time(&t));
    menu();

    return 0;
}

void menu()
{
    int choice = -1;

    while(choice != 0)
    {
        cout << endl << "1.Normal Day." << endl;
        cout << "2.Team Competition Day." << endl;
        cout << "3.Immunity Competition Day." << endl;
        cout << "4.Creativity Competition Day." << endl;
        cout << "0.Quit" << endl;

        cin >> choice;

        switch(choice)
        {

        case 1:
            normalDay();
            break;
        case 2:
            teamCompetitionDay();
            break;
        case 3:
            if (loser!=-1) immunityCompetitionDay();    //������� ��� �� �� ������� ����� ��� ���� ����� ���� �� ������ � immunityCompetitionDay().
            else cout<<"No team has lost yet"<<endl;
            break;
        case 4:
            creativityCompetitionDay();
            break;
        case 0:
            break;
        default:
            cout << "Incorrect Input. Choose between 1 and 3. Press 0 to quit." << endl;

        }
    }
}

//��������� ��� �������� ��� �������� ���� ����������.
void normalDay()
{

    cout << endl << "This is a normal day in the Master Chef Game." << endl << endl;
    for (int i=0;i<2;i++)
    {
        teams[i].teamWorks();   //������ �������.
        teams[i].teamEats();    //������ ������.
        teams[i].teamEats();    //����������� ������.
        teams[i].teamSocializes();  //������� ��������.
        teams[i].teamSleeps();  //�������� �����.
    }
}

//��������� ��� �������� ��� ����� �������� ����������� ��� ��������.
void teamCompetitionDay()
{
    cout << endl << "This is a Team Competition day in the Master Chef Game." << endl << endl;
    for (int i=0;i<2;i++)
    {
        teams[i].teamWorks();
        teams[i].teamEats();
    }
    FoodAward foodAward("Lentils",false);   //���������� ������������ ������� �������.
    TeamCompetition teamComp(competitionId,"Lobster cooking",foodAward);    //���������� ������������ �������� �����������.
    competitionId++;    //������� �� �������� ����� ���������, ����� �������, ����� ��� ��������� ���� ��� ���� �����.
    loser=teamComp.compete(teams[0],teams[1]);  //������ ��� ������ ��� ����� ��� ���������� ��� �� �������� ���������, ���� �� �������������� ���� ��������� ����������� �������.
    for (int i=0;i<2;i++)
    {
        teams[i].teamEats();
        teams[i].teamSocializes();
        teams[i].teamSleeps();
    }

}

//��������� ��� �������� ��� ����� ����������� ������� ��� ��������.
void immunityCompetitionDay()
{

    cout << endl << "This is a Immunity Competition day in the Master Chef Game." << endl << endl;
    for (int i=0;i<2;i++)
    {
        teams[i].teamWorks();
        teams[i].teamEats();
    }
    ImmunityAward immunityAward("Immunity",true);   //���������� ������������ ������� �������.
    ImmunityCompetition immunityComp(competitionId,"Roast Beef cooking",immunityAward);     //���������� ������������ ����������� �������.
    competitionId++;
    if (loser==0) immunityComp.compete(teams[0]);   //����� ��� ��� ������� �����.
    else immunityComp.compete(teams[1]);    //����� ��� ��� ���� �����.
    for (int i=0;i<2;i++)
    {
        teams[i].teamEats();
        teams[i].teamSocializes();
        teams[i].teamSleeps();
    }
    loser=-1;   //���� �� ������� ����� ���� �� ��� ������ �� ���� ���� � ���� ����� ��� ���������� �������, �� ��� ���� ��������� ���� ������� ����������.
}

//��������� ��� �������� ��� ����� ����������� ���������������� ��� ��������.
void creativityCompetitionDay()
{

    cout << endl << "This is a Creativity Competition day in the Master Chef Game." << endl << endl;
    for (int i=0;i<2;i++)
    {
        teams[i].teamWorks();
        teams[i].teamEats();
    }
    ExcursionAward excursionAward("Trip to Botrini's restaurant",true);     //���������� ������������ ������� ��������.
    CreativityCompetition creativityComp(competitionId,"Spicy guacamole chicken cooking",excursionAward);   //���������� ������������ ����������� ����������������.
    competitionId++;
    creativityComp.compete(teams[0],teams[1]);      //����� ���������� �����������.
    for (int i=0;i<2;i++)
    {
        teams[i].teamEats();
        teams[i].teamSocializes();
        teams[i].teamSleeps();
    }
}
