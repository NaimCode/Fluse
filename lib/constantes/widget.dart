import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/services/authentification.dart';
import 'package:website_university/services/firestorage.dart';

Container chargement() {
  return Container(
    color: Colors.white,
    child: SpinKitThreeBounce(
      color: primary,
      size: 30,
    ),
  );
}

final snackBarEtablissment = SnackBar(
    content: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'L\'établissement été ajouté',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    ),
    Icon(Icons.verified, color: Colors.white)
  ],
));
final snackBarEtablissementEchec = SnackBar(
    content: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Erreur, verifiez que vous avez saisi tous les champs!',
      style: TextStyle(fontSize: 20.0, color: Colors.red),
    ),
    Icon(
      Icons.error,
      color: Colors.red,
    )
  ],
));

final snackBarDocument = SnackBar(
    content: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Le document été ajouté',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    ),
    Icon(Icons.verified, color: Colors.white)
  ],
));
final snackBarDocumentEchec = SnackBar(
    content: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Erreur, verifiez que vous avez saisi tous les champs!',
      style: TextStyle(fontSize: 20.0, color: Colors.red),
    ),
    Icon(
      Icons.error,
      color: Colors.red,
    )
  ],
));

Widget popMenu(Widget profile) {
  return PopupMenuButton(
      tooltip: 'Plus',
      child: profile,
      onSelected: (value) async {
        switch (value) {
          case 3:
            Get.defaultDialog(
                title: 'Déconnexion',
                middleText: 'Vous êtes sur point de vous déconnecter !',
                actions: [
                  FlatButton(
                    onPressed: () async {
                      Get.back();
                    },
                    child: Text(
                      'Annuler',
                      style: TextStyle(color: primary, fontFamily: 'Didac'),
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FlatButton(
                    onPressed: () async {
                      Get.back();
                      await Authentification(FirebaseAuth.instance)
                          .deconnection();
                    },
                    child: Text(
                      'Se déconnecter',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Didac'),
                    ),
                    color: primary,
                  )
                ]);
            break;
          default:
        }
      },
      itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(Icons.person),
                    ),
                    Text('Mon compte')
                  ],
                )),
            PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.settings)),
                    Text('Paramètre')
                  ],
                )),
            PopupMenuItem(
                value: 3,
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.exit_to_app)),
                    Text('Se déconnecter')
                  ],
                )),
          ]);
}
