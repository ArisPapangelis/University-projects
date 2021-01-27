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
#include "Team.h"

//������� ������� ������� �� ��� ��������.
#define FOOD_PORTIONS 14

//��������� ��� ����������� ��� main.cpp.
Team playerInsert(Team T);
void teamStatus(Team T);
void playerStatus(Team T);


int main() {
    //������� �� seed ���� srand ��� ����� ��� ����������, ���� �� �������� �� ��������� �����-�������� �������� �� ��� rand().
    time_t t;
    srand((unsigned) time(&t));

    //������� �����.
    int choice;

    //������������ ��� 2 ������.
    Team Red("Red",0,0,0);
    Team Blue("Blue",0,0,0);

    do{
        //�� ����� ���.
        cout<<endl<<"Choose one of the following:"<<endl;
        cout<<"1.Insert a player in a team."<<endl;
        cout<<"2.Display team status."<<endl;
        cout<<"3.Display player status."<<endl;
        cout<<"4.Exit program."<<endl;

        bool failure;   //��������� ��� ���������� �� ������� �� ��������� �������� ����� int � ���.
        do{
            //������� ��� ������ �������. ����� ��� ����������� ����������� (1 ��� 4), �� ������ �� ��������� ��� ��� ��������� ��� ��� ����� string � �������,����� ���
            //����������� ������� �� buffer ���� ��� cin.clear() ��� cin.ignore() ���� �� ��� ������ ������ ��������� ��� ������.
            cin>>choice;
            failure=cin.fail(); //�� ������ type mismatch ������� �� true, ������ ����� false.

            if (failure || choice<1 || choice>4){    //�� ��������� ������ �������, �� ����� true ���� ��� choice. �� ��������� ��� ����� � ������� string, �� ����� true ���� ��� failure.
                                                //��� ���� 2 �����������, �� ��������� �� �� ����������, ����� �� �������� ������ �������. ������� ���� ������ ����������� ��� �� �������� ��������.
                cout<<"Invalid choice. Try again"<<endl;
                cin.clear(); //��������� �� error flags.
                cin.ignore(10000,'\n'); //������ ��� �������� ����� �������� ��� buffer.
            }
        } while (failure || choice<1 || choice>4);

        //��������� ���� ������������ � ������� ������.
        string teamChoice;

       switch (choice){
        //��������� 1: �������� ������ �� �����.
        case 1:
            cout<<endl<<"In which team do you want to put the player? (Red or Blue):"<<endl;

            //������� ������ ��� ������� �����������.
            do{
                cin>>teamChoice;
                if (teamChoice!="Red" && teamChoice!="Blue") cout<<"You must input Red or Blue"<<endl;
            }while (teamChoice!="Red" && teamChoice!="Blue");

            //����� ���������� ��� �������� ��� �������� ������, ������������� �� ����������� ����������� ����� Team.
            if (teamChoice=="Red"){
                if (Red.getNumberOfMembers()<=11) Red=playerInsert(Red);  //������� ��� �� �� � ����� ����� ������.
                else cout<<"Red team is full, make a different choice"<<endl;
            }

            else{
                if (Blue.getNumberOfMembers()<=11) Blue=playerInsert(Blue);
                else cout<<"Blue team is full, make a different choice"<<endl;
            }
            break;

        //��������� 2: ������� ���������� ������.
        case 2:
            cout<<endl<<"Which team's status do you want to display? (Red or Blue):"<<endl;

            //������� ������.
            do{
                cin>>teamChoice;
                if (teamChoice!="Red" && teamChoice!="Blue") cout<<"You must input Red or Blue"<<endl;
            }while (teamChoice!="Red" && teamChoice!="Blue");

            //����� ���������� ��� �������� ��� ���������� ��� �������� ��� ���������� ��� ������.
            if (teamChoice=="Red"){
                teamStatus(Red);
            }

            else{
                teamStatus(Blue);
            }
            break;

        //��������� 3: ������� ��� ���������� ���� ������, ���� ���� ����� ���� ���� index.
        case 3:
            cout<<endl<<"Which team does the player belong to? (Red or Blue):"<<endl;

            //������� ������.
            do{
                cin>>teamChoice;
                if (teamChoice!="Red" && teamChoice!="Blue") cout<<"You must input Red or Blue"<<endl;
            }while (teamChoice!="Red" && teamChoice!="Blue");

            //����� ���������� ��� �������� ��� ���������� ��� �������� ��� ���������� ��� ������.
            if (teamChoice=="Red"){
                playerStatus(Red);
            }
            else{
                playerStatus(Blue);
            }
            break;

        //��������� 4: ������ ��� �� ���������.
         default:
               cout<<"Exiting..."<<endl;
       }
    }while (choice!=4); //���������� ���� ��������� ��� ������� 4.
    return 0;
}


