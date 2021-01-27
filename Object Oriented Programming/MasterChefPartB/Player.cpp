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


#include "Player.h"

//Κενος constructor, σε περιπτωση που δημιουργηθει αντικειμενο χωρις ορισματα.
Player::Player(){
    name="",gender="",profession="";
    age=0,numberOfWins=0;
    skill=0,fatigue=0,popularity=0;
    eliminationCandidate=false;
}


//Constructor με παραμετρους. Τα ορισματα δινονται απο τη main, και οι αντιστοιχες μεταβλητες του αντικειμενου τιθονται ισες με αυτα.
Player::Player(string n, string g, string job, int a,int wins,bool candidate){
    name=n;
    gender=g;
    profession=job;
    age=a;
    numberOfWins=wins;
    eliminationCandidate=candidate;

    //Αυτες οι μεταβλητες αρχικοποιουνται με συγκεκριμενες τιμες συμφωνα με την εκφωνηση, και οχι με τη βοηθεια παραμετρων. Στην skill ειδικα, παραγεται τυχαιο ποσοστο απο 0% εως 80%.
    skill=(float)(rand()%81);
    fatigue=0.0;
    popularity=50.0;
}

//Destructor της κλασης.
Player::~Player(){
    cout<<"";
    //Το βαλαμε κενο γιατι δε μπορουσαμε να βλεπουμε τα μηνυματα που δημιουργει συνεχομενα στο console...
    //Σε καθε περιπτωση, ελεγξαμε οτι λειτουργει σωστα και με κανονικο μηνυμα.
}


//Μοντελοποιει την δουλεια του εκαστοτε παικτη.
void Player::works(){
    fatigue+=rand()%21 + 20;    //Αυξηση κατα τυχαιο ποσοστο απο 20% εως 40%.
    skill+=5*skill/100;     //Ποσοστιαια αυξηση επι του αυτου ποσοστου κατα 5%.

    //Ελεγχουμε να μην βγουν οι μεταβλητες εκτος οριων.
    if (fatigue>100) fatigue=100;
    if (skill>100) skill=100;
}

//Μοντελοποιει την κοινωνικοποιηση του παικτη.
void Player::socializes(){
    popularity+= ((rand()%21)-10)*popularity/100; //Ποσοστιαια μεταβολη επι του αυτου ποσοστου κατα -10% εως +10%.

    //Ελεγχουμε να μην βγουν οι μεταβλητες εκτος οριων.
    if (popularity>100) popularity=100;
    else if (popularity<0) popularity=0;
}

//Μοντελοποιει τον τυχον υπνο του παικτη κατα την τελευταια μερα.
void Player::sleeps(){
    fatigue=0;  //Ξεκουραση!
}

//Μοντελοποιει την τυχον εξασκηση του παικτη κατα την τελευταια μερα.
void Player::practices(){
    skill+=5;   //Αυξηση κατα 5%.
    if (skill>100) skill=100; //Ελεγχουμε να μην βγει η μεταβλητη εκτος οριων.
}

//Βοηθητικη συναρτηση που επιλεγει τυχαια υπνο ή εξασκηση την τελευταια μερα.
void Player::endOfWeek(){
    int choice=rand()%2;
    if (choice==0) sleeps();
    else practices();
}

//Μοντελοποιει τη συμμετοχη του παικτη σε διαγωνισμο.
void Player::participates(){
    fatigue+=((rand()%11)+10)*fatigue/100;  //Ποσοστιαια αυξηση της κουρασης επι του αυτου ποσοστου κατα 10% εως 20%
}
