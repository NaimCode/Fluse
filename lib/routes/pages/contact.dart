import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/widget.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool isCharging = false;
  sendMessage() async {
    if (mail.text.isEmail && objet.text.isNotEmpty && message.text.isNotEmpty) {
      setState(() {
        isCharging = true;
      });
      var document = {
        'mail': mail.text,
        'tel': tel.text,
        'objet': objet.text,
        'message': message.text,
      };

      await FirebaseFirestore.instance.collection('Contact-us').add(document);
      Get.rawSnackbar(
          title: 'Envoi',
          message: 'Envoi réussi',
          icon: Icon(
            Icons.verified,
            color: Colors.white,
          ));
      setState(() {
        isCharging = false;
        mail.clear();
        tel.clear();
        objet.clear();
        message.clear();
      });
    } else
      Get.rawSnackbar(
          title: 'Envoi',
          message: 'Erreur, vérifiez que vous avez saisi tous les champs!',
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController mail = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController objet = TextEditingController();
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseStorage.instance
            .ref()
            .child("Assets/contact.png")
            .getDownloadURL(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return chargement();
          print(snapshot.data);
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                tooltip: 'Envoyez',
                child: isCharging
                    ? chargement()
                    : Icon(Icons.send, color: Colors.white),
                onPressed: sendMessage,
                backgroundColor: primary,
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  // width: 400,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        child: Image.network(
                          snapshot.data,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Text(
                        'Contactez-nous',
                        style: TextStyle(
                            fontFamily: 'Tomorrow',
                            fontSize: 24,
                            color: primary),
                      ),
                      Center(
                        child: Container(
                          width: 450,
                          child: Column(
                            children: [
                              mailTextField(),
                              telTextField(),
                              objetTextField(),
                              messTextField(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  Widget mailTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            //                    <--- top side
            color: backColor,
            width: 2.0,
          ),
        ),
        child: TextFormField(
          controller: mail,
          textInputAction: TextInputAction.send,
          keyboardType: TextInputType.emailAddress,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
              hintText: 'Votre email'),
        ),
      ),
    );
  }

  Widget telTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            //                    <--- top side
            color: backColor,
            width: 2.0,
          ),
        ),
        child: TextFormField(
          controller: tel,
          keyboardType: TextInputType.phone,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
              hintText: 'Tél (Optionnel)'),
        ),
      ),
    );
  }

  Widget objetTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            //                    <--- top side
            color: backColor,
            width: 2.0,
          ),
        ),
        child: TextFormField(
          controller: objet,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
              hintText: 'Objet'),
        ),
      ),
    );
  }

  Widget messTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            //                    <--- top side
            color: backColor,
            width: 2.0,
          ),
        ),
        child: TextFormField(
          controller: message,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
              hintText: 'Rédigez votre message'),
        ),
      ),
    );
  }
}
