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

#ifndef IMMUNITYCOMPETITION_H_INCLUDED
#define IMMUNITYCOMPETITION_H_INCLUDED

#include <iostream>
#include <string>
#include "ImmunityAward.h"
#include "Competition.h"
#include "Team.h"

using namespace std;

//Κλάση διαγωνισμού ασυλίας, που κληρονομεί την κλάση διαγωνισμού.
class ImmunityCompetition:public Competition
{
    ImmunityAward immunityAward; //Αντικείμενο επάθλου ασυλίας.

public:
    ImmunityCompetition();      //Κενός constructor.
    ImmunityCompetition(int id,string name,ImmunityAward immunityAward);    //Constructor με ορίσματα.
    ~ImmunityCompetition();     //Destructor.

    ImmunityAward getImmunityAward() {return immunityAward;};   //Getter.
    void setImmunityAward(ImmunityAward immunityAward) {this->immunityAward=immunityAward;};    //Setter.

    void status();  //Συνάρτηση εκτύπωσης στοιχείων.

    void compete(Team &team);   //Συνάρτηση υλοποίησης διαγωνισμού μεταξύ των παικτών της ομάδας team.
};

#endif // IMMUNITYCOMPETITION_H_INCLUDED
