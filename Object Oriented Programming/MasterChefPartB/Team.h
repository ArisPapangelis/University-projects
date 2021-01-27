/*  Ονοματεπώνυμο: Μιχαήλ Μηναδάκης
    ΑΕΜ:8858
    Τηλέφωνο:6972464204
    Email: Thejokergr@hotmail.gr

    Ονοματεπώνυμο: ¶ρης-Ελευθέριος Παπαγγέλης
    ΑΕΜ:8883
    Τηλέφωνο:6946126130
    Email: aris.papagelis@gmail.com

    Ονοματεπώνυμο: Στέφανος Παπαδάμ
    ΑΕΜ:8885
    Τηλέφωνο:6987112819
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
    //Οι μεταβλητες της κλασης Team με βαση την εκφωνηση.
    string colour;
    int numberOfWins;
    int numberOfMembers;
    int numberOfSupplies;

    //Η κλαση Team, οπως ηταν προφανες και απο την ΣΥΝΑΘΡΟΙΣΗ που εντοπισαμε στο Α' Μερος, αποτελειται απο μια λιστα παικτων, δηλαδη εναν πινακα αντικειμενων τυπου Player(μεγιστο 11 παικτες).
    Player playerList[11];
public:
    //Οι constructors της κλασης, καθως και ο destructor της.
    Team();
    Team(string c, int wins, int members, int supplies);
    ~Team();

    //Οι getters και οι setters για τις 4 απλες μεταβλητες της κλασης μας, που υλοποιουνται σαν inline συναρτησεις.
    void setColour(string c) {colour=c;};
    string getColour() {return colour;};

    void setNumberOfWins(int wins) {numberOfWins=wins;};
    int getNumberOfWins() {return numberOfWins;};

    void setNumberOfMembers(int members) {numberOfMembers=members;};
    int getNumberOfMembers() {return numberOfMembers;};

    void setNumberOfSupplies(int supplies) {numberOfSupplies=supplies;};
    int getNumberOfSupplies() {return numberOfSupplies;};


    //Ο παρακατω getter και setter, οι οποιοι επιδρουν επι του πινακα των παικτων, θα οριστουν στο αρχειο Team.cpp, ως πιο πολυπλοκοι.
    void setPlayerList(int i,string n, string g, string job, int a,int wins,bool candidate);
    Player getPlayerList(int j);

};
#endif // TEAM_H_INCLUDED
