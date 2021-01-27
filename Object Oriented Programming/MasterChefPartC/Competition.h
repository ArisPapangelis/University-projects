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

#ifndef COMPETITION_H_INCLUDED
#define COMPETITION_H_INCLUDED

#include <iostream>
#include <string>
#include "Team.h"

using namespace std;

//����� �����������, � ����� ������������� ��� ��� ��������� ���������� �����������.
class Competition
{

protected:
    int id;     //������� �����������.
    string name, winner;    //����� ��� ������� �����������, ����������.

public:
    Competition() {id=0; name=""; winner="";};  //����� constructor.
    Competition (int id, string name) {this->id=id; this->name=name; winner="";};   //Constructor �� ��������.
    ~Competition() {cout<<"";}; //���� ���� �������� ������� �������.����� � ����� ���� � ����� ��� ��������������� ��� ���������� ������������, ���� ������ ��� ���������������.

    int getId() {return id;};
    string getName() {return name;};            //Getters.
    string getWinner() {return winner;};

    void setId(int id) {this->id=id;};
    void setName(string name) {this->name=name;};           //Setters.
    void setWinner(string winner) {this->winner=winner;};

    void status() {cout<<"Id: "<<id<<endl<<"Competition name: "<<name<<endl<<"Winner: "<<winner<<endl;};    //��������� ��������� ��� ���������� ��� ������.

};


#endif // COMPETITION_H_INCLUDED
