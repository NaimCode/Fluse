import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void initState() {
    future = getEtablissement();
    // TODO: implement initState
    super.initState();
  }

  getEtablissement() async {
    var future = await firestore().collection('Etablissement').get();

    print('after query');

    future.docs.forEach((element) {
      Etablissement model = Etablissement.fromMap(element.data());
      listInitial.add(model);
    });
    setState(() {
      listEtablissement = listInitial;
    });

    return 'Complete';
  }

  searchFunction() {
    List m = [];
    if (rechercheEtablissement.text.isEmpty) {
      m = listInitial;
    } else {
      for (Etablissement model in listInitial) {
        if (model.nom
                .toLowerCase()
                .contains(rechercheEtablissement.text.toLowerCase()) ||
            model.ville
                .toLowerCase()
                .contains(rechercheEtablissement.text.toLowerCase())) {
          m.add(model);
        }
      }
    }
    setState(() {
      listEtablissement = m;
    });
  }

  dispose() {
    super.dispose();
  }

  TextEditingController rechercheEtablissement = TextEditingController();
  //ScrollController scrollModel = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return chargement();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: searchBar(),
          body: grid(),
        );
      },
    );
  }

  Widget grid() {
    return (listEtablissement.isEmpty)
        ? Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'Aucun établissement ou ville "${rechercheEtablissement.text}"',
                style: TextStyle(
                    fontFamily: 'Ubuntu', fontSize: 20, color: primary),
              ),
            ))
        : Scrollbar(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: listEtablissement.length,
                  itemBuilder: (context, index) {
                    // String image = snapshot.data.docs[index].data()['image'];
                    // String nom = snapshot.data.docs[index].data()['nom'];
                    // String ville = snapshot.data.docs[index].data()['ville'];
                    // String description =
                    //     snapshot.data.docs[index].data()['description'];
                    // String lien = snapshot.data.docs[index].data()['lien'];

                    return ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => NetworkGiffyDialog(
                                  image: Image.network(
                                    listEtablissement[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                      '${listEtablissement[index].nom}, ${listEtablissement[index].ville}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600)),
                                  description: Text(
                                    listEtablissement[index].description,
                                    textAlign: TextAlign.center,
                                  ),
                                  entryAnimation: EntryAnimation.BOTTOM,
                                  onOkButtonPressed: () async {
                                    await launch(
                                        'https://${listEtablissement[index].lien}');
                                  },
                                  buttonOkText: Text(
                                    'Site internet',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Ubuntu',
                                        fontSize: 18),
                                  ),
                                  buttonOkColor: primary,
                                  buttonCancelColor: Colors.white,
                                  buttonCancelText: Text('Retour',
                                      style: TextStyle(
                                          color: primary,
                                          fontFamily: 'Tomorrow',
                                          fontSize: 18)),
                                ));
                      },
                      leading: Image.network(
                        listEtablissement[index].image,
                        width: (Get.width <= 410) ? 100 : 200,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        listEtablissement[index].nom,
                        style: TextStyle(
                            fontSize: 20, fontFamily: 'Ubuntu', color: primary),
                      ),
                      subtitle: Text(
                        listEtablissement[index].ville,
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Ubuntu',
                            color: primary.withOpacity(0.8)),
                      ),
                    );
                  },
                )));
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
              width: 2.0,
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
                  searchFunction();
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
