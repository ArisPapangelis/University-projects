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

#include "CreativityCompetition.h"

using namespace std;

//Κενός constructor.
CreativityCompetition::CreativityCompetition()
{
    excursionAward=ExcursionAward();
};

//Constructor με ορίσματα.
CreativityCompetition::CreativityCompetition(int id,string name,ExcursionAward excursionAward):Competition(id,name)
{
    this->excursionAward=excursionAward;

};

//Γεμίζουμε τον πίνακα ingredients με τυχαία υλικά.
string CreativityCompetition::ingredients[]={"Onions","Avocados","Salt","Pepper","Lobster","Rice","Chicken","Tabasco","Roquefort","Caviar"};

//Destructor.
CreativityCompetition::~CreativityCompetition()
{
    cout<<"Creativity competition "<<name<<" is destroyed"<<endl;
};


//Συνάρτηση εκτύπωσης στοιχείων.
void CreativityCompetition::status()
{
    Competition::status();      //Χρησιμοποιούμε τελεστή επίλυσης εμβέλειας για την status της βασικής κλάσης.
    excursionAward.status();    //Καλούμε την συνάρτηση status του αντικειμένου-μέλους.
    cout<<"Ingredients: "<<endl;
    for (int i=0;i<10;i++){
       cout<<"\t"<<ingredients[i]<<endl;    //Εκτυπώνουμε την λίστα των υλικών.
    }
    cout<<endl;
};

//Συνάρτηση υλοποίησης διαγωνισμού μεταξύ όλων των παικτών του παιχνιδιού.
void CreativityCompetition::compete(Team &team1, Team &team2)
{
    int total=team1.getNumberOfPlayers()+team2.getNumberOfPlayers();    //Ολικός αριθμός παικτών.
    Player players[total];      //Πίνακας με όλους τους παίκτες.
    for (int i=0;i<total;i++)
    {
        if (i<team1.getNumberOfPlayers())
        {
            players[i]=team1.getPlayers()[i];   //Γεμίζουμε τα πρώτα στοιχεία με τους παίκτες της ομάδας 1.
        }
        else
        {
            players[i]=team2.getPlayers()[i-team1.getNumberOfPlayers()];    //Γεμίζουμε τα επόμενα με τους παίκτες την ομάδας 2, με κατάλληλο χειρισμό στο index της getPlayers().
        }
    }
    float maxTechnique=-1;
    int maxIndex=-1;
    int playerIndex;
    float technique;
    for (playerIndex=0;playerIndex<total;playerIndex++)     //Βρίσκουμε τη μέγιστη τεχνική και τον παίκτη που την έχει, ο οποίος χρίζεται και νικητής.
    {
        technique=players[playerIndex].getTechnique();
        if (technique>maxTechnique)
        {
            maxTechnique=technique;
            maxIndex=playerIndex;
        }
    }
    cout<<endl<<"WINNER INFO"<<endl;
    players[maxIndex].status();     //Εκτύπωση στοιχείων νικητή.
    if (maxIndex<team1.getNumberOfPlayers())    //Έλεγχος για το αν το maxIndex είναι για παίκτη της πρώτης ομάδας.
    {
        team1.getPlayers()[maxIndex].setTechnique(team1.getPlayers()[maxIndex].getTechnique()+excursionAward.getTechniqueBonus());      //Αύξηση τεχνικής νικητή με το bonus.
        team1.getPlayers()[maxIndex].setPopularity(team1.getPlayers()[maxIndex].getPopularity()-excursionAward.getPopularityPenalty()); //Μείωση δημοφιλίας νικητή με το penalty.
        winner=team1.getPlayers()[maxIndex].getName();      //Θέτουμε τον νικητή.
    }
    else    //Εργαζόμαστε αντίστοιχα αν ο παίκτης ανήκει στην ομάδα 2, αλλα χειριζόμαστε κατάλληλα το index, ώστε να αρχίζουμε την προσπέλαση του πίνακα από το στοιχείο 0.
    {
        team2.getPlayers()[maxIndex-team1.getNumberOfPlayers()].setTechnique(team2.getPlayers()[maxIndex-team1.getNumberOfPlayers()].getTechnique()+excursionAward.getTechniqueBonus());
        team2.getPlayers()[maxIndex-team1.getNumberOfPlayers()].setPopularity(team2.getPlayers()[maxIndex-team1.getNumberOfPlayers()].getPopularity()-excursionAward.getPopularityPenalty());
        winner=team2.getPlayers()[maxIndex-team1.getNumberOfPlayers()].getName();
    }
    cout<<endl<<"COMPETITION INFO"<<endl;
    status();   //Εκτύπωση των στοιχείων του διαγωνισμού.
}
