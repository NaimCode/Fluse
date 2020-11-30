import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:website_university/services/firestorage.dart';
import 'package:firebase_web/firestore.dart';
import 'package:firebase_web/firebase.dart';

class Etablissements extends StatefulWidget {
  @override
  _EtablissementsState createState() => _EtablissementsState();
}

class _EtablissementsState extends State<Etablissements> {
  /////List
  List listEtablissement = [];
  List listInitial = [];
  /////future
  var future;
  Stream streamEta;

  @override
  void initState() {
    streamEta = firestore().collection('Etablissement').onSnapshot;
    // TODO: implement initState
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  TextEditingController rechercheEtablissement = TextEditingController();
  //ScrollController scrollModel = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return chargement();
        return Scaffold(
          appBar: searchBar(),
          body: grid(),
        );
      },
    );
  }

  StreamBuilder grid() {
    return StreamBuilder(
      stream: streamEta,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          listEtablissement.clear();
          snapshot.data.docs.forEach((element) {
            Etablissement model = Etablissement.fromMap(element.data());
            listEtablissement.add(model);
          });
          //print(listEtablissement.length);
        } else
          print('en cours');
        return snapshot.hasData
            ? Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                    itemCount: snapshot.data.docs.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            ((Get.width <= 1000 && Get.width > 810) ||
                                    (Get.width < 600))
                                ? 1
                                : 2),
                    itemBuilder: (context, index) {
                      String image = snapshot.data.docs[index].data()['image'];
                      String nom = snapshot.data.docs[index].data()['nom'];
                      String ville = snapshot.data.docs[index].data()['ville'];
                      String description =
                          snapshot.data.docs[index].data()['description'];
                      String lien = snapshot.data.docs[index].data()['lien'];

                      bool searched = (rechercheEtablissement.text.isEmpty ||
                          nom.toLowerCase().contains(
                              rechercheEtablissement.text.toLowerCase()) ||
                          ville.toLowerCase().contains(
                              rechercheEtablissement.text.toLowerCase()));
                      return searched
                          ? Tooltip(
                              message: 'Afficher plus de détail',
                              child: InkWell(
                                hoverColor: primary,
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: primary,
                                    elevation: 8.8,
                                    child: Container(
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: Image.network(
                                              image,
                                              // height: ((Get.width <= 1000 && Get.width > 810) ||
                                              //         (Get.width < 600))
                                              //     ? 200
                                              //     : 50.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            color: primary.withOpacity(0.5),
                                            height: 100,
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                                left: 8.0, bottom: 8.0),
                                            child: Scrollbar(
                                              // controller: scrollModel,
                                              // isAlwaysShown: true,
                                              child: ListView(
                                                children: [
                                                  Text(
                                                    nom,
                                                    style: TextStyle(
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: 29,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    ville,
                                                    style: TextStyle(
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: 18,
                                                        color: Colors.white70),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : null;
                    },
                  ),
                ),
              )
            : chargement();
      },
    );
  }

  AppBar searchBar() {
    return AppBar(
      leading: null,
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Padding(
        padding:
            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              //                    <--- top side
              color: backColor,
              width: 3.0,
            ),
          ),
          height: 50,
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: rechercheEtablissement,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 16, top: 11, right: 15),
                    hintText: 'Recherche'),
              )),
              IconButton(
                tooltip: 'Rechercher',
                alignment: Alignment.center,
                color: primary,
                onPressed: () {
                  setState(() {
                    streamEta =
                        firestore().collection('Etablissement').onSnapshot;
                  });
                },
                icon: Icon(
                  Icons.search,
                  color: primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ListView.builder(
//           itemCount: list.length,
//           itemBuilder: (context, index) {
//             return (index == 0)
//                 ? Container()
//                 : Container(
//                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                     height: 200.0,
//                     child: InkWell(
//                       onTap: () {},
//                       child: Card(
//                         elevation: 10.0,
//                         color: Colors.purple,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset(
//                                   list[index].image,
//                                   width: 400.0,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 padding: EdgeInsets.only(
//                                   top: 8.0,
//                                 ),
//                                 height: double.infinity,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       list[index].nom,
//                                       style: TextStyle(
//                                           fontFamily: 'Ubuntu',
//                                           fontSize: 25,
//                                           color: Colors.white),
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Text(
//                                       list[index].ville,
//                                       style: TextStyle(
//                                           fontFamily: 'Ubuntu',
//                                           fontSize: 18,
//                                           color: Colors.white70),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Expanded(
//                                         child: Text(
//                                       list[index].description,
//                                       style: TextStyle(
//                                           fontFamily: 'Ubuntu',
//                                           fontSize: 14,
//                                           color: Colors.white60),
//                                     ))
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//           },
//         ),
