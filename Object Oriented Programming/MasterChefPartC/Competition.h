/*  Ονοματεπώνυμο: Μιχαήλ Μηναδάκης
    ΑΕΜ:8858
    Τηλέφωνο:6972464204
    Email: Thejokergr@hotmail.gr

    Ονοματεπώνυμο: Άρης-Ελευθέριος Παπαγγέλης
    ΑΕΜ:8883
    Τηλέφωνο:6946126130
    Email: aris.papagelis@gmail.com

    Ονοματεπώνυμο: Στέφανος Παπαδάμ
    ΑΕΜ:8885
    Τηλέφωνο:6987112819
    Email: stefanospapadam@gmail.com
*/

#ifndef COMPETITION_H_INCLUDED
#define COMPETITION_H_INCLUDED

#include <iostream>
#include <string>
#include "Team.h"

using namespace std;

//Κλάση διαγωνισμού, η οποία κληρονομείται από τις επιμέρους κατηγορίες διαγωνισμών.
class Competition
{

protected:
    int id;     //Αριθμός διαγωνισμού.
    string name, winner;    //Όνομα και νικητής διαγωνισμού, αντίστοιχα.

public:
    Competition() {id=0; name=""; winner="";};  //Κενός constructor.
    Competition (int id, string name) {this->id=id; this->name=name; winner="";};   //Constructor με ορίσματα.
    ~Competition() {cout<<"";}; //Κενό προς αποφυγήν οπτικής όχλησης.Ούτως η άλλως αυτή η κλάση δεν χρησιμοποιείται για δημιουργία αντικειμένων, αλλά καθαρά για κληρονομικότητα.

    int getId() {return id;};
    string getName() {return name;};            //Getters.
    string getWinner() {return winner;};

    void setId(int id) {this->id=id;};
    void setName(string name) {this->name=name;};           //Setters.
    void setWinner(string winner) {this->winner=winner;};

    void status() {cout<<"Id: "<<id<<endl<<"Competition name: "<<name<<endl<<"Winner: "<<winner<<endl;};    //Συνάρτηση εκτύπωσης των μεταβλητών της κλάσης.

};


#endif // COMPETITION_H_INCLUDED
