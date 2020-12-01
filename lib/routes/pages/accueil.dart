import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Material(
            child: InkWell(
              child: Container(
                height: 200,
                width: 400,
                child: Card(
                  elevation: 10.0,
                  color: Colors.amber[900],
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: incrementCounter,
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
