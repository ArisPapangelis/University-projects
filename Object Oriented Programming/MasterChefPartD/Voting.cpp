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

#include "Voting.h"

vector<Vote> Voting::votes;         //Αρχικοποίηση των στατικών δομών μας.
map<string,int> Voting::results;

//Στατική συνάρτηση υλοποίησης της ψηφοφορίας.
void Voting::votingProcess(Team& team)
{
    cout<<endl;
    if (team.getNumberOfPlayers()!=2)   //Έχουμε ως όριο τους 2 παίκτες, γιατί σε διαφορετική περίπτωση ο παίκτης που δεν έχει ασυλία δε θα μπορεί να ψηφίσει κανέναν!
    {
        for (int i=0;i<11;i++)          //Κάθε ένας από τους παίκτες της ομάδας ψηφίζει, ανάλογα με το πόσες ψήφους έχει διαθέσιμες (1, 2 ή 3).
        {
            if (team.getPlayers()[i].getAge()>0)    //Μόνο οι παίκτες που εξακολουθούν να υπάρχουν στην ομάδα μπορούν να ψηφίσουν (προφανώς...).
            {
               for (int v=team.getPlayers()[i].getVotes();v>0;v--)  //Ξεκινάμε από τον αριθμό των ψήφων του παίκτη (1, 2 ή 3) και πάμε αντίστροφα, ώστε να εξαντληθούν όλες οι ψήφοι.
               {
                   votes.push_back(playerVote(team,i));     //Βάζουμε την ψήφο του παίκτη στο διάνυσμα των ψήφων. Η ψήφος υπολογίζεται μέσω της συνάρτησης playerVote.
               }
            }
        }

        cout<<endl<<"--VOTES--"<<endl;  //Ψήφοι.
        for (unsigned i=0;i<votes.size();i++)       //(Έχω βάλει unsigned και όχι int γιατί μου έβγαζε warning για type mismatch)
        {
            votes[i].status();      //Εκτυπώνουμε τα στοιχεία της κάθε ψήφου που κατατέθηκε.
        }
        cout<<endl;

        map<string,int>::iterator p;            //Δημιουργία iterator ώστε να μπορέσουμε να προσπελάσουμε το map results.
        for (unsigned i=0;i<votes.size();i++)   //Έλεγχος κάθε ψήφου.
        {
            p=results.find(votes[i].getVoted());    //Επιστροφή iterator στο σημείο του map που βρέθηκε το κλειδί, ή στο results.end() αν δεν βρέθηκε.
            if (p!=results.end())
            {
                p->second=p->second + 1;    //Αν το κλειδί υπάρχει ήδη στο map, αυξάνουμε την τιμή του (δηλαδή των αριθμό των ψήφων κατά του αντίστοιχου παίκτη) κατά 1.
            }
            else
            {
                results.insert(pair<string,int>(votes[i].getVoted(),1));    //Αν το κλειδί δεν υπάρχει στο χάρτη, το εισάγουμε, με αρχική τιμή 1 (αφού μόλις εντοπίστηκε η πρώτη ψήφος
            }                                                               //κατά του συγκεκριμένου παίκτη).
        }
        cout<<"--RESULTS--"<<endl;  //Αποτελέσματα ψηφοφορίας.
        for (p=results.begin(); p!=results.end(); p++)  //Από το πρώτο μέχρι το τελευταίο στοιχείο του map, μέσω iterator.
        {
            cout<<"Player "<<p->first<<" got voted "<<p->second<<" times"<<endl;    //Εκτυπώνουμε τα ονόματα των παικτών που ψηφίστηκαν, καθώς και τις φορές που ψηφίστηκαν.
        }
        cout<<endl;
        selectPlayer(team); //Κλήση της συνάρτησης που επιλέγει τους υποψήφιους προς αποχώρηση, καθώς και ποιός παίκτης τελικά θα αποχωρήσει.
    }

    else
    {
        cout<<"There are only two players left in this team."<<endl;    //Εκτύπωση κατάλληλου μηνύματος αν έχουν μείνει μόνο δύο παίκτες στην ομάδα.
    }
    votes.clear();      //Εκκαθάριση των δύο δυναμικών δομών μας ώστε να είναι έτοιμες για τον επόμενο γύρο ψηφοφορίας.
    results.clear();
}




