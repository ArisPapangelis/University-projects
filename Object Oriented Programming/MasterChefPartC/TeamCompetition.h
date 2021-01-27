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

#ifndef TEAMCOMPETITION_H_INCLUDED
#define TEAMCOMPETITION_H_INCLUDED

#include <iostream>
#include <string>
#include "FoodAward.h"
#include "Round.h"
#include "Competition.h"
#include "Team.h"

using namespace std;

//Κλάση ομαδικού διαγωνισμού, που κληρονομεί την κλάση διαγωνισμού.
class TeamCompetition:public Competition
{
    FoodAward foodAward;    //Αντικείμενο επάθλου φαγητού.
    Round rounds[3];    //Πίνακας αντικειμένων γύρου.

public:
    TeamCompetition();  //Κενός constructor.
    TeamCompetition(int id, string name, FoodAward foodAward);  //Constructor με ορίσματα.
    ~TeamCompetition();     //Destructor.
    //Δεν χρησιμοποιούμε pointers ή δυναμική μνήμη, οπότε δεν χρειάζεται να ορίσουμε δικό μας copy constructor.

    FoodAward getFoodAward() {return foodAward;};   //Getters.
    Round getRounds(int i) {return rounds[i];};

    void setFoodAward(FoodAward foodAward) {this->foodAward=foodAward;};    //Setters.
    void setRounds(Round r, int i) {rounds[i]=r;};

    void status();  //Συνάρτηση εκτύπωσης στοιχείων.

    int compete(Team &team1, Team &team2);  //Συνάρτηση υλοποίησης διαγωνισμού μεταξύ των δύο ομάδων.

};

#endif // TEAMCOMPETITION_H_INCLUDED
