import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  double elev = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Material(
            child: InkWell(
              onHover: (isH) {
                setState(() {
                  isH ? elev = 20.0 : elev = 2.0;
                });
              },
              child: Container(
                height: 200,
                width: 400,
                child: Card(
                  elevation: elev,
                  color: Colors.amber[900],
                  child: Center(
                    child: Text('Hi'),
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
