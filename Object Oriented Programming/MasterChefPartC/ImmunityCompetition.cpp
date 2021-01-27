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

#include "ImmunityCompetition.h"
using namespace std;

//Κενός constructor.
ImmunityCompetition::ImmunityCompetition()
{
    immunityAward=ImmunityAward();
}

//Constructor με ορίσματα.
ImmunityCompetition::ImmunityCompetition(int id, string name, ImmunityAward immunityAward): Competition(id,name)
{
    this->immunityAward=immunityAward;
}

//Destructor.
ImmunityCompetition::~ImmunityCompetition()
{
    cout<<"Immunity competition "<<name<<" is destroyed"<<endl;
}

//Συνάρτηση εκτύπωσης στοιχείων.
void ImmunityCompetition::status()
{
    Competition::status();      //Χρησιμοποιούμε τελεστή επίλυσης εμβέλειας για την status της βασικής κλάσης.
    immunityAward.status();     //Καλούμε την status του αντικειμένου-μέλους.
}

//Συνάρτηση υλοποίησης διαγωνισμού μεταξύ των παικτών της ομάδας team.
void ImmunityCompetition::compete(Team &team)
{
    int best=0;
    int index=-1;
    for (int i=0;i<team.getNumberOfPlayers();i++)
    {
        if ((team.getPlayers()[i].getTechnique()*0.75+(100-team.getPlayers()[i].getFatigue())*0.25)>best)       //Εύρεση μεγίστου με βάση την τεχνική και την ΜΗ κούραση.
        {
            best=team.getPlayers()[i].getTechnique()*0.75+(100-team.getPlayers()[i].getFatigue())*0.25;
            index=i;
        }
    }
    team.getPlayers()[index].setWins(team.getPlayers()[index].getWins()+1);     //Αύξηση νικών του παίκτη που κέρδισε.
    winner=team.getPlayers()[index].getName();      //Θέτουμε τον νικητή.

    cout<<endl<<"WINNER INFO"<<endl;
    team.getPlayers()[index].status();      //Στοιχεία του νικητή.

    cout<<endl<<"COMPETITION INFO"<<endl;
    status();       //Στοιχεία του διαγωνισμού.

}
