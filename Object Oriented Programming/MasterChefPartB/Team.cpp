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
    Email: stefanospapadam@gmail . com
*/


#include "Team.h"

//����� constructor, �� ��������� ��� ������������ ����������� ����� ��������.
Team::Team(){
    colour="";
    numberOfMembers=0,numberOfSupplies=0,numberOfWins=0;
    for (int i=0;i<11;i++){
        playerList[i]=Player();
    }
}

//Constructor �� �����������. �� �������� �������� ��� �� main, ��� �� ����������� ���������� ��� ������������ �������� ���� �� ����.
Team::Team(string c, int wins, int members, int supplies){
    colour=c;
    numberOfWins=wins;
    numberOfMembers=members;
    numberOfSupplies=supplies;

    //������������ ��� ������ ������� �� "������" �������.
    for (int i=0;i<11;i++){
        playerList[i]=Player();
    }
}

//Destructor ��� ������ ���.
Team::~Team(){
    cout<<"";
    //�� ������ ���� ����� �� ���������� �� �������� �� �������� ��� ���������� ���������� ��� console...
    //�� ���� ���������, �������� ��� ���������� ����� ��� �� �������� ������.
}

//� setter ��� playerList, � ������ ������� ������ �������� ��� �� main, �� �� ����� ����� ��� ���� [i] ��� ������ ��� ���������� ������, �������� ��� constructor ��� ������.
void Team::setPlayerList(int i,string n, string g, string job, int a,int wins,bool candidate){
    playerList[i]=Player(n,g,job,a,wins,candidate);
    numberOfMembers+=1; //������, ������� ��� ������ ��� ����� ��� ������ ���� 1, ������ �������� ��� ������.
}

//� getter ��� playerList ����� Player, o ������ ������� ������ j, ��� ���������� ��� ������ ��� ���� j.
Player Team::getPlayerList(int j){
    return playerList[j];
}
