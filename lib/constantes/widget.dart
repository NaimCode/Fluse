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

Widget erreurChargement(String erreur) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      child: Center(
        child: Text(
          erreur,
          style: TextStyle(fontSize: 16, color: Colors.redAccent),
        ),
      ),
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
