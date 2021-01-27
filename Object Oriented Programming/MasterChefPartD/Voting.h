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

#ifndef VOTING_H_INCLUDED
#define VOTING_H_INCLUDED

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include "Vote.h"
#include "Team.h"

using namespace std;

//Κλάση ψηφοφορίας. Όλα τα μέλη της είναι στατικά, γιατί θέλουμε να μπορούμε να κάνουμε χρήση τους χωρίς να έχουμε ορίσει κάποιο αντικείμενο του τύπου Voting.
class Voting
{
public:
    static vector<Vote> votes;  //Διάνυσμα που περιέχει αντικείμενα Ψήφων από τους παίκτες.
    static map<string,int> results; //Χάρτης που περιέχει τα αποτελέσματα της ψηφοφορίας, με κλειδιά τα ονόματα των παικτών που ψηφίστηκαν και τιμές των αριθμό των φορών που ψηφίστηκαν.

    static void votingProcess(Team &team);  //Στατική συνάρτηση υλοποίησης της ψηφοφορίας.
    static Vote playerVote(Team& team,int index);   //Βοηθητική συνάρτηση που βρίσκει και επιστρέφει την ψήφο του κάθε παίκτη.
    static void selectPlayer(Team& team);   //Βοηθητική συνάρτηση που επιλέγει τους υποψήφιους προς αποχώρηση, καθώς και ποιός από αυτούς τελικά αποχωρεί.
};
#endif // VOTING_H_INCLUDED
