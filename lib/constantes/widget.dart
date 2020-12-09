import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/services/authentification.dart';
import 'package:website_university/services/firestorage.dart';
import 'package:website_university/services/variableStatic.dart';
import 'package:timeago/timeago.dart' as timeago;

Container chargement() {
  return Container(
    color: Colors.white,
    child: SpinKitThreeBounce(
      color: primary,
      size: 30,
    ),
  );
}

Widget erreurChargement(String erreur) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      child: Center(
        child: Text(
          erreur,
          style: TextStyle(fontSize: 16, color: Colors.redAccent),
        ),
      ),
    ),
  );
}

final snackBarEtablissment = SnackBar(
    content: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'L\'établissement été ajouté',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    ),
    Icon(Icons.verified, color: Colors.white)
  ],
));
final snackBarEtablissementEchec = SnackBar(
    content: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Erreur, verifiez que vous avez saisi tous les champs!',
      style: TextStyle(fontSize: 20.0, color: Colors.red),
    ),
    Icon(
      Icons.error,
      color: Colors.red,
    )
  ],
));

final snackBarDocument = SnackBar(
    content: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Le document été ajouté',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    ),
    Icon(Icons.verified, color: Colors.white)
  ],
));
final snackBarDocumentEchec = SnackBar(
    content: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Erreur, verifiez que vous avez saisi tous les champs!',
      style: TextStyle(fontSize: 20.0, color: Colors.red),
    ),
    Icon(
      Icons.error,
      color: Colors.red,
    )
  ],
));

////Discussion
class UserSection extends StatelessWidget {
  const UserSection(
      {Key key,
      @required this.listMessage,
      @required this.isUser,
      @required this.index})
      : super(key: key);

  final List<Message> listMessage;
  final bool isUser;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Utilisateur')
            .doc(listMessage[index].userID)
            .get(),
        builder: (context, snapUser) {
          var user;

          if (snapUser.hasData) {
            user = snapUser.data;

            return InkWell(
              onTap: () {
                var filiere = user['filiere'] ?? 'filière indéfinie';
                var semestre = user['semestre'] ?? 'semestre indéfini';
                var isAdmin = user['admin'];
                showDialog(
                    context: context,
                    builder: (_) => NetworkGiffyDialog(
                          image: Image.network(
                            user['image'],
                            fit: BoxFit.cover,
                          ),
                          title: Text(user['nom'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 3)),
                          description: Text(
                            isAdmin ? 'Administrateur' : '$filiere | $semestre',
                            style: TextStyle(
                                color: isAdmin ? Colors.amber : primary,
                                fontSize: 18,
                                letterSpacing: 3),
                            textAlign: TextAlign.center,
                          ),
                          entryAnimation: EntryAnimation.BOTTOM,
                          onlyCancelButton: true,
                          buttonCancelColor: Colors.white,
                          buttonCancelText: Text('Retour',
                              style: TextStyle(
                                  color: primary,
                                  fontFamily: 'Tomorrow',
                                  fontSize: 20,
                                  letterSpacing: 3)),
                        ));
              },
              child: Container(
                child: isUser
                    ? Container(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (user['admin'] == true)
                              Tooltip(
                                message: 'Administrateur',
                                child: Icon(
                                  Icons.star_purple500_outlined,
                                  color: Colors.amber,
                                  size: 15,
                                ),
                              ),
                            Text(
                              user['nom'],
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user['image'] ?? profile),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user['image'] ?? profile),
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            user['nom'],
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          if (user['admin'] == true)
                            Tooltip(
                              message: 'Administrateur',
                              child: Icon(
                                Icons.star_purple500_outlined,
                                color: Colors.amber,
                                size: 15,
                              ),
                            )
                        ],
                      ),
              ),
            );
          } else
            return Container();
        },
      ),
    );
  }
}

class MessageSection extends StatelessWidget {
  const MessageSection(
      {Key key,
      @required this.isUser,
      @required this.listMessage,
      @required this.index,
      @required this.channel})
      : super(key: key);

  final bool isUser;
  final List<Message> listMessage;
  final int index;
  final String channel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isUser
          ? EdgeInsets.only(left: (Get.width <= 810) ? 100 : 30)
          : EdgeInsets.only(right: (Get.width <= 810) ? 100 : 30),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: !isUser ? Colors.white : primary,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                  topLeft:
                      !isUser ? Radius.circular(0.0) : Radius.circular(25.0),
                  topRight:
                      !isUser ? Radius.circular(25.0) : Radius.circular(0.0),
                )),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 13),
            child: isUser
                ? InkWell(
                    onLongPress: () {
                      Get.defaultDialog(
                          title: 'Suppression',
                          middleText: 'Voulez-vous supprimer ce message?',
                          actions: [
                            FlatButton(
                              onPressed: () async {
                                Get.back();
                              },
                              child: Text(
                                'Annuler',
                                style: TextStyle(
                                    color: primary, fontFamily: 'Didac'),
                              ),
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            FlatButton(
                              onPressed: () async {
                                var delete = FirebaseFirestore.instance
                                    .collection('Discussion')
                                    .doc(channel)
                                    .collection('Message')
                                    .where('date',
                                        isEqualTo: listMessage[index].date);
                                delete.get().then((value) {
                                  value.docs.forEach((element) {
                                    element.reference.delete();
                                  });
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Supprimer',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Didac'),
                              ),
                              color: Colors.red,
                            )
                          ]);
                    },
                    child: Text(
                      listMessage[index].message,
                      style: TextStyle(color: isUser ? Colors.white : primary),
                    ),
                  )
                : SelectableText(
                    listMessage[index].message,
                    style: TextStyle(color: isUser ? Colors.white : primary),
                  ),
          ),
          (index == 0)
              ? Container(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text(
                      timeago.format(listMessage[index].date.toDate(),
                          locale: 'fr'),
                      style: TextStyle(fontFamily: 'Ubuntu', fontSize: 10),
                    ),
                  ))
              : (listMessage[index].userID == listMessage[index - 1].userID)
                  ? Container()
                  : Container(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        child: Text(
                          timeago.format(listMessage[index].date.toDate(),
                              locale: 'fr'),
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 10,
                          ),
                        ),
                      ))
        ],
      ),
    );
  }
}
