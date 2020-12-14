import 'package:firebase/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:website_university/services/variableStatic.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  var eta;
  var doc;
  var con;
  var abo;
  var future;
  double botIntro = 0.0;
  getAssets() async {
    doc = await FirebaseStorage.instance
        .ref()
        .child("Assets/document.png")
        .getDownloadURL();
    eta = await FirebaseStorage.instance
        .ref()
        .child("Assets/etablissement.png")
        .getDownloadURL();
    con = await FirebaseStorage.instance
        .ref()
        .child("Assets/contact.png")
        .getDownloadURL();
    abo = await FirebaseStorage.instance
        .ref()
        .child("Assets/about.png")
        .getDownloadURL();
    return 'Complete';
  }

  @override
  void initState() {
    future = getAssets();
    // TODO: implement initState
    super.initState();
  }

  ScrollController sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return chargement();
          return Scaffold(
              backgroundColor: Colors.white,
              body: SmoothScrollWeb(
                controller: sc,
                child: Container(
                  child: Center(
                    child: intro(),
                    // child: ListView(
                    //   controller: sc,
                    //   children: [
                    //     intro(),
                    //     etaF(),
                    //     docF(),
                    //     aboF(),
                    //     conF(),
                    //   ],
                    // ),
                  ),
                ),
              ));
        });
  }

  Widget docF() {
    return Container(
      height: 350,
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Image.network(doc),
              ),
            ),
            Expanded(
                child: Container(
                    child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Vous souhaitez étudier  ou poursuivre vos études au Maroc? mais vous ne savez pas quel université ou école choisir?',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Didac',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Pas d’inquiétude! Vous trouverez pour chaque établissment les détails pour la formation que vous cherchez et pour plus d'information, vous aurez un lien vers cet établissement.",
                      style: TextStyle(
                        fontFamily: 'Didac',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )))
          ],
        ),
      ),
    );
  }

  Container etaF() {
    return Container(
      height: 350,
      child: Center(
        child: Row(
          children: [
            Expanded(
                child: Container(
                    child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Vous souhaitez étudier  ou poursuivre vos études au Maroc? mais vous ne savez pas quel université ou école choisir?',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Didac',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Pas d’inquiétude! Vous trouverez pour chaque établissment les détails pour la formation que vous cherchez et pour plus d'information, vous aurez un lien vers cet établissement.",
                      style: TextStyle(
                        fontFamily: 'Didac',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ))),
            Expanded(
              child: Container(
                child: Image.network(eta),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container conF() {
    return Container(
      height: 350,
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Image.network(con),
              ),
            ),
            Expanded(
                child: Container(
                    child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Vous souhaitez étudier  ou poursuivre vos études au Maroc? mais vous ne savez pas quel université ou école choisir?',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Didac',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Pas d’inquiétude! Vous trouverez pour chaque établissment les détails pour la formation que vous cherchez et pour plus d'information, vous aurez un lien vers cet établissement.",
                      style: TextStyle(
                        fontFamily: 'Didac',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )))
          ],
        ),
      ),
    );
  }

  Container aboF() {
    return Container(
      height: 350,
      child: Center(
        child: Row(
          children: [
            Expanded(
                child: Container(
                    child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Vous souhaitez étudier  ou poursuivre vos études au Maroc? mais vous ne savez pas quel université ou école choisir?',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Didac',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Pas d’inquiétude! Vous trouverez pour chaque établissment les détails pour la formation que vous cherchez et pour plus d'information, vous aurez un lien vers cet établissement.",
                      style: TextStyle(
                        fontFamily: 'Didac',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ))),
            Expanded(
              child: Container(
                child: Image.network(abo),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget intro() {
    return SizedBox(
  width: 250.0,
  child: TypewriterAnimatedTextKit(
    onTap: () {
        print("Tap Event");
      },
    text: [
      "Discipline is the best tool",
      "Design first, then code",
      "Do not patch bugs out, rewrite them",
      "Do not test bugs out, design them out",
    ],
    textStyle: TextStyle(
        fontSize: 30.0,
        fontFamily: "Agne"
    ),
    textAlign: TextAlign.start,
  ),
);
    //  Container(
    //   height: 400,
    //   width: double.infinity,
    //   color: primary,
    //   child: Padding(
    //     padding: EdgeInsets.only(bottom: botIntro),
    //     child: TextLiquidFill(
    //       text: 'LIQUIDY',
    //       waveColor: Colors.blueAccent,
    //       boxBackgroundColor: Colors.redAccent,
    //       textStyle: TextStyle(
    //         fontSize: 80.0,
    //         fontWeight: FontWeight.bold,
    //       ),
    //       boxHeight: 300.0,
    //     ),
    //     // child: Text(
    //     //   'Bienvenue à Fluse',
    //     //   style: TextStyle(
    //     //       fontSize: 26, color: Colors.white, fontFamily: 'Tomorrow'),
    //     // ),
    //   ),
    // );
  }
}
