import 'package:flutter/material.dart';
import 'dart:math';
import 'package:animated_button/animated_button.dart';
import 'package:cardgame/values.dart';
import 'package:cardgame/homePage.dart';
import 'package:cardgame/flipCard.dart';
import 'package:cardgame/scoreDisplay.dart';

var card = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'K', 'Q'];
var value = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  var guessCard;
  var guessCardType;
  var currentCard;
  var currentCardType;
  var lastCard1;
  var lastCard1Type;
  var lastCard2;
  var lastCard2Type;
  var lastCard3;
  var lastCard3Type;
  var lastCard4;
  var lastCard4Type;
  var lastCard5;
  var lastCard5Type;
  var gameScore = 0;
  final controller = FlipCardController();

  void pushToSlot() { // function to push values between previous cards
    lastCard5 = lastCard4;
    lastCard5Type = lastCard4Type;
    lastCard4 = lastCard3;
    lastCard4Type = lastCard3Type;
    lastCard3 = lastCard2;
    lastCard3Type = lastCard2Type;
    lastCard2 = lastCard1;
    lastCard2Type = lastCard1Type;
    lastCard1 = currentCard;
    lastCard1Type = currentCardType;
    currentCard = guessCard;
    currentCardType = guessCardType;
    rollGuess();
  }

  void rollGuess() {
    guessCard = Value().cardValue[Random().nextInt(Value().cardValue.length)];
    guessCardType = Value().cardType[Random().nextInt(Value().cardType.length)];
  }

  charToInt(var input) { //function to get int value of card by matching the beginning char of the card
    var output = 0;
    for (int i = 0; i < 13; i++) {
      if (input.startsWith(card[i])) {
        output = value[i];
        return output;
      }
    }
  }

  Future openDialogMenu() => showDialog( //Alert Dialog that displays when the home button on the app bar or the physical back button
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20)
                )
              ),
          backgroundColor: Color.fromARGB(180, 225, 215, 0),
          title: const Text('Menu', textAlign: TextAlign.center, style: TextStyle(fontSize: 40),),
          content: const Text('Exit the current game?', textAlign: TextAlign.center,),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('No', style: TextStyle(color: Colors.black)),
                  onPressed: () {Navigator.pop(context);},
                ),
                TextButton(
                  onPressed: () {Navigator.pushAndRemoveUntil(context, FadeRoute(page: const MyHomePage(title: '')), (route) => false);},
                  child: const Text('Yes', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      );

  Future openDialogEnd() => showDialog( //Alert Dialog to notify user of lost
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20)
                  )
                 ),
              backgroundColor: Color.fromARGB(180, 221, 221, 211),
              title: const Text('Game Over!', textAlign: TextAlign.center, style: TextStyle(fontSize: 40),),
              content: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset('assets/backgrounds/scoreContainer.png', height: 400, width: 400, fit: BoxFit.fill,),
                Text('Your Score:\n\n$gameScore', textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, color: Colors.white),),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {Navigator.pushAndRemoveUntil(context, FadeRoute(page: const MyHomePage(title: '',)), (route) => false);},
                  child: const Text('Home', style: TextStyle(color: Colors.black),),
                ),
                TextButton(
                    onPressed: () {Navigator.pushAndRemoveUntil(context, FadeRoute(page: GamePage()), (route) => false);},
                    child: const Text('Retry', style: TextStyle(color: Colors.black),)),
              ],
            ),
            onWillPop: () async => false,
          );
        },
      );
    
  @override
  void initState() {
    super.initState();

    guessCard = Value().cardValue[Random().nextInt(Value().cardValue.length)];
    guessCardType = Value().cardType[Random().nextInt(Value().cardType.length)];
    currentCard = Value().cardValue[Random().nextInt(Value().cardValue.length)];
    currentCardType =
        Value().cardType[Random().nextInt(Value().cardType.length)];

    lastCard1 = "temp";
    lastCard1Type = "Slot";
    lastCard2 = "temp";
    lastCard2Type = "Slot";
    lastCard3 = "temp";
    lastCard3Type = "Slot";
    lastCard4 = "temp";
    lastCard4Type = "Slot";
    lastCard5 = "temp";
    lastCard5Type = "Slot";
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Stack(
      children: <Widget>[
        WillPopScope( // trigger when user presses the physical back button, opens the in-game menu
          onWillPop: () async {openDialogMenu(); return false;},
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black, //appbar color
              titleSpacing: 0,
              leading:
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: AnimatedButton(onPressed: () {openDialogMenu();}, //opens the menu dialog if the home button icon is pressed
                  height: 55,
                  width: 55,
                  color: Colors.transparent,
                  child: Image.asset('assets/buttons/menu.png', scale: 1.0,),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: scoreDisplay(gameScore),
                  ),
                ),
                SizedBox(width: 5,),
              ],
              elevation: 5.0,
            ),
            body: Center(
              child: Container(
                margin: deviceInfo.padding,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/backgrounds/game.png'),
                    fit: BoxFit.fill,
                    ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: deviceInfo.padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  runAlignment: WrapAlignment.center,
                  spacing: 10,
                  children: <Widget>[
                    Container(
                      height: 250,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: FlipCardWidget( //flips when you guess incorrectly
                        controller: controller,
                        front: Image.asset(
                            'assets/faces/${guessCard}${guessCardType}.png',),
                        back: Image.asset('assets/faces/backCard.png',),
                      ),
                    ),
                    Container(
                      height: 250,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${currentCard}${currentCardType}.png',),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: deviceInfo.viewInsets,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: Wrap(
                  spacing: 10,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard1}${lastCard1Type}.png'),
                    ),
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard2}${lastCard2Type}.png'),
                    ),
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard3}${lastCard3Type}.png'),
                    ),
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard4}${lastCard4Type}.png'),
                    ),
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                          'assets/faces/${lastCard5}${lastCard5Type}.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 130.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedButton(
                    height: 90,
                    color: Colors.transparent,
                    onPressed: () {setState(() {
                          if (charToInt(guessCard) > charToInt(currentCard)) {
                            gameScore += 10;
                            pushToSlot();
                          } else {
                            controller.flipCard();
                            openDialogEnd();
                          }},);},
                    child: Image.asset('assets/buttons/highbutton.png', scale: 3.5,),
                  ),
                  AnimatedButton(
                    height: 90,
                    color: Colors.transparent,
                    onPressed: () {setState(() {
                      if (charToInt(guessCard) == charToInt(currentCard)) {
                        gameScore += 10;
                        pushToSlot();
                      } else {
                        controller.flipCard();
                        openDialogEnd();
                      }},);},
                    child: Image.asset('assets/buttons/equalbutton.png', scale: 3.5,),
                  ),
                  AnimatedButton(
                    height: 90,
                    color: Colors.transparent,
                    onPressed: () {setState(() {
                          if (charToInt(guessCard) < charToInt(currentCard)) {
                            gameScore += 10;
                            pushToSlot();
                          } else {
                            controller.flipCard();
                            openDialogEnd();
                          }},);},
                    child: Image.asset('assets/buttons/lowbutton.png', scale: 3.5,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
