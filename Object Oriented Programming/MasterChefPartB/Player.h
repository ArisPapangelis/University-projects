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


#ifndef PLAYER_H_INCLUDED
#define PLAYER_H_INCLUDED

#include <iostream>
#include <string>
#include <time.h>
#include <random>
using namespace std;

class Player{
    //�� ���������� ��� ������ Player �� ���� ��� ��������.
    string name,gender,profession;
    int age,numberOfWins;
    float skill,fatigue,popularity;
    bool eliminationCandidate;

public:
    //�� 2 constructors ��� ������, ����� ��� � destructor ���.
    Player();
    Player(string n, string g, string job, int a,int wins,bool candidate);
    ~Player();

    //��� ���������� �� getters ��� �� setters ��� ��� ���� ���������, �� ������ , ������ ������������ ���� ���� �����, ����� inline �����������.
    void setName(string n) {name=n;};
    string getName() {return name;};

    void setGender(string g) {gender=g;};
    string getGender() {return gender;};

    void setProfession(string job) {profession=job;};
    string getProfession () {return profession;};

    void setAge(int a) {age=a;};
    int getAge () {return age;};

    void setNumberOfWins(int wins) {numberOfWins=wins;};
    int getNumberOfWins() {return numberOfWins;};

    void setSkill (float s) {skill=s;};
    float getSkill () {return skill;};

    void setFatigue (float f) {fatigue=f;};
    float getFatigue () {return fatigue;};

    void setPopularity (float pop) {popularity=pop;};
    float getPopularity () {return popularity;};

    void setEliminationCandidate (bool cand) {eliminationCandidate=cand;};
    bool getEliminationCandidate () {return eliminationCandidate;};

    //��� ���������� �� ����������� ��� ������� ��� ������� �� ���� ��� ��������. ��������� � ���� ����� ��� ������ ����������, Player.cpp.
    void works();
    void socializes();
    void sleeps();
    void practices();
    void endOfWeek();
    void participates();
};
#endif // PLAYER_H_INCLUDED
