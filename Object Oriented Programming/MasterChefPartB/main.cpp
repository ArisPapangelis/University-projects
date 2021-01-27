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
    Email: stefanospapadam@gmail . com
*/



#include "Player.h"
#include "Team.h"

//Μεριδες φαγητου συμφωνα με την εκφωνηση.
#define FOOD_PORTIONS 14

//Πρωτοτυπα των συναρτησεων του main.cpp.
Team playerInsert(Team T);
void teamStatus(Team T);
void playerStatus(Team T);


int main() {
    //Δινουμε ως seed στην srand τον χρονο του συστηματος, ωστε να μπορουμε να παραγουμε ψευδο-τυχαιους αριθμους με την rand().
    time_t t;
    srand((unsigned) time(&t));

    //Επιλογη μενου.
    int choice;

    //Αρχικοποιηση των 2 ομαδων.
    Team Red("Red",0,0,0);
    Team Blue("Blue",0,0,0);

    do{
        //Το μενου μας.
        cout<<endl<<"Choose one of the following:"<<endl;
        cout<<"1.Insert a player in a team."<<endl;
        cout<<"2.Display team status."<<endl;
        cout<<"3.Display player status."<<endl;
        cout<<"4.Exit program."<<endl;

        bool failure;   //Μεταβλητη που αποθηκευει αν απετυχε να διαβαστει δεδομενο τυπου int ή οχι.
        do{
            //Ελεγχος για εγκυρη επιλογη. Περαν των αριθμητικων περιορισμων (1 εως 4), θα πρεπει να ελεγχουμε και την περιπτωση που μας δωσει string ο παικτης,οποτε και
            //καθαριζουμε εντελως το buffer μεσω των cin.clear() και cin.ignore() ωστε να μην εχουμε απειρη επαναληψη του βροχου.
            cin>>choice;
            failure=cin.fail(); //Αν εχουμε type mismatch ισουται με true, αλλιως ειναι false.

            if (failure || choice<1 || choice>4){    //Σε περιπτωση ακυρου αριθμου, θα ειναι true λογω των choice. Σε περιπτωση που βαλει ο χρηστης string, θα ειναι true λογω του failure.
                                                //Και στις 2 περιπτωσεις, το προγραμμα δε θα προχωρησει, μεχρι να εισαχθει εγκυρη επιλογη. Ακριβως ιδια λογικη εφαρμοζεται και σε παρακατω εισοδους.
                cout<<"Invalid choice. Try again"<<endl;
                cin.clear(); //Καθαριζει τα error flags.
                cin.ignore(10000,'\n'); //Αγνοει οσα στοιχεια εχουν ξεμεινει στο buffer.
            }
        } while (failure || choice<1 || choice>4);

        //Μεταβλητη οπου αποθηκευεται η επιλογη ομαδας.
        string teamChoice;

       switch (choice){
        //Περιπτωση 1: Εισαγωγη παικτη σε ομαδα.
        case 1:
            cout<<endl<<"In which team do you want to put the player? (Red or Blue):"<<endl;

            //Επιλογη ομαδας και ελεγχος περιορισμων.
            do{
                cin>>teamChoice;
                if (teamChoice!="Red" && teamChoice!="Blue") cout<<"You must input Red or Blue"<<endl;
            }while (teamChoice!="Red" && teamChoice!="Blue");

            //Κληση συναρτησης που επιτελει την εισαγωγη παικτη, επιστρεφοντας το ενημερωμενο αντικειμενο τυπου Team.
            if (teamChoice=="Red"){
                if (Red.getNumberOfMembers()<=11) Red=playerInsert(Red);  //Ελεγχος για το αν η ομαδα ειναι γεματη.
                else cout<<"Red team is full, make a different choice"<<endl;
            }

            else{
                if (Blue.getNumberOfMembers()<=11) Blue=playerInsert(Blue);
                else cout<<"Blue team is full, make a different choice"<<endl;
            }
            break;

        //Περιπτωση 2: Προβολη καταστασης ομαδας.
        case 2:
            cout<<endl<<"Which team's status do you want to display? (Red or Blue):"<<endl;

            //Επιλογη ομαδας.
            do{
                cin>>teamChoice;
                if (teamChoice!="Red" && teamChoice!="Blue") cout<<"You must input Red or Blue"<<endl;
            }while (teamChoice!="Red" && teamChoice!="Blue");

            //Κληση συναρτησης που επιτελει την λειτουργια της προβολης της καταστασης της ομαδας.
            if (teamChoice=="Red"){
                teamStatus(Red);
            }

            else{
                teamStatus(Blue);
            }
            break;

        //Περιπτωση 3: Προβολη της καταστασης ενος παικτη, ειτε κατα ονομα ειτε κατα index.
        case 3:
            cout<<endl<<"Which team does the player belong to? (Red or Blue):"<<endl;

            //Επιλογη ομαδας.
            do{
                cin>>teamChoice;
                if (teamChoice!="Red" && teamChoice!="Blue") cout<<"You must input Red or Blue"<<endl;
            }while (teamChoice!="Red" && teamChoice!="Blue");

            //Κληση συναρτησης που επιτελει την λειτουργια της προβολης της καταστασης του παικτη.
            if (teamChoice=="Red"){
                playerStatus(Red);
            }
            else{
                playerStatus(Blue);
            }
            break;

        //Περιπτωση 4: Εξοδος απο το προγραμμα.
         default:
               cout<<"Exiting..."<<endl;
       }
    }while (choice!=4); //Τερματιζει οταν εισαγουμε σαν επιλογη 4.
    return 0;
}


