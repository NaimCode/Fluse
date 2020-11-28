import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/services/firestorage.dart';

Scaffold chargement() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SpinKitThreeBounce(
      color: primary,
      size: 30,
    ),
  );
}
