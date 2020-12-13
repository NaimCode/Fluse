import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:hover_effect/hover_effect.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:website_university/routes/home.dart';
import 'package:website_university/services/service.dart';
import 'package:website_university/services/variableStatic.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: must_be_immutable
class Notifications extends StatefulWidget {
  bool isMobile;
  Utilisateur user;
  Notifications(this.isMobile, this.user);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List listNotifications = [];
  List listInitiale = [];
  List list = [];
  bool detail = false;
  String pdfurl;
  Utilisateur utilisateur;
  var filiere;
  var semestre;
  var future;
  @override
  void initState() {
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    filiere = widget.user.filiere;
    semestre = widget.user.semestre;
    future = getNotification();
    super.initState();
  }

  getNotification() async {
    var future = await fb
        .firestore()
        .collection('Notification')
        .orderBy('date', 'desc')
        // .where('filiere', '==', filiere)
        // .where('semestre', '==', semestre)
        .get();

    future.docs.forEach((element) {
      listInitiale.add(Information(
        username: element.data()['username'],
        userimage: element.data()['userimage'],
        filiere: element.data()['filiere'],
        documentID: element.data()['documentID'],
        semestre: element.data()['semestre'],
        date: element.data()['date'],
      ));
    });
    setState(() {
      listNotifications = listInitiale;
    });

    return 'Complete';
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 810 && widget.isMobile == true) {
      Navigator.pop(context);
    }
    initializeDateFormatting();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Utilisateur')
            .doc(widget.user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting)
          //   return chargement();
          if (snapshot.connectionState == ConnectionState.none)
            return erreurChargement('Erreur de connexion');
          if (snapshot.hasData) {
            var user = snapshot.data;

            filiere = user['filiere'];
            semestre = user['semestre'];
            list.clear();

            listNotifications.forEach((element) {
              if (element.filiere == filiere && element.semestre == semestre) {
                list.add(element);
              }
            });
          }
          return Scaffold(
            appBar: AppBar(
              //check
              title: Tooltip(
                message: 'Notifications',
                child: Icon(
                  Icons.notifications,
                  size: 35,
                  color: primary,
                ),
              ),
              centerTitle: true,
              elevation: (Get.width >= 810) ? 0.0 : 5.0,
              backgroundColor: (Get.width <= 810) ? Colors.white : backColor,
              leading: widget.isMobile
                  ? IconButton(
                      icon: Icon(
                        Icons.expand_more,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : null,
            ),
            body: (filiere == null || semestre == null)
                ? Container(
                    color: backColor,
                    padding: EdgeInsets.only(left: 8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Pour récevoir les notifications, veuillez indiquer votre filière ainsi que votre semestre',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, color: primary.withOpacity(0.8)),
                          ),
                          Text(
                            'Menu->Profil',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ))
                : Container(
                    color: backColor,
                    child: FutureBuilder(
                        future: future,
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting)
                            return chargement();
                          if (snap.connectionState == ConnectionState.none)
                            return erreurChargement('Erreur de connexion');
                          return Scrollbar(
                            child: list.isNotEmpty
                                ? ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 20.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 10.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                userSectionn(index),
                                                contentSection(index),
                                                dateSection(index)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Text('Aucune notification'),
                                  ),
                          );
                        }),
                  ),
          );
        });
  }

  Container userSectionn(int index) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            //                    <--- top side
            color: backColor,

            width: 1.0,
          ),
        ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(list[index].userimage ?? profile),
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                list[index].username,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          Tooltip(
            message: 'Administrateur',
            child: Icon(
              Icons.star_purple500_outlined,
              color: Colors.amber,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget dateSection(int index) {
    return Tooltip(
      message:
          'Ajouté le ${DateFormat.yMMMMd('fr').format(list[index].date)} à ${DateFormat.Hm().format(list[index].date)}',
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          timeago.format(list[index].date, locale: 'fr'),
          style: TextStyle(fontFamily: 'Ubuntu', fontSize: 10),
        ),
      ),
    );
  }

  Container contentSection(int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            //                    <--- top side
            color: backColor,

            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(
            'Nouveau document',
            style: TextStyle(fontFamily: 'Ubuntu'),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton.icon(
            color: primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            icon: Icon(Icons.article, color: Colors.white),
            label: Text('Afficher',
                style: TextStyle(
                  fontFamily: 'Didac',
                  color: Colors.white,
                )),
            onPressed: () {
              dialogDocument(index).show();
            },
          )
        ],
      ),
    );
  }

  Alert dialogDocument(int index) {
    return Alert(
      buttons: [
        DialogButton(
            child: Text('TELECHARGER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            onPressed: () {
              if (pdfurl != null) downloadFile(pdfurl);
              Navigator.pop(context);
            })
      ],
      closeIcon: Icon(Icons.close),
      context: context,
      title: "DOCUMENT",
      content: Container(
        padding: EdgeInsets.only(left: 10),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Document')
                .doc(list[index].documentID)
                .snapshots(),
            builder: (context, snapDoc) {
              Document doc;
              if (snapDoc.connectionState == ConnectionState.waiting)
                return chargement();
              if (snapDoc.connectionState == ConnectionState.none)
                return erreurChargement('Erreur de connexion');
              if (snapDoc.hasData) {
                var d = snapDoc.data;
                doc = Document(
                  annee: d['annee'],
                  titre: d['titre'],
                  module: d['module'],
                  urlPDF: d['url'],
                  semestre: d['semestre'],
                  description: d['description'],
                  filiere: d['filiere'],
                );

                pdfurl = doc.urlPDF;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(
                    color: backColor,
                    thickness: 0.0,
                  ),
                  SelectableText(doc.titre,
                      style: TextStyle(
                        fontFamily: 'Didac',
                        // color: Colors.green,
                      )),
                  Divider(
                    color: backColor,
                    thickness: 1,
                  ),
                  SelectableText(doc.filiere,
                      style: TextStyle(
                        fontFamily: 'Didac',
                      )),
                  Divider(
                    color: backColor,
                    thickness: 1,
                  ),
                  SelectableText(doc.semestre,
                      style: TextStyle(
                        fontFamily: 'Didac',
                        //color: Colors.blue,
                      )),
                  Divider(
                    color: backColor,
                    thickness: 1,
                  ),
                  SelectableText(doc.module,
                      style: TextStyle(
                        fontFamily: 'Didac',
                        //color: Colors.amber,
                      )),
                  Divider(
                    color: backColor,
                    thickness: 1,
                  ),
                  SelectableText(doc.description,
                      style: TextStyle(
                        fontFamily: 'Didac',
                        //color: Colors.purple,
                      )),
                ],
              );
            }),
      ),
    );
  }
}