Team playerInsert(Team T){
    //Στο πρωτο σταδιο αυτης την συναρτησης διαβαζουμε διαδοχικα ολα τα στοιχεια που χαρακτηριζουν εναν παικτη, λαμβανοντας φυσικα υποψιν και τους εκαστοτε περιορισμους.
    string name, gender, profession;
    cout<<"Enter player's name:"<<endl;
    cin.ignore(); //Οταν δεν βαζουμε ορισματα στην ignore, αγνοει μονο ενα χαρακτηρα. Χρειαζεται πριν απο getline, γιατι οταν εχουμε χρησιμοποιησει πιο πριν cin, η getline θα διαβασει το '\n'
    getline(cin,name);

    cout<<"Is the player Male or Female?:"<<endl;
    do{
        cin>>gender;
        if (gender!="Male" && gender!="Female") cout<<"You must input Male or Female"<<endl;    //Ελπιζω να μη μας κοψετε μοναδες λογω political correctness, επειδη βαλαμε μονο 2 φυλα!!
    }while (gender!="Male" && gender!="Female");

    cout<<"Enter player's profession:"<<endl;
    cin.ignore();
    getline(cin,profession);

    int age,numberOfWins;
    cout<<"Enter player's age (at least 8 years old):"<<endl;

    bool failure;   //Ιδια λογικη με main.
    do{
        cin>>age;
        failure=cin.fail();
        if (age<8 || failure) {
            cout<<"You must input a valid age."<<endl;
            cin.clear();
            cin.ignore(10000,'\n');
        }
    }while (age<8 || failure);  //Δεν βαλαμε περιορισμο για το age οσον αφορα το αν εχει περασει τα 18,αλλα τα 8 μιας και δεν αναφερεται ρητα στην εκφωνηση οριο ηλικιας.
                                //Εξαλλου, καποτε υπηρχε και το Master Chef Junior, για ηλικιες μεταξυ 8 και 13!

    cout<<"Enter player's number of wins:"<<endl;   //Για αυτη τη μεταβλητη δε μας δινετε καποια οδηγια στην εκφωνηση για το πως χρησιμοποιειται.
                                                    //Εκτος και αν θεωρειτε οτι ξεκινα ο παικτης με 0 νικες. Εμεις υποθεσαμε οτι μπορει ο παικτης να εισαγεται σε οποιοδηποτε
                                                    //σταδιο του παιχνιδιου, οποτε να εχει παραπανω απο 0 νικες.
    do{
        cin>>numberOfWins;
        failure=cin.fail();
        if (numberOfWins<0 || failure) {
            cout<<"Wins cannot be negative/Invalid entry. Try again."<<endl;
            cin.clear();
            cin.ignore(10000,'\n');
        }
    }while (numberOfWins<0 || failure);

    string eliminationChoice;
    cout<<"Is the player a candidate for elimination?(Yes or No):"<<endl;
    do{
        cin>>eliminationChoice;
        if (eliminationChoice!="Yes" && eliminationChoice!="No") cout<<"Input Yes or No"<<endl;
    }while (eliminationChoice!="Yes" && eliminationChoice!="No");
    bool eliminationCandidate;

    eliminationCandidate = eliminationChoice=="Yes" ? true : false; //Τριαδικος τελεστης.

    //Καλουμε τη συναρτηση του Team που συμπληρωνει τη λιστα των παικτων, δινοντας τα ορισματα που μολις διαβασε το προγραμμα.
    T.setPlayerList(T.getNumberOfMembers(),name,gender,profession,age,numberOfWins,eliminationCandidate);
    return T;   //΅Επιστρεφουμε το ενημερωμενο αντικειμενο ομαδας.
}

