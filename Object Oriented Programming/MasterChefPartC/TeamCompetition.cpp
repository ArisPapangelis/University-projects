/*  Ονοματεπώνυμο: Μιχαήλ Μηναδάκης
    ΑΕΜ:8858
    Τηλέφωνο:6972464204
    Email: Thejokergr@hotmail.gr

    Ονοματεπώνυμο: ’ρης-Ελευθέριος Παπαγγέλης
    ΑΕΜ:8883
    Τηλέφωνο:6946126130
    Email: aris.papagelis@gmail.com

    Ονοματεπώνυμο: Στέφανος Παπαδάμ
    ΑΕΜ:8885
    Τηλέφωνο:6987112819
    Email: stefanospapadam@gmail.com
*/

#include "TeamCompetition.h"

using namespace std;

//Κενός constructor.
TeamCompetition::TeamCompetition()
{
    foodAward=FoodAward();
    for (int i=0;i<3;i++) rounds[i]=Round();
}

//Constructor με ορίσματα.
TeamCompetition::TeamCompetition(int id, string name, FoodAward foodAward): Competition(id,name)    //Εδώ καλούμε και τον constructor της βασικής κλάσης.
{
    this->foodAward=foodAward;
    for (int i=0;i<3;i++) rounds[i]=Round();
}

//Destructor.
TeamCompetition::~TeamCompetition()
{
    cout<<"Team competition "<<name<<" is destroyed"<<endl;
}

//Συνάρτηση εκτύπωσης στοιχείων.
void TeamCompetition::status()
{
    Competition::status();  //Χρησιμοποιούμε τελεστή επίλυσης εμβέλειας για την status της βασικής κλάσης.
    foodAward.status();     //Καλούμε την status του αντικειμένου-μέλους.
    for (int i=0;i<3;i++)
    {
        rounds[i].status();     //Καλούμε την status του αντικειμένου rounds[i] για κάθε i.
    }
    cout<<endl;
}

//Συνάρτηση υλοποίησης του διαγωνισμού μεταξύ των ομάδων.
int TeamCompetition::compete(Team &team1, Team &team2)
{
    int wins1=0;
    int wins2=0;
    for (int round=1;round<4;round++)
        {

            bool selected1[team1.getNumberOfPlayers()];     //Πίνακας με false σε κάθε θέση που δεν έχει επιλεγεί ήδη παίκτης.
            for (int j=0;j<team1.getNumberOfPlayers();j++)
            {
                selected1[j]=false;     //Τα κάνουμε όλα false.
            }
            int playerNum=0;
            int index;

            float meanTechnique1=0,meanFatigue1=0;
            while (playerNum<5)     //Η while τερματίζει όταν πάρουμε 5 παίκτες από την ομάδα.
            {
                index=rand()%team1.getNumberOfPlayers();    //Random index μεταξύ του 0 και του αριθμού παικτών πλην ένα.
                if (selected1[index]==false)    //Εισάγει παίκτη μόνο όταν είναι false.
                {
                    team1.getPlayers()[index].compete();     //Συνάρτηση compete της team.
                    selected1[index]=true;  //Γίνεται true όταν τελικά εισαχθεί παίκτης αυτής της θέσης, ώστε να μην ξαναεπιλεγεί.
                    meanTechnique1+=team1.getPlayers()[index].getTechnique();   //’θροιση technique.
                    meanFatigue1+=team1.getPlayers()[index].getFatigue();   //’θροιση fatigue.
                    playerNum++;
                }
            }
            meanTechnique1=meanTechnique1/5;
            meanFatigue1=meanFatigue1/5;        //Μέσοι όροι.


            //Ακριβώς το ίδιο σκεπτικό και για την ομάδα 2.
            bool selected2[team2.getNumberOfPlayers()];
            for (int j=0;j<team2.getNumberOfPlayers();j++)
            {
                selected2[j]=false;
            }
            playerNum=0;

            float meanTechnique2,meanFatigue2;
            while (playerNum<5)
            {
                index=rand()%team2.getNumberOfPlayers();
                if (selected2[index]==false)
                {
                    team2.getPlayers()[index].compete();
                    selected2[index]=true;
                    meanTechnique2+=team2.getPlayers()[index].getTechnique();
                    meanFatigue2+=team2.getPlayers()[index].getFatigue();
                    playerNum++;
                }
            }
            meanTechnique2=meanTechnique2/5;
            meanFatigue2=meanFatigue2/5;


            //Εύρεση νικητή με βάση την εκφώνηση.
            if (meanTechnique1>meanTechnique2)
            {
                rounds[round-1]=Round(round,3*3600,team1.getColor());   //Δημιουργία αντικειμένου i-στου γύρου με κατάλληλες παραμέτρους.
                wins1++; //Αύξηση νικών ομάδας 1.
            }
            else if (meanTechnique1<meanTechnique2)     //Ομοίως για ομάδα 2.
            {
                rounds[round-1]=Round(round,3*3600,team2.getColor());
                wins2++;
            }
            else    //Περίπτωση που έχουν ίση μέση τεχνική.
            {
                if (meanFatigue1<meanFatigue2)
                {
                    rounds[round-1]=Round(round,3*3600,team1.getColor());
                    wins1++;
                }
                else
                {
                    rounds[round-1]=Round(round,3*3600,team2.getColor());
                    wins2++;
                }
            }
    }


    if (wins1>=2)   //Νίκη ομάδας 1.
    {
        team1.setWins(team1.getWins()+1);   //Αύξηση νικών.
        team1.setSupplies(team1.getSupplies()+foodAward.getBonusSupplies());    //Αύξηση προμηθειών μέσω του επάθλου.
        winner="Red";
        cout<<endl<<"WINNER INFO"<<endl;
        team1.status(false);    //Στοιχεία ομάδας.
        cout<<endl<<"COMPETITION INFO"<<endl;
        status();   //Στοιχεία διαγωνισμού.By default χρησιμοποιεί το status που ορίστηκε στην TeamCompetition.
        return 1;
    }
    else    //Αντίστοιχα και για την ομάδα 2.
    {
        team2.setWins(team2.getWins()+1);
        team2.setSupplies(team2.getSupplies()+foodAward.getBonusSupplies());\
        winner="Blue";
        cout<<endl<<"WINNER INFO"<<endl;
        team2.status(false);
        cout<<endl<<"COMPETITION INFO"<<endl;
        status();   //By default χρησιμοποιεί το status που ορίστηκε στην TeamCompetition.
        return 0;
    }
}
