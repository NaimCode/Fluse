import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AjoutEtablissement extends StatefulWidget {
  @override
  _AjoutEtablissementState createState() => _AjoutEtablissementState();
}

class _AjoutEtablissementState extends State<AjoutEtablissement> {
  //StorageUploadTask uploadTask;
  //Controller
  TextEditingController nomController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  ////Bool
  bool imageIsCharging = true;

  ///
  String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('Ajout d\'un établissement',
              style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20.0))),
      body: Center(
        child: Container(
          height: double.infinity,
          width: 810,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                //add image
                Expanded(child: imageEtablissement()),
                SizedBox(
                  height: 10,
                ),
                //nom de l'etablissment
                nomTextField(),
                SizedBox(
                  height: 10,
                ),
                //nom de l'etablissment
                villeTextField(),
                SizedBox(
                  height: 10,
                ),
                descTextField(),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  tooltip: 'Ajouter',
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: primary,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Tooltip imageEtablissement() {
    return Tooltip(
      message: 'Ajouter une image',
      child: InkWell(
        onTap: () {
          setState(() {
            imageIsCharging = !imageIsCharging;
          });
        },
        child: Card(
          color: backColor,
          elevation: 6,
          child: Container(
              color: backColor,
              height: 300,
              width: 500,
              child: !imageIsCharging
                  ? Icon(
                      Icons.add_a_photo,
                      color: Colors.black45,
                    )
                  : imageChargement()),
        ),
      ),
    );
  }

  Column imageChargement() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitThreeBounce(
          color: primary,
          size: 30.0,
        ),
        Text('Chargement de l\'image')
      ],
    );
  }

  Container descTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          //                    <--- top side
          color: backColor,
          width: 3.0,
        ),
      ),
      //height: 50,
      width: 500,
      child: Stack(
        children: [
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
                hintText: 'Description...'),
          ),
        ],
      ),
    );
  }

  Container villeTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          //                    <--- top side
          color: backColor,
          width: 3.0,
        ),
      ),
      width: 500,
      child: Stack(
        children: [
          TextFormField(
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
                hintText: 'Nom de la ville...'),
          ),
        ],
      ),
    );
  }

  Container nomTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          //                    <--- top side
          color: backColor,
          width: 3.0,
        ),
      ),
      width: 500,
      child: Stack(
        children: [
          TextFormField(
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
                hintText: 'Nom de l\'établissement...'),
          ),
        ],
      ),
    );
  }
}
