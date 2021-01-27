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

#ifndef CREATIVITYCOMPETITION_H_INCLUDED
#define CREATIVITYCOMPETITION_H_INCLUDED

#include <iostream>
#include <string>
#include "ExcursionAward.h"
#include "Competition.h"
#include "Team.h"

using namespace std;

//Κλάση διαγωνισμού δημιουργικότητας, που κληρονομεί την κλάση διαγωνισμού.
class CreativityCompetition: public Competition
{
    ExcursionAward excursionAward;      //Αντικείμενου επάθλου εκδρομής.
public:
    CreativityCompetition();    //Κενός constructor.
    CreativityCompetition(int id,string name,ExcursionAward excursionAward);    //Constructor με ορίσματα.
    ~CreativityCompetition();   //Destructor.

    ExcursionAward getExcursionAward(){return excursionAward;};     //Getter.
    void setExcursionAward(ExcursionAward excursionAward){this->excursionAward=excursionAward;};    //Setter.

    void status();      //Συνάρτηση εκτύπωσης στοιχείων.
    void compete(Team &team1, Team &team2);     //Συνάρτηση υλοποίησης διαγωνισμού μεταξύ όλων των παικτών του παιχνιδιού.

    static string ingredients[10];      //Στατικός πίνακας με τα υλίκα που δίνονται στους παίκτες.
};

#endif // CREATIVITYCOMPETITION_H_INCLUDED
