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

#include "TeamCompetition.h"

using namespace std;

//����� constructor.
TeamCompetition::TeamCompetition()
{
    foodAward=FoodAward();
    for (int i=0;i<3;i++) rounds[i]=Round();
}

//Constructor �� ��������.
TeamCompetition::TeamCompetition(int id, string name, FoodAward foodAward): Competition(id,name)    //��� ������� ��� ��� constructor ��� ������� ������.
{
    this->foodAward=foodAward;
    for (int i=0;i<3;i++) rounds[i]=Round();
}

//Destructor.
TeamCompetition::~TeamCompetition()
{
    cout<<"Team competition "<<name<<" is destroyed"<<endl;
}

//��������� ��������� ���������.
void TeamCompetition::status()
{
    Competition::status();  //�������������� ������� �������� ��������� ��� ��� status ��� ������� ������.
    foodAward.status();     //������� ��� status ��� ������������-������.
    for (int i=0;i<3;i++)
    {
        rounds[i].status();     //������� ��� status ��� ������������ rounds[i] ��� ���� i.
    }
    cout<<endl;
}

//��������� ���������� ��� ����������� ������ ��� ������.
int TeamCompetition::compete(Team &team1, Team &team2)
{
    int wins1=0;
    int wins2=0;
    for (int round=1;round<4;round++)
        {

            bool selected1[team1.getNumberOfPlayers()];     //������� �� false �� ���� ���� ��� ��� ���� �������� ��� �������.
            for (int j=0;j<team1.getNumberOfPlayers();j++)
            {
                selected1[j]=false;     //�� ������� ��� false.
            }
            int playerNum=0;
            int index;

            float meanTechnique1=0,meanFatigue1=0;
            while (playerNum<5)     //� while ���������� ���� ������� 5 ������� ��� ��� �����.
            {
                index=rand()%team1.getNumberOfPlayers();    //Random index ������ ��� 0 ��� ��� ������� ������� ���� ���.
                if (selected1[index]==false)    //������� ������ ���� ���� ����� false.
                {
                    team1.getPlayers()[index].compete();     //��������� compete ��� team.
                    selected1[index]=true;  //������� true ���� ������ �������� ������� ����� ��� �����, ���� �� ��� ������������.
                    meanTechnique1+=team1.getPlayers()[index].getTechnique();   //������� technique.
                    meanFatigue1+=team1.getPlayers()[index].getFatigue();   //������� fatigue.
                    playerNum++;
                }
            }
            meanTechnique1=meanTechnique1/5;
            meanFatigue1=meanFatigue1/5;        //����� ����.


            //������� �� ���� �������� ��� ��� ��� ����� 2.
            bool selected2[team2.getNumberOfPlayers()];
            for (int j=0;j<team2.getNumberOfPlayers();j++)
            {
                selected2[j]=false;
            }
            playerNum=0;

            float meanTechnique2,meanFatigue2;
            while (playerNum<5)
            {
                index=rand()%team2.getNumberOfPlayers();
                if (selected2[index]==false)
                {
                    team2.getPlayers()[index].compete();
                    selected2[index]=true;
                    meanTechnique2+=team2.getPlayers()[index].getTechnique();
                    meanFatigue2+=team2.getPlayers()[index].getFatigue();
                    playerNum++;
                }
            }
            meanTechnique2=meanTechnique2/5;
            meanFatigue2=meanFatigue2/5;


            //������ ������ �� ���� ��� ��������.
            if (meanTechnique1>meanTechnique2)
            {
                rounds[round-1]=Round(round,3*3600,team1.getColor());   //���������� ������������ i-���� ����� �� ���������� �����������.
                wins1++; //������ ����� ������ 1.
            }
            else if (meanTechnique1<meanTechnique2)     //������ ��� ����� 2.
            {
                rounds[round-1]=Round(round,3*3600,team2.getColor());
                wins2++;
            }
            else    //��������� ��� ����� ��� ���� �������.
            {
                if (meanFatigue1<meanFatigue2)
                {
                    rounds[round-1]=Round(round,3*3600,team1.getColor());
                    wins1++;
                }
                else
                {
                    rounds[round-1]=Round(round,3*3600,team2.getColor());
                    wins2++;
                }
            }
    }


    if (wins1>=2)   //���� ������ 1.
    {
        team1.setWins(team1.getWins()+1);   //������ �����.
        team1.setSupplies(team1.getSupplies()+foodAward.getBonusSupplies());    //������ ���������� ���� ��� �������.
        winner="Red";
        cout<<endl<<"WINNER INFO"<<endl;
        team1.status(false);    //�������� ������.
        cout<<endl<<"COMPETITION INFO"<<endl;
        status();   //�������� �����������.By default ������������ �� status ��� �������� ���� TeamCompetition.
        return 1;
    }
    else    //���������� ��� ��� ��� ����� 2.
    {
        team2.setWins(team2.getWins()+1);
        team2.setSupplies(team2.getSupplies()+foodAward.getBonusSupplies());\
        winner="Blue";
        cout<<endl<<"WINNER INFO"<<endl;
        team2.status(false);
        cout<<endl<<"COMPETITION INFO"<<endl;
        status();   //By default ������������ �� status ��� �������� ���� TeamCompetition.
        return 0;
    }
}
