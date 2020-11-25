import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/routes/home.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String selectItemNav = 's\'enregistrer';
  String erreurEmail = '';
  String erreurPassword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Row(
          children: [
            //Left
            (MediaQuery.of(context).size.width >= 840)
                ? Expanded(
                    flex: 3,
                    child: Container(
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: Image.asset('left1.png')),
                          Expanded(child: Image.asset('left2.png')),
                        ],
                      ),
                    ),
                  )
                : Container(),
            //Center
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: (selectItemNav != 'se connecter')
                    ? enregistrement()
                    : connexion(),
              ),
            ),
            //Right
            (MediaQuery.of(context).size.width >= 840)
                ? Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: Image.asset('right1.png')),
                          Expanded(child: Image.asset('right2.png')),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Container enregistrement() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Container(
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Image.asset('logo.png'),
            ),
          ),
          //Connextion-Enregistrement
          selectButton(),
          SizedBox(
            height: 20,
          ),
          //body
          Container(
            child: Column(
              children: [
                Container(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.person_sharp, color: primary),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            //                    <--- top side
                            color: backColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: (MediaQuery.of(context).size.width <= 340)
                            ? 240
                            : 290.0,
                        child: TextFormField(
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Nom'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.mail, color: primary),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            //                    <--- top side
                            color: backColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: (MediaQuery.of(context).size.width <= 340)
                            ? 240
                            : 290.0,
                        child: TextFormField(
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Email'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.lock, color: primary),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            //                    <--- top side
                            color: backColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: (MediaQuery.of(context).size.width <= 340)
                            ? 240
                            : 290.0,
                        child: TextFormField(
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Mot de passe'),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ou s\'enregistrer avec :',
                      style: TextStyle(fontFamily: 'Didac'),
                    ),
                  ),
                ),
                Container(
                  child: Wrap(
                    // alignment: WrapAlignment.spaceAround,
                    children: [
                      FlatButton(
                        child: Image.asset(
                          'facebook.png',
                          height: 40,
                          width: 40,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      FlatButton(
                        child: Image.asset(
                          'google.png',
                          height: 40,
                          width: 40,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Si vous avez déjà un compte, veuillez-vous connecter',
                        style: TextStyle(fontFamily: 'Didac', fontSize: 12)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Tooltip(
                    message: 'Valider',
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primary,
                      onPressed: () {
                        Get.off(Home());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 30.0),
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container connexion() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Container(
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Image.asset('logo.png'),
            ),
          ),
          //Connextion-Enregistrement
          selectButton(),
          SizedBox(
            height: 20,
          ),
          //body
          Container(
            child: Column(
              children: [
                Container(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.mail, color: primary),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            //                    <--- top side
                            color: backColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: (MediaQuery.of(context).size.width <= 340)
                            ? 240
                            : 290.0,
                        child: TextFormField(
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Email'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.lock, color: primary),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            //                    <--- top side
                            color: backColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: (MediaQuery.of(context).size.width <= 340)
                            ? 240.0
                            : 290.0,
                        child: TextFormField(
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Mot de passe'),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ou se connecter avec :',
                      style: TextStyle(fontFamily: 'Didac'),
                    ),
                  ),
                ),
                Container(
                  child: Wrap(
                    // alignment: WrapAlignment.spaceAround,
                    children: [
                      FlatButton(
                        child: Image.asset(
                          'facebook.png',
                          height: 40,
                          width: 40,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      FlatButton(
                        child: Image.asset(
                          'google.png',
                          height: 40,
                          width: 40,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Si vous n\'avez pas encore un compte, veuillez-vous enregistrer',
                      style: TextStyle(fontFamily: 'Didac', fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Tooltip(
                    message: 'Valider',
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primary,
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 30.0),
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Center selectButton() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
            left: (MediaQuery.of(context).size.width <= 340) ? 0.0 : 35.0),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    selectItemNav = 's\'enregistrer';
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: (selectItemNav == 's\'enregistrer')
                            ? Colors.black
                            : Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  height: 30.0,
                  child: Text(
                    'S\'enregistrer',
                    style: TextStyle(
                        fontFamily: 'Tomorrow', fontSize: 20, color: primary),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    selectItemNav = 'se connecter';
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: (selectItemNav == 'se connecter')
                            ? Colors.black
                            : Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  height: 30.0,
                  child: Text(
                    'Se connecter',
                    style: TextStyle(
                        fontFamily: 'Tomorrow', fontSize: 20, color: primary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
