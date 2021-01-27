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


#ifndef TEAM_H_INCLUDED
#define TEAM_H_INCLUDED

#include <iostream>
#include <string>
#include <time.h>
#include <random>
#include "Player.h"

using namespace std;

class Team{
    //�� ���������� ��� ������ Team �� ���� ��� ��������.
    string colour;
    int numberOfWins;
    int numberOfMembers;
    int numberOfSupplies;

    //� ����� Team, ���� ���� �������� ��� ��� ��� ���������� ��� ���������� ��� �' �����, ����������� ��� ��� ����� �������, ������ ���� ������ ������������ ����� Player(������� 11 �������).
    Player playerList[11];
public:
    //�� constructors ��� ������, ����� ��� � destructor ���.
    Team();
    Team(string c, int wins, int members, int supplies);
    ~Team();

    //�� getters ��� �� setters ��� ��� 4 ����� ���������� ��� ������ ���, ��� ������������ ��� inline �����������.
    void setColour(string c) {colour=c;};
    string getColour() {return colour;};

    void setNumberOfWins(int wins) {numberOfWins=wins;};
    int getNumberOfWins() {return numberOfWins;};

    void setNumberOfMembers(int members) {numberOfMembers=members;};
    int getNumberOfMembers() {return numberOfMembers;};

    void setNumberOfSupplies(int supplies) {numberOfSupplies=supplies;};
    int getNumberOfSupplies() {return numberOfSupplies;};


    //� �������� getter ��� setter, �� ������ �������� ��� ��� ������ ��� �������, �� �������� ��� ������ Team.cpp, �� ��� ����������.
    void setPlayerList(int i,string n, string g, string job, int a,int wins,bool candidate);
    Player getPlayerList(int j);

};
#endif // TEAM_H_INCLUDED