Team playerInsert(Team T){
    //��� ����� ������ ����� ��� ���������� ���������� ��������� ��� �� �������� ��� ������������� ���� ������, ����������� ������ ������ ��� ���� �������� ������������.
    string name, gender, profession;
    cout<<"Enter player's name:"<<endl;
    cin.ignore(); //���� ��� ������� �������� ���� ignore, ������ ���� ��� ���������. ���������� ���� ��� getline, ����� ���� ������ �������������� ��� ���� cin, � getline �� �������� �� '\n'
    getline(cin,name);

    cout<<"Is the player Male or Female?:"<<endl;
    do{
        cin>>gender;
        if (gender!="Male" && gender!="Female") cout<<"You must input Male or Female"<<endl;    //������ �� �� ��� ������ ������� ���� political correctness, ������ ������ ���� 2 ����!!
    }while (gender!="Male" && gender!="Female");

    cout<<"Enter player's profession:"<<endl;
    cin.ignore();
    getline(cin,profession);

    int age,numberOfWins;
    cout<<"Enter player's age (at least 8 years old):"<<endl;

    bool failure;   //���� ������ �� main.
    do{
        cin>>age;
        failure=cin.fail();
        if (age<8 || failure) {
            cout<<"You must input a valid age."<<endl;
            cin.clear();
            cin.ignore(10000,'\n');
        }
    }while (age<8 || failure);  //��� ������ ���������� ��� �� age ���� ����� �� �� ���� ������� �� 18,���� �� 8 ���� ��� ��� ���������� ���� ���� �������� ���� �������.
                                //�������, ������ ������ ��� �� Master Chef Junior, ��� ������� ������ 8 ��� 13!

    cout<<"Enter player's number of wins:"<<endl;   //��� ���� �� ��������� �� ��� ������ ������ ������ ���� �������� ��� �� ��� ���������������.
                                                    //����� ��� �� �������� ��� ������ � ������� �� 0 �����. ����� ��������� ��� ������ � ������� �� ��������� �� �����������
                                                    //������ ��� ����������, ����� �� ���� �������� ��� 0 �����.
    do{
        cin>>numberOfWins;
        failure=cin.fail();
        if (numberOfWins<0 || failure) {
            cout<<"Wins cannot be negative/Invalid entry. Try again."<<endl;
            cin.clear();
            cin.ignore(10000,'\n');
        }
    }while (numberOfWins<0 || failure);

    string eliminationChoice;
    cout<<"Is the player a candidate for elimination?(Yes or No):"<<endl;
    do{
        cin>>eliminationChoice;
        if (eliminationChoice!="Yes" && eliminationChoice!="No") cout<<"Input Yes or No"<<endl;
    }while (eliminationChoice!="Yes" && eliminationChoice!="No");
    bool eliminationCandidate;

    eliminationCandidate = eliminationChoice=="Yes" ? true : false; //��������� ��������.

    //������� �� ��������� ��� Team ��� ����������� �� ����� ��� �������, �������� �� �������� ��� ����� ������� �� ���������.
    T.setPlayerList(T.getNumberOfMembers(),name,gender,profession,age,numberOfWins,eliminationCandidate);
    return T;   //������������� �� ����������� ����������� ������.
}

//� ��������� ���� ��������� ��� ��������� ��� ������ ��� ������� ��� ������.
void teamStatus(Team T){
    cout<<"Team name:"<<T.getColour()<<endl;
    cout<<"Number of members: "<<T.getNumberOfMembers()<<endl;
    cout<<"Team has won "<<T.getNumberOfWins()<<" times"<<endl;
    cout<<"Team's supplies: "<<T.getNumberOfSupplies()<<endl;   //���� ���� � ��������� ��������������� �����, ���� ��� �� ��� ����������.
    if (T.getNumberOfMembers()!=0){
            cout<<"The team's players are:"<<endl;  //��������� �� ������� ��� ������� ��� ������, ����� ��� �� index ����.
            for (int j=0;j<T.getNumberOfMembers();j++){
                cout<<j<<". "<<T.getPlayerList(j).getName()<<endl;
            }
    }
    else {
            cout<<"The team has no players at the moment."<<endl;   //�� ��������� ��� ��� �������� ������� ���� �����, ��������� ��������� ������.
    }
}