//Βοηθητική συνάρτηση που βρίσκει και επιστρέφει την ψήφο του κάθε παίκτη. Δέχεται σαν όρισμα την ομάδα που συμμετέχει στην ψηφοφορία, καθώς και τη θέση του παίκτη που ψηφίζει σε κάθε κλήση.
Vote Voting::playerVote(Team& team, int index)
{
    int playerChoice; //Ο παίκτης που θα επιλεγεί στη συγκεκριμένη ψήφο.
    string reason;    //Ο λόγος που θα ψηφιστεί ο εν λόγω παίκτης.

    int maxWins=-1,minWins=1000000;
    float maxTechnique=-1,minTechnique=101;

    int votingChoice=rand()%5;  //Ψηφίζει είτε τυχαία, είτε με βάση τις περισσότερες νίκες ή με βάση την καλύτερη τεχνική (στρατηγική ψήφος για επιβίωση του παίκτη),
                                //είτε με βάση της λιγότερες νίκες ή την χειρότερη τεχνική (αλτρουϊστική ψήφος για το καλό της ομάδας!)
    switch (votingChoice)
    {
    case 0: //Τυχαία ψήφος.
        do
        {
            playerChoice=rand()%11; //Τυχαία επιλογή ενός εκ των 11 παικτών.
        } while (playerChoice==index || team.getPlayers()[playerChoice].getImmunity()==true || team.getPlayers()[playerChoice].getAge()==0);
        //Ο παίκτης δε μπορεί να ψηφίσει τον εαυτό του, παίκτη που έχει ασυλία ή παίκτη που έχει ήδη αποχωρήσει από το παιχνίδι, για αυτό και η while τερματίζει με τις παραπάνω συνθήκες.

        reason="Random pick";   //Λόγος της ψήφου.
        break;

    case 1: //Στρατηγική ψήφος με βάση τις περισσότερες νίκες.
        for (int i=0;i<11;i++)
        {
             //Ο παίκτης δε μπορεί να ψηφίσει τον εαυτό του, παίκτη που έχει ασυλία ή παίκτη που έχει ήδη αποχωρήσει από το παιχνίδι. Με βάση αυτά, βρίσκουμε τον παίκτη με τις περισσότερες νίκες.
            if (team.getPlayers()[i].getWins()>maxWins && i!=index && team.getPlayers()[i].getImmunity()==false && team.getPlayers()[i].getAge()!=0)
            {
                maxWins=team.getPlayers()[i].getWins();
                playerChoice=i;
            }
        }
        reason="Strategically picked the player with the most wins";    //Λόγος της ψήφου.
        break;

    case 2: //Αλτρουϊστική ψήφος με βάση τις λιγότερες νίκες.
        for (int i=0;i<11;i++)
        {
            //Ο παίκτης δε μπορεί να ψηφίσει τον εαυτό του, παίκτη που έχει ασυλία ή παίκτη που έχει ήδη αποχωρήσει από το παιχνίδι. Με βάση αυτά, βρίσκουμε τον παίκτη με τις λιγότερες νίκες.
            if (team.getPlayers()[i].getWins()<minWins && i!=index && team.getPlayers()[i].getImmunity()==false && team.getPlayers()[i].getAge()!=0)
            {
                minWins=team.getPlayers()[i].getWins();
                playerChoice=i;
            }
        }
        reason="Picked the player with the fewest wins, because he holds the team back";    //Λόγος της ψήφου.
        break;

    case 3: //Αλτρουϊστική ψήφος με βάση τη χειρότερη τεχνική.
        for (int i=0;i<11;i++)
        {
            //Ο παίκτης δε μπορεί να ψηφίσει τον εαυτό του, παίκτη που έχει ασυλία ή παίκτη που έχει ήδη αποχωρήσει από το παιχνίδι. Με βάση αυτά, βρίσκουμε τον παίκτη με τη χειρότερη τεχνική.
            if (team.getPlayers()[i].getTechnique()<minTechnique && i!=index && team.getPlayers()[i].getImmunity()==false && team.getPlayers()[i].getAge()!=0)
            {
                minTechnique=team.getPlayers()[i].getTechnique();
                playerChoice=i;
            }
        }
        reason="Picked the player with the worst technique, because he holds the team back";    //Λόγος της ψήφου.
        break;

    default: //Στρατηγική ψήφος με βάση την καλύτερη τεχνική.
        for (int i=0;i<11;i++)
        {
            //Ο παίκτης δε μπορεί να ψηφίσει τον εαυτό του, παίκτη που έχει ασυλία ή παίκτη που έχει ήδη αποχωρήσει από το παιχνίδι. Με βάση αυτά, βρίσκουμε τον παίκτη με την καλύτερη τεχνική.
            if (team.getPlayers()[i].getTechnique()>maxTechnique && i!=index && team.getPlayers()[i].getImmunity()==false && team.getPlayers()[i].getAge()!=0)
            {
                maxTechnique=team.getPlayers()[i].getTechnique();
                playerChoice=i;
            }
        }
        reason="Strategically picked the player with the best technique";   //Λόγος της ψήφου.
    }
    /*ΠΑΡΑΤΗΡΗΣΗ: Να πούμε πως, λόγω του ότι το πρόγραμμα μας ξεκινάει με όλους τους παίκτες να έχουν 0 νίκες, η ψήφος με βάση τις νίκες δεν επιλέγει πάντα τον σωστό παίκτη (π.χ. ο ίδιος παίκτης
      μπορεί να έχει και τις περισσότερες και τις λιγότερες). Παρόλα αυτά, σε περίπτωση μια πιο γενικής υλοποίησης, όπως για παράδειγμα αν υλοποιούνταν και οι άλλες δοκιμασίες/διαγωνισμοί, το
      πρόγραμμά μας θα λειτουργούσε σωστά. Για αυτό τον λόγο επιλέξαμε να αφήσουμε τον κώδικα ως έχει.*/

    Vote vote(team.getPlayers()[playerChoice].getName(),reason);    //Κλήση του constructor της ψήφου, με ορίσματα το όνομα του παίκτη που ψηφίστηκε, κάθως και τον λόγο της ψήφου.
    return vote;    //Επιστροφή ψήφου.
}


