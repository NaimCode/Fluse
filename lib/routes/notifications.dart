import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:hover_effect/hover_effect.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:website_university/routes/home.dart';
import 'package:website_university/services/variableStatic.dart';
import 'package:intl/intl.dart';

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
  Utilisateur utilisateur;
  var filiere;
  var semestre;
  var future;
  @override
  void initState() {
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Utilisateur')
            .doc(widget.user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting)
          //   return chargement();
          if (snapshot.hasData) {
            var user = snapshot.data;

            filiere = user['filiere'];
            semestre = user['semestre'];
            list.clear();
            listNotifications.forEach((element) {
              if (element.filiere == filiere && element.semestre == semestre)
                list.add(element);
            });
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: (Get.width <= 810) ? Colors.white : backColor,
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
              elevation: (Get.width >= 810) ? 0.0 : 10.0,
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
                            'Pour accéder aux notifications, veuillez indiquer votre filière ainsi que le semestre',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, color: primary.withOpacity(0.7)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton.icon(
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Profile',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                            color: primary,
                          )
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
          'Ajouté le ${DateFormat.yMd().format(list[index].date)} à ${DateFormat.Hm().format(list[index].date)}',
      child: Container(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat.yMd().format(list[index].date),
              style: TextStyle(fontFamily: 'Ubuntu', fontSize: 10),
            ),
            Text(
              DateFormat.Hm().format(list[index].date),
              style: TextStyle(fontFamily: 'Ubuntu', fontSize: 10),
            ),
          ],
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
            filiere,
            style: TextStyle(fontFamily: 'Ubuntu'),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: primary,
            onPressed: () {},
            icon: Icon(
              Icons.article,
              color: Colors.white,
            ),
            label: Text(
              'Afficher',
              style: TextStyle(
                fontFamily: 'Didac',
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