//� ��������� ���� ���������� ��� ��������� ���� ������ ��� ���������� ���� ����� ��� ������� ��� ������, ���� �� ���� �� �����, ���� �� ���� �� index.
void playerStatus(Team T){
    if (T.getNumberOfMembers()==0){
            cout<<"The team is empty, make a different choice."<<endl;  //�� ����� ����� � �����, ���������� ����������.
        }
    else{

        cout<<"Do you want to search by Name or by Index?"<<endl;

        string searchChoice;
        string playerName;

        do{
            cin>>searchChoice;  //���������� �� ���� �� ������� �� ������������.
            if (searchChoice!="Name" && searchChoice!="Index") cout<<"You must input Name or Index."<<endl;
        }while (searchChoice!="Name" && searchChoice!="Index");

        if (searchChoice=="Name"){
            cout<<"Enter player's name:";   //��������� ����� ��������.
            cin.ignore();   //���� � ������ ���������� ��� �� ����� flush ��� ��������� \0 ��� ������� ��� ����������� ����� ��� cin
            getline(cin,playerName);
            bool found=false;
            //�� �������� ��������� ���������� ���� ����� ��� ������ �� �� ����� �����.
            for (int j=0;(j<=T.getNumberOfMembers() && found==false);j++){
                if (T.getPlayerList(j).getName()==playerName){
                    //����������� �� �������� ��� ������, �� ����� ������.
                    cout<<"Name: "<<T.getPlayerList(j).getName()<<endl;
                    cout<<"Gender: "<<T.getPlayerList(j).getGender()<<endl;
                    cout<<"Profession: "<<T.getPlayerList(j).getProfession()<<endl;
                    cout<<"Age: "<<T.getPlayerList(j).getAge()<<endl;
                    cout<<"Number of wins: "<<T.getPlayerList(j).getNumberOfWins()<<endl;
                    cout<<"Skill: "<<T.getPlayerList(j).getSkill()<<endl;
                    cout<<"Fatigue: "<<T.getPlayerList(j).getFatigue()<<endl;
                    cout<<"Popularity: "<<T.getPlayerList(j).getPopularity()<<endl;
                    cout<<"Elimination candidate: ";
                    if (T.getPlayerList(j).getEliminationCandidate()==0) cout<<"No"<<endl;
                    else cout<<"Yes"<<endl;
                    found=true;
                }
            }
            if (found==false) cout<<"There is no such player in this team."<<endl;  //�� � ������� �� ������, ����������� ��������� ������.
        }
        else{
            cout<<"Enter player's index:"<<endl;    //��������� ����� index.
            int index;
            do{
                cin>>index;
                if (index<0) cout<<"Index cannot be negative, try again."<<endl;
                if (index>T.getNumberOfMembers()-1) cout<<"There are not that many players, try a lower number."<<endl;
            }while (index<0 || index>T.getNumberOfMembers()-1); //��������� ��� �� ��� ����� ��������, ���� ��� �� ��� ����� ���������� ��� �� ������ ��� �������.

            //����������� �� �������� ��� ������ ��� ����� index.
            cout<<"Name: "<<T.getPlayerList(index).getName()<<endl;
            cout<<"Gender: "<<T.getPlayerList(index).getGender()<<endl;
            cout<<"Profession: "<<T.getPlayerList(index).getProfession()<<endl;
            cout<<"Age: "<<T.getPlayerList(index).getAge()<<endl;
            cout<<"Number of wins: "<<T.getPlayerList(index).getNumberOfWins()<<endl;
            cout<<"Skill: "<<T.getPlayerList(index).getSkill()<<endl;
            cout<<"Fatigue: "<<T.getPlayerList(index).getFatigue()<<endl;
            cout<<"Popularity: "<<T.getPlayerList(index).getPopularity()<<endl;
            cout<<"Elimination candidate: ";
            if (T.getPlayerList(index).getEliminationCandidate()==0) cout<<"No"<<endl;
            else cout<<"Yes"<<endl;
        }
    }
}
