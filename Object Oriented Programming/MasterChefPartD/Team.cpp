#include "Team.h"

using namespace std;

Team::Team(string s)
{
    color = s;

    if (s == "Red")
        players = new Player[11] {Player("Marios", male, 30), Player("Tsikilis", male, 34),Player("Nikoleta", female, 23),Player("Chambos", male, 30),Player("Gogo", female, 27),Player("Konstantinos", male, 52),Player("Giorgos", male, 36),Player("Ilektra", female, 28), Player("Glossidis", male, 24),Player("Savvas", male, 28), Player("Tzortzis",male,25)};
    else
        players = new Player[11] {Player("Selim", male, 39), Player("Nikol", female, 22), Player("Timoleon", male, 28), Player("Vasilis", male, 26), Player("Magky", female, 35), Player("Argyris", male, 25), Player("Maia", female, 45),Player("Symeonidis", male, 24), Player("Christina", female, 20),Player("Seferidis", male, 23), Player("Argyroudi", female, 21)};

}

int Team::getNumberOfPlayers()
{
    int result = 0;

    for (int i = 0; i < 11; i++)
        if (players[i].getAge() != 0)
            result++;

    return result;
}

void Team::setCandidate(string player){

    for (int i = 0; i < 10; i++){

        if (player == players[i].getName()){
            players[i].setCandidate(true);
            players[i].status();
            break;
        }

    }

}

void Team::removePlayer(string name)
{
    int index = -1;
    Player p;

    for (int i = 0; i < 11; i++){
        if (players[i].getName() == name){
            index = i;
            break;
        }
    }

    if (index != -1){
        players[index] = p;
        cout << "Player with name " << name << " is removed." << endl;
    }
    else
        cout << "Player with name " << name << " is not available." << endl;
}

void Team::status(bool playerInformation)
{

    cout << "Color: " << color << endl;

    if (playerInformation)
    {
        cout << endl << "Players:" << endl;
        for (int playerIndex = 0; playerIndex < 11; playerIndex++)
            if (players[playerIndex].getAge() != 0)
                players[playerIndex].status();
    }
    cout << endl << endl;
}
