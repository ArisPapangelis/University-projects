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


#include "Player.h"

//����� constructor, �� ��������� ��� ������������ ����������� ����� ��������.
Player::Player(){
    name="",gender="",profession="";
    age=0,numberOfWins=0;
    skill=0,fatigue=0,popularity=0;
    eliminationCandidate=false;
}


//Constructor �� �����������. �� �������� �������� ��� �� main, ��� �� ����������� ���������� ��� ������������ �������� ���� �� ����.
Player::Player(string n, string g, string job, int a,int wins,bool candidate){
    name=n;
    gender=g;
    profession=job;
    age=a;
    numberOfWins=wins;
    eliminationCandidate=candidate;

    //����� �� ���������� ��������������� �� ������������� ����� ������� �� ��� ��������, ��� ��� �� �� ������� ����������. ���� skill ������, ��������� ������ ������� ��� 0% ��� 80%.
    skill=(float)(rand()%81);
    fatigue=0.0;
    popularity=50.0;
}

//Destructor ��� ������.
Player::~Player(){
    cout<<"";
    //�� ������ ���� ����� �� ���������� �� �������� �� �������� ��� ���������� ���������� ��� console...
    //�� ���� ���������, �������� ��� ���������� ����� ��� �� �������� ������.
}


//������������ ��� ������� ��� �������� ������.
void Player::works(){
    fatigue+=rand()%21 + 20;    //������ ���� ������ ������� ��� 20% ��� 40%.
    skill+=5*skill/100;     //���������� ������ ��� ��� ����� �������� ���� 5%.

    //��������� �� ��� ����� �� ���������� ����� �����.
    if (fatigue>100) fatigue=100;
    if (skill>100) skill=100;
}

//������������ ��� ��������������� ��� ������.
void Player::socializes(){
    popularity+= ((rand()%21)-10)*popularity/100; //���������� �������� ��� ��� ����� �������� ���� -10% ��� +10%.

    //��������� �� ��� ����� �� ���������� ����� �����.
    if (popularity>100) popularity=100;
    else if (popularity<0) popularity=0;
}

//������������ ��� ����� ���� ��� ������ ���� ��� ��������� ����.
void Player::sleeps(){
    fatigue=0;  //���������!
}

//������������ ��� ����� �������� ��� ������ ���� ��� ��������� ����.
void Player::practices(){
    skill+=5;   //������ ���� 5%.
    if (skill>100) skill=100; //��������� �� ��� ���� � ��������� ����� �����.
}

//��������� ��������� ��� �������� ������ ���� � �������� ��� ��������� ����.
void Player::endOfWeek(){
    int choice=rand()%2;
    if (choice==0) sleeps();
    else practices();
}

//������������ �� ��������� ��� ������ �� ����������.
void Player::participates(){
    fatigue+=((rand()%11)+10)*fatigue/100;  //���������� ������ ��� �������� ��� ��� ����� �������� ���� 10% ��� 20%
}
