import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:website_university/routes/home.dart';
import 'package:get/get.dart';
import 'package:website_university/services/authentification.dart';
import 'package:website_university/services/variableStatic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String selectItemNav = 'se connecter';
  bool obscure = true;
  bool isCharging = false;

  String facebookLogo = '';
  String googleLogo = '';
  var future;
  getasset() async {
    facebookLogo = await FirebaseStorage.instance
        .ref()
        .child("Assets/facebook.png")
        .getDownloadURL();
    googleLogo = await FirebaseStorage.instance
        .ref()
        .child("Assets/google.png")
        .getDownloadURL();
    return 'Complete';
  }

  @override
  void initState() {
    future = getasset();
    // TODO: implement initState
    super.initState();
  }

//////////////Section connection
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  bool erreurPassword = false;
  bool erreurMail = false;
  bool connectable = true;
  connexionVerif() async {
    setState(() {
      isCharging = true;
    });
    if (!mail.text.isEmail) {
      setState(() {
        erreurMail = true;
      });
    } else {
      var check = await context
          .read<Authentification>()
          .connection(mail.text.trim(), password.text.trim());
      Get.rawSnackbar(
          title: 'Connexion',
          message: check,
          icon: (check == 'Connexion réussi, ravis de vous revoir')
              ? Icon(Icons.verified, color: Colors.white)
              : Icon(
                  Icons.error_sharp,
                  color: Colors.red,
                ));
      switch (check) {
        case 'Connexion réussi, ravis de vous revoir':
          //go home
          break;
        case 'L\'Email est incorrect':
          setState(() {
            erreurMail = true;
          });
          break;
        case 'Le mot de passe est incorrect':
          setState(() {
            erreurPassword = true;
            erreurMail = false;
          });
          break;
        default:
      }
    }
    setState(() {
      isCharging = false;
    });
  }

  /////////////////
  /////////////////Section enregistrement
  TextEditingController mailE = TextEditingController();
  TextEditingController passwordE = TextEditingController();
  TextEditingController nomE = TextEditingController();
  bool erreurPasswordE = false;
  bool erreurMailE = false;
  bool erreurNomE = false;
  bool connectableE = true;
  enregistrementVerif() async {
    setState(() {
      isCharging = true;
    });
    if (!mailE.text.isEmail) {
      Get.rawSnackbar(
          title: 'Enregistrement',
          message: 'L\'Email est incorrect',
          icon: Icon(
            Icons.error_sharp,
            color: Colors.red,
          ));
      setState(() {
        erreurMailE = true;
      });
    } else {
      var check = await context.read<Authentification>().enregistrementAuth(
          mailE.text.trim(), passwordE.text.trim(), nomE.text.trim());
      Get.rawSnackbar(
          title: 'Enregistrement',
          message: check,
          icon: Icon(
            (check == 'Enregistrement réussi, bienvenue à vous')
                ? Icon(Icons.verified, color: Colors.white)
                : Icons.error_sharp,
            color: Colors.red,
          ));

      switch (check) {
        case 'Enregistrement réussi, bienvenue à vous':

          //go home
          break;
        case 'Email existe déjà':
          setState(() {
            erreurMailE = true;
          });
          break;
        case 'Le mot de passe est trop faible, minimum 6 caratères':
          setState(() {
            erreurPasswordE = true;
            erreurMailE = false;
          });
          break;
        case 'L\'Email est invalide':
          setState(() {
            erreurMailE = true;
          });
          break;
        default:
      }
    }
    setState(() {
      isCharging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return chargement();
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
                              Expanded(child: Image.network(left1)),
                              Expanded(child: Image.network(left2)),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                //Center
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                      child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //logo
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(38.0),
                            child: Image.network(
                              logo,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 32),
                          width: (MediaQuery.of(context).size.width <= 340)
                              ? 240
                              : 290.0,
                          decoration: BoxDecoration(
                            color: Color(0xff1976d2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await context
                                  .read<Authentification>()
                                  .signInWithFacebook();
                            },
                            child: Row(
                              children: [
                                SizedBox(height: 20),
                                Image.network(
                                  facebookLogo,
                                  height: 40,
                                  width: 40,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Continuer avec Facebook',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Ubuntu'),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 32),
                          width: (MediaQuery.of(context).size.width <= 340)
                              ? 240
                              : 290.0,
                          decoration: BoxDecoration(
                            color: Color(0xffea4335),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await context
                                  .read<Authentification>()
                                  .signInWithGoogle();
                            },
                            child: Row(
                              children: [
                                SizedBox(height: 20),
                                Image.network(
                                  googleLogo,
                                  height: 40,
                                  width: 40,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Continuer avec Google',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Ubuntu'),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Connextion-Enregistrement
                        selectButton(),
                        SizedBox(
                          height: 20,
                        ),
                        //body

                        (selectItemNav == 'se connecter')
                            ? connectionSection()
                            : enregistrementSection(),
                      ],
                    ),
                  )
                      //  (selectItemNav == 'se connecter')
                      //     ? connexion()
                      //     : enregistrement(),
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
                              Expanded(child: Image.network(right1)),
                              Expanded(child: Image.network(right2)),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  Container enregistrementSection() {
    return Container(
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
                      color: erreurNomE ? Colors.red : backColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width:
                      (MediaQuery.of(context).size.width <= 340) ? 240 : 290.0,
                  child: TextFormField(
                    controller: nomE,
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
                      color: erreurMailE ? Colors.red : backColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width:
                      (MediaQuery.of(context).size.width <= 340) ? 240 : 290.0,
                  child: TextFormField(
                    controller: mailE,
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
                      color: erreurPasswordE ? Colors.red : backColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width:
                      (MediaQuery.of(context).size.width <= 340) ? 240 : 290.0,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        controller: passwordE,
                        obscureText: obscure ? true : false,
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
                      IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: obscure
                            ? Icon(
                                Icons.visibility,
                                size: 20,
                              )
                            : Icon(Icons.visibility_off, size: 20),
                      )
                    ],
                  ),
                ),
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
          isCharging
              ? chargement()
              : Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Tooltip(
                    message: 'Valider',
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primary,
                      onPressed: enregistrementVerif,
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
    );
  }

  Center connectionSection() {
    return Center(
      child: Container(
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
                        color: erreurMail ? Colors.red : backColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: (MediaQuery.of(context).size.width <= 340)
                        ? 240
                        : 290.0,
                    child: TextFormField(
                      controller: mail,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 5, top: 5, right: 15),
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
                        color: erreurPassword ? Colors.red : backColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: (MediaQuery.of(context).size.width <= 340)
                        ? 240.0
                        : 290.0,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          controller: password,
                          obscureText: obscure ? true : false,
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
                        IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: obscure
                              ? Icon(
                                  Icons.visibility,
                                  size: 20,
                                )
                              : Icon(Icons.visibility_off, size: 20),
                        )
                      ],
                    ),
                  ),
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
            isCharging
                ? chargement()
                : Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Tooltip(
                      message: 'Valider',
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: primary,
                        onPressed: connexionVerif,
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
          ],
        ),
      ),
    );
  }
}
