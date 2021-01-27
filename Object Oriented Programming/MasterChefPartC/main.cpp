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

#include "Team.h"
#include <random>
#include <time.h>
#include "TeamCompetition.h"
#include "ImmunityCompetition.h"
#include "CreativityCompetition.h"
#include "FoodAward.h"
#include "ImmunityAward.h"
#include "ExcursionAward.h"

using namespace std;



// Index 0 = Red Team, Index 1 = Blue Team
Team teams[2] = {Team("Red"), Team("Blue")};
int competitionId = 0;
int loser=-1;   //Θα βάλουμε έλεγχο ώστε να μην εκτελεστεί η ImmunityDay αν δεν υπάρχει ακόμα κάποια ομάδα που έχει χάσει.
void menu();
void normalDay();
void teamCompetitionDay();
void immunityCompetitionDay();
void creativityCompetitionDay();

int main()
{
    time_t t;                           //Κάνουμε initialize τον random number generator.
    srand((unsigned)time(&t));
    menu();

    return 0;
}

void menu()
{
    int choice = -1;

    while(choice != 0)
    {
        cout << endl << "1.Normal Day." << endl;
        cout << "2.Team Competition Day." << endl;
        cout << "3.Immunity Competition Day." << endl;
        cout << "4.Creativity Competition Day." << endl;
        cout << "0.Quit" << endl;

        cin >> choice;

        switch(choice)
        {

        case 1:
            normalDay();
            break;
        case 2:
            teamCompetitionDay();
            break;
        case 3:
            if (loser!=-1) immunityCompetitionDay();    //Έλεγχος για το αν υπάρχει ομάδα που έχει χάσει ώστε να κληθεί η immunityCompetitionDay().
            else cout<<"No team has lost yet"<<endl;
            break;
        case 4:
            creativityCompetitionDay();
            break;
        case 0:
            break;
        default:
            cout << "Incorrect Input. Choose between 1 and 3. Press 0 to quit." << endl;

        }
    }
}

//Συνάρτηση που υλοποιεί μια κανονική μέρα παιχνιδιού.
void normalDay()
{

    cout << endl << "This is a normal day in the Master Chef Game." << endl << endl;
    for (int i=0;i<2;i++)
    {
        teams[i].teamWorks();   //Πρωινή δουλειά.
        teams[i].teamEats();    //Πρωινό φαγητό.
        teams[i].teamEats();    //Μεσημεριανό φαγητό.
        teams[i].teamSocializes();  //Βραδυνή συζήτηση.
        teams[i].teamSleeps();  //Βραδυνός ύπνος.
    }
}

//Συνάρτηση που υλοποιεί μια ημέρα ομαδικού διαγωνισμού στο παιχνίδι.
void teamCompetitionDay()
{
    cout << endl << "This is a Team Competition day in the Master Chef Game." << endl << endl;
    for (int i=0;i<2;i++)
    {
        teams[i].teamWorks();
        teams[i].teamEats();
    }
    FoodAward foodAward("Lentils",false);   //Δημιουργία αντικειμένου επάθλου φαγητού.
    TeamCompetition teamComp(competitionId,"Lobster cooking",foodAward);    //Δημιουργία αντικειμένου ομαδικού διαγωνισμού.
    competitionId++;    //Σύμφωνα με εκφώνηση είναι μοναδικός, αύξων αριθμός, οπότε τον αυξάνουμε μετά από κάθε κλήση.
    loser=teamComp.compete(teams[0],teams[1]);  //Έυρεση της ομάδας που έχασε και αποθήκευσή της σε καθολική μεταβλητή, ώστε να χρησιμοποιηθεί στην συνάρτηση διαγωνισμού ασυλίας.
    for (int i=0;i<2;i++)
    {
        teams[i].teamEats();
        teams[i].teamSocializes();
        teams[i].teamSleeps();
    }

}

//Συνάρτηση που υλοποιεί μια ημέρα διαγωνισμού ασυλίας στο παιχνίδι.
void immunityCompetitionDay()
{

    cout << endl << "This is a Immunity Competition day in the Master Chef Game." << endl << endl;
    for (int i=0;i<2;i++)
    {
        teams[i].teamWorks();
        teams[i].teamEats();
    }
    ImmunityAward immunityAward("Immunity",true);   //Δημιουργία αντικειμένου επάθλου ασυλίας.
    ImmunityCompetition immunityComp(competitionId,"Roast Beef cooking",immunityAward);     //Δημιουργία αντικειμένου διαγωνισμού ασυλίας.
    competitionId++;
    if (loser==0) immunityComp.compete(teams[0]);   //Κλήση για την κόκκινη ομάδα.
    else immunityComp.compete(teams[1]);    //Κλήση για την μπλέ ομάδα.
    for (int i=0;i<2;i++)
    {
        teams[i].teamEats();
        teams[i].teamSocializes();
        teams[i].teamSleeps();
    }
    loser=-1;   //Αυτό το κάνουμε ούτως ώστε να μην μπορεί να μπει πάλι η ίδια ομάδα στο διαγωνισμό ασυλίας, αν δεν έχει ξαναχάσει στον ομαδικό διαγωνισμό.
}

//Συνάρτηση που υλοποιεί μια ημέρα διαγωνισμού δημιουργικότητας στο παιχνίδι.
void creativityCompetitionDay()
{

    cout << endl << "This is a Creativity Competition day in the Master Chef Game." << endl << endl;
    for (int i=0;i<2;i++)
    {
        teams[i].teamWorks();
        teams[i].teamEats();
    }
    ExcursionAward excursionAward("Trip to Botrini's restaurant",true);     //Δημιουργία αντικειμένου επάθλου εκδρομής.
    CreativityCompetition creativityComp(competitionId,"Spicy guacamole chicken cooking",excursionAward);   //Δημιουργία αντικειμένου διαγωνισμού δημιουργικότητας.
    competitionId++;
    creativityComp.compete(teams[0],teams[1]);      //Κλήση συνάρτησης διαγωνισμού.
    for (int i=0;i<2;i++)
    {
        teams[i].teamEats();
        teams[i].teamSocializes();
        teams[i].teamSleeps();
    }
}