//Βοηθητική συνάρτηση που επιλέγει τους υποψήφιους προς αποχώρηση, καθώς και ποιός από αυτούς τελικά αποχωρεί. Δέχεται σαν όρισμα την ομάδα που συμμετέχει στην ψηφοφορία.
void Voting::selectPlayer(Team& team)
{
    map<string,int>::iterator p;    //Δημιουργία iterator για την προσπέλαση του map results.
    string firstCand="";    //Όνομα του υποψηφίου υπ' αριθμόν 1 (αυτός με τις περισσότερες ψήφους).
    string secondCand="";   //Όνομα του υποψηφίου υπ' αριθμόν 2 (αυτός με τις δεύτερες περισσότερες ψήφους).

    int firstVotes=-1;  //Οι ψήφοι του υποψηφίου 1.
    int secondVotes=-1; //Οι ψήφοι του υποψηφίου 2.

    for (p=results.begin(); p!=results.end();p++)   //Προσπελάζουμε το map results, από την αρχή ως το τέλος, μέσω iterator.
    {
        if (p->second > firstVotes)
        {                               //Αν οι ψήφοι του εξεταζόμενου υποψηφίου ειναι περισσότερες από αυτές του πρώτου υποψηφίου,
            secondCand=firstCand;       //τότε ο πρώτος υποψήφιος θα γίνει δεύτερος, ενώ ο εξεταζόμενος υποψήφιος θα γίνει τελικά ΑΥΤΟΣ πρώτος υποψήφιος.
            secondVotes=firstVotes;
            firstCand=p->first;
            firstVotes=p->second;
        }
        else if (p->second>secondVotes)
        {                               //Αλλιώς, αν ο εξεταζόμενος υποψήφιος έχει περισσότερες ψήφους από τον δεύτερο υποψήφιο, αλλά ΤΑΥΤΟΧΡΟΝΑ λιγότερες ψήφους
            secondCand=p->first;        //από τον πρώτο υποψήφιο, τότε ο εξεταζόμενος υποψήφιος θα γίνει τελικά ΑΥΤΟΣ δεύτερος υποψήφιος.
            secondVotes=p->second;
        }
    }
    float technique1,technique2;    //Τεχνικές των δύο υποψηφίων.
    int pos1,pos2;                  //Θέσεις των δύο υποψηφίων στον πίνακα παικτών.

    for (int i=0;i<11;i++)  //Προσπελάζουμε τον πίνακα παικτών.
    {
        if (firstCand==team.getPlayers()[i].getName())
        {                                                       //Όταν βρεθεί ο πρώτος υποψήφιος στη λίστα παικτών, θέτουμε τη μεταβλητή υποψηφιότητας του ως αληθή και αποθηκεύουμε την
            team.getPlayers()[i].setCandidate(true);            //τεχνική του και τη θέση του.
            technique1=team.getPlayers()[i].getTechnique();
            pos1=i;
        }
        else if (secondCand==team.getPlayers()[i].getName())
        {                                                       //Σε διαφορετική περίπτωση, όταν βρεθεί ο δεύτερος υποψήφιος στη λίστα παικτών, θέτουμε τη μεταβλητή υποψηφιότητας του ως αληθή και
            team.getPlayers()[i].setCandidate(true);            //αποθηκεύουμε την τεχνική του και τη θέση του.
            technique2=team.getPlayers()[i].getTechnique();
            pos2=i;
        }
    }
    cout<<"The two candidates are:"<<endl;
    cout<<"--CANDIDATE 1--"<<endl;
    team.getPlayers()[pos1].status();           //Εκτυπώνουμε τα στοιχεία των δύο υποψηφίων.
    cout<<"--CANDIDATE 2--"<<endl;
    team.getPlayers()[pos2].status();
    cout<<endl;

    if (technique1<technique2)  //Αν ο υποψήφιος 1 έχει χειρότερη τεχνική από τον υποψήφιο 2, αφαιρούμε τον υποψήφιο 1 από το παιχνίδι.
    {
        cout<<"Player "<<firstCand<<" is removed from the game for having the worst technique among the two candidates."<<endl<<endl;
        team.removePlayer(firstCand);
    }
    else if (technique1>technique2) //Ενώ αν ο υποψήφιος 2 έχει χειρότερη τεχνική από τον υποψήφιο 1, αφαιρούμε τον υποψήφιο 2 από το παιχνίδι.
    {
        cout<<"Player "<<secondCand<<" is removed from the game for having the worst technique among the two candidates."<<endl<<endl;
        team.removePlayer(secondCand);
    }
    else    //Στην σπάνια περίπτωση που οι υποψήφιοι έχουν ίση τεχνική, η απόφαση θα παρθεί με βάση το ποσοστό δημοφιλίας του κάθε υποψηφίου.
    {
        if (team.getPlayers()[pos1].getPopularity()<team.getPlayers()[pos2].getPopularity())  //Αν ο υποψήφιος 1 είναι λιγότερο δημοφιλής από τον υποψήφιο 2, αφαιρούμε τον υποψήφιο 1 από το παιχνίδι.
        {
            cout<<"Player "<<firstCand<<" is removed from the game for being the least popular among the two candidates."<<endl<<endl;
            team.removePlayer(firstCand);
        }
        else    //Ενώ αν ο υποψήφιος 2 είναι λιγότερο (ή το ίδιο) δημοφιλής από τον υποψήφιο 1, αφαιρούμε τον υποψήφιο 2 από το παιχνίδι.
        {
            cout<<"Player "<<secondCand<<" is removed from the game for being the least popular among the two candidates."<<endl<<endl;
            team.removePlayer(secondCand);
        }
    }
}
