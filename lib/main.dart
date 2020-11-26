import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/routes/home.dart';
import 'package:website_university/routes/pages/ajoutEtablissement.dart';
import 'package:website_university/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ibn Tofail',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: AjoutEtablissement(),
      debugShowCheckedModeBanner: false,
    );
  }
}
