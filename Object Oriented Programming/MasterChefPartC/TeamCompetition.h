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

#ifndef TEAMCOMPETITION_H_INCLUDED
#define TEAMCOMPETITION_H_INCLUDED

#include <iostream>
#include <string>
#include "FoodAward.h"
#include "Round.h"
#include "Competition.h"
#include "Team.h"

using namespace std;

//����� �������� �����������, ��� ���������� ��� ����� �����������.
class TeamCompetition:public Competition
{
    FoodAward foodAward;    //����������� ������� �������.
    Round rounds[3];    //������� ������������ �����.

public:
    TeamCompetition();  //����� constructor.
    TeamCompetition(int id, string name, FoodAward foodAward);  //Constructor �� ��������.
    ~TeamCompetition();     //Destructor.
    //��� �������������� pointers � �������� �����, ����� ��� ���������� �� �������� ���� ��� copy constructor.

    FoodAward getFoodAward() {return foodAward;};   //Getters.
    Round getRounds(int i) {return rounds[i];};

    void setFoodAward(FoodAward foodAward) {this->foodAward=foodAward;};    //Setters.
    void setRounds(Round r, int i) {rounds[i]=r;};

    void status();  //��������� ��������� ���������.

    int compete(Team &team1, Team &team2);  //��������� ���������� ����������� ������ ��� ��� ������.

};

#endif // TEAMCOMPETITION_H_INCLUDED
