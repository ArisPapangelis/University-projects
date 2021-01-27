/*  Ονοματεπώνυμο: Μιχαήλ Μηναδάκης
    ΑΕΜ:8858
    Τηλέφωνο:6972464204
    Email: Thejokergr@hotmail.gr

    Ονοματεπώνυμο: ¶ρης-Ελευθέριος Παπαγγέλης
    ΑΕΜ:8883
    Τηλέφωνο:6946126130
    Email: aris.papagelis@gmail.com

    Ονοματεπώνυμο: Στέφανος Παπαδάμ
    ΑΕΜ:8885
    Τηλέφωνο:6987112819
    Email: stefanospapadam@gmail . com
*/


#include "Team.h"

//Κενος constructor, σε περιπτωση που δημιουργηθει αντικειμενο χωρις ορισματα.
Team::Team(){
    colour="";
    numberOfMembers=0,numberOfSupplies=0,numberOfWins=0;
    for (int i=0;i<11;i++){
        playerList[i]=Player();
    }
}

//Constructor με παραμετρους. Τα ορισματα δινονται απο τη main, και οι αντιστοιχες μεταβλητες του αντικειμενου τιθονται ισες με αυτα.
Team::Team(string c, int wins, int members, int supplies){
    colour=c;
    numberOfWins=wins;
    numberOfMembers=members;
    numberOfSupplies=supplies;

    //Αρχικοποιηση του πινακα παικτων με "κενους" παικτες.
    for (int i=0;i<11;i++){
        playerList[i]=Player();
    }
}

//Destructor της κλασης μας.
Team::~Team(){
    cout<<"";
    //Το βαλαμε κενο γιατι δε μπορουσαμε να βλεπουμε τα μηνυματα που δημιουργει συνεχομενα στο console...
    //Σε καθε περιπτωση, ελεγξαμε οτι λειτουργει σωστα και με κανονικο μηνυμα.
}

//Ο setter της playerList, ο οποιος δεχεται καποια ορισματα απο τη main, με τα οποια βαζει στη θεση [i] του πινακα τον αντιστοιχο παικτη, καλωντας τον constructor του παικτη.
void Team::setPlayerList(int i,string n, string g, string job, int a,int wins,bool candidate){
    playerList[i]=Player(n,g,job,a,wins,candidate);
    numberOfMembers+=1; //Επισης, αυξανει τον αριθμο των μελων της ομαδας κατα 1, εφοσον εισαγαμε νεο παικτη.
}

//Ο getter της playerList τυπου Player, o οποιος δεχεται ορισμα j, και επιστρεφει τον παικτη στη θεση j.
Player Team::getPlayerList(int j){
    return playerList[j];
}
