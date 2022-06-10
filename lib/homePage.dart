import 'package:flutter/material.dart';
import 'package:cardgame/gamePage.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:animated_button/animated_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future openDialogHelp() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help', textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(180, 225, 215, 0)),),
        backgroundColor: Colors.transparent,
        content: Stack(
          alignment: Alignment.center,
          children: <Widget>[
           Image.asset(
              'assets/backgrounds/dialog.png', height: 200, width: 800, fit: BoxFit.fill,
              ),
           Text(
          'How to Play\n\nA card is shown and the player has to guess if the next card is >, = or < the current card. \nIf you guess correctly, you get points.If you get it wrong, the game ends.',
           textAlign: TextAlign.center,
           style:TextStyle(color: Colors.black,fontSize: 16),
          ),
         ],
        ),
        actions: [
          Center(
            child: TextButton(
              child: const Text('Ok', style: TextStyle(color: Color.fromARGB(180, 225, 215, 0)),),
              onPressed: () {Navigator.pop(context);},
            ),
          ),
        ],
      ),
  );

  Future openDialogInfo() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('About',textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(180, 225, 215, 0)),),
      backgroundColor: Colors.transparent,
       content: Stack(
          alignment: Alignment.center,
          children: <Widget>[
           Image.asset(
              'assets/backgrounds/dialog2.png', height: 200, width: 800,
              ),
           Text(
              'Created by:\n\nRogelio C. Suganob Jr.\nBSCpE - 3B',
             textAlign: TextAlign.center,
             style:TextStyle(color: Colors.black,fontSize: 18),
          ),
         ],
        ),
      actions: [
        Center(
          child: TextButton(
            child: const Text('Ok', style: TextStyle(color: Color.fromARGB(180, 225, 215, 0))),
            onPressed: () {Navigator.pop(context);},
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to exit')),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/backgrounds/home.png',),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
              alignment: Alignment.topRight, 
              child: Container(
                width: 600,
                height: 500,
                decoration: const BoxDecoration( 
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/logos/logo.png',
                    ),
                  ),
                ),
              ),
             ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Align(alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedButton(
                        width: 600,
                        height: 100,
                        color: Colors.transparent,
                        onPressed: () {Navigator.pushReplacement(context, FadeRoute(page: GamePage()));},
                        child: Image.asset('assets/buttons/playbutton.png', fit: BoxFit.contain),
                      ),
                      AnimatedButton(
                        width: 600,
                        height: 80,
                        color: Colors.transparent,
                        onPressed: () {openDialogHelp();},
                        child: Image.asset('assets/buttons/helpbutton.png', fit: BoxFit.contain),
                      ),
                      AnimatedButton(
                        width: 600,
                        height: 60,
                        color: Colors.transparent,
                        onPressed: () {openDialogInfo();},
                        child: Image.asset('assets/buttons/aboutbutton.png', fit: BoxFit.contain),
                      ),
                    ],
                  ),
                 ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  //custom fade animation to use when switching pages
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
