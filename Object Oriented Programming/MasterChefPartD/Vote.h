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

#ifndef VOTE_H_INCLUDED
#define VOTE_H_INCLUDED

#include <iostream>
#include <string>

using namespace std;

//Κλάση ψήφου.
class Vote
{
    string voted;   //Ο παίκτης που ψηφίστηκε.
    string reason;  //Ο λόγος που ψηφίστηκε.
public:
    Vote() {voted=""; reason="";};  //Κενός constructor.
    Vote(string voted,string reason) {this->voted=voted; this->reason=reason;}; //Constructor με παραμέτρους.

    string getVoted() {return voted;};      //Getters.
    string getReason() {return reason;};

    void setVoted(string voted) {this->voted=voted;};       //Setters.
    void setReason(string reason) {this->reason=reason;};

    void status() {cout<<"Player "<<voted<<" got voted for the following reason: "<<reason<<endl;};     //Εκτύπωση των στοιχείων του αντικειμένου ψήφου.

};

#endif // VOTE_H_INCLUDED