//Η συναρτηση αυτη εκτυπωνει την κατασταση της ομαδας που δινουμε σαν ορισμα.
void teamStatus(Team T){
    cout<<"Team name:"<<T.getColour()<<endl;
    cout<<"Number of members: "<<T.getNumberOfMembers()<<endl;
    cout<<"Team has won "<<T.getNumberOfWins()<<" times"<<endl;
    cout<<"Team's supplies: "<<T.getNumberOfSupplies()<<endl;   //Ουτε αυτη η μεταβλητη χρησιμοποιειται καπου, ισως και να μην χρειαζοταν.
    if (T.getNumberOfMembers()!=0){
            cout<<"The team's players are:"<<endl;  //Εκτυπωνει τα ονοματα των παικτων της ομαδας, καθως και τα index τους.
            for (int j=0;j<T.getNumberOfMembers();j++){
                cout<<j<<". "<<T.getPlayerList(j).getName()<<endl;
            }
    }
    else {
            cout<<"The team has no players at the moment."<<endl;   //Σε περιπτωση που δεν υπαρχουν παικτες στην ομαδα, εκτυπωνει καταλληλο μηνυμα.
    }
}

//Η συναρτηση αυτη επιστρεφει την κατασταση ενος παικτη που αναζητουμε στην ομαδα που δινουμε σαν ορισμα, ειτε με βαση το ονομα, ειτε με βαση το index.
void playerStatus(Team T){
    if (T.getNumberOfMembers()==0){
            cout<<"The team is empty, make a different choice."<<endl;  //Αν ειναι αδεια η ομαδα, τερματιζει κατευθειαν.
        }
    else{

        cout<<"Do you want to search by Name or by Index?"<<endl;

        string searchChoice;
        string playerName;

        do{
            cin>>searchChoice;  //Επιλεγουμε με βαση τί θελουμε να αναζητησουμε.
            if (searchChoice!="Name" && searchChoice!="Index") cout<<"You must input Name or Index."<<endl;
        }while (searchChoice!="Name" && searchChoice!="Index");

        if (searchChoice=="Name"){
            cout<<"Enter player's name:";   //Αναζητηση βασει ονοματος.
            cin.ignore();   //Αυτη η γραμμη χρειαζεται για να κανει flush τον χαρακτηρα \0 που υπαρχει απο προηγουμενη χρηση της cin
            getline(cin,playerName);
            bool found=false;
            //Με γραμμικη αναζητηση αναζητουμε στην ομαδα τον παικτη με το δοθεν ονομα.
            for (int j=0;(j<=T.getNumberOfMembers() && found==false);j++){
                if (T.getPlayerList(j).getName()==playerName){
                    //Εκτυπωνουμε τα στοιχεια του παικτη, αν αυτος βρεθει.
                    cout<<"Name: "<<T.getPlayerList(j).getName()<<endl;
                    cout<<"Gender: "<<T.getPlayerList(j).getGender()<<endl;
                    cout<<"Profession: "<<T.getPlayerList(j).getProfession()<<endl;
                    cout<<"Age: "<<T.getPlayerList(j).getAge()<<endl;
                    cout<<"Number of wins: "<<T.getPlayerList(j).getNumberOfWins()<<endl;
                    cout<<"Skill: "<<T.getPlayerList(j).getSkill()<<endl;
                    cout<<"Fatigue: "<<T.getPlayerList(j).getFatigue()<<endl;
                    cout<<"Popularity: "<<T.getPlayerList(j).getPopularity()<<endl;
                    cout<<"Elimination candidate: ";
                    if (T.getPlayerList(j).getEliminationCandidate()==0) cout<<"No"<<endl;
                    else cout<<"Yes"<<endl;
                    found=true;
                }
            }
            if (found==false) cout<<"There is no such player in this team."<<endl;  //Αν ο παικτης δε βρεθει, εκτυπωνουμε καταλληλο μηνυμα.
        }
        else{
            cout<<"Enter player's index:"<<endl;    //Αναζητηση βασει index.
            int index;
            do{
                cin>>index;
                if (index<0) cout<<"Index cannot be negative, try again."<<endl;
                if (index>T.getNumberOfMembers()-1) cout<<"There are not that many players, try a lower number."<<endl;
            }while (index<0 || index>T.getNumberOfMembers()-1); //Ελεγχουμε και να μην ειναι αρνητικο, αλλα και να μην ειναι μεγαλυτερο απο το πληθος των παικτων.

            //Εκτυπωνουμε τα στοιχεια του παικτη στο δοθεν index.
            cout<<"Name: "<<T.getPlayerList(index).getName()<<endl;
            cout<<"Gender: "<<T.getPlayerList(index).getGender()<<endl;
            cout<<"Profession: "<<T.getPlayerList(index).getProfession()<<endl;
            cout<<"Age: "<<T.getPlayerList(index).getAge()<<endl;
            cout<<"Number of wins: "<<T.getPlayerList(index).getNumberOfWins()<<endl;
            cout<<"Skill: "<<T.getPlayerList(index).getSkill()<<endl;
            cout<<"Fatigue: "<<T.getPlayerList(index).getFatigue()<<endl;
            cout<<"Popularity: "<<T.getPlayerList(index).getPopularity()<<endl;
            cout<<"Elimination candidate: ";
            if (T.getPlayerList(index).getEliminationCandidate()==0) cout<<"No"<<endl;
            else cout<<"Yes"<<endl;
        }
    }
}
