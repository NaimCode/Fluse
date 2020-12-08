import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:smart_select/smart_select.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:website_university/services/variableStatic.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class Discussion extends StatefulWidget {
  bool isMobile;
  Utilisateur user;

  Discussion(this.isMobile, this.user);
  @override
  _DiscussionState createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  final firestoreinstance = FirebaseFirestore.instance;
  String channel = 'Global';
  List<Message> listMessage = [];

  bool errorSending = false;
  @override
  void initState() {
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    //listMessage = listMessages;
    super.initState();
  }

  bool sending = false;
  TextEditingController messageText = TextEditingController();
//
  sendMessage(String channelF, String utilisateurID) async {
    if (messageText.text.isNotEmpty) {
      setState(() {
        sending = true;
      });
      var message = {
        'userID': utilisateurID,
        'message': messageText.text,
        'date': Timestamp.now(),
      };

      try {
        await firestoreinstance
            .collection('Discussion')
            .doc(channelF)
            .collection('Message')
            .add(message);
        setState(() {
          messageText.clear();
        });
      } on Exception catch (e) {
        setState(() {
          errorSending = true;
        });
      }
      setState(() {
        sending = false;
      });
    }
  }

//Animation
  double heightChannel = 0.0;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 810 && widget.isMobile == true) {
      Navigator.pop(context);
    }
    initializeDateFormatting();
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        elevation: (Get.width >= 810) ? 0.0 : 5.0,
        backgroundColor: (Get.width <= 810) ? Colors.white : backColor,
        //check
        title: (Get.width <= 810)
            ? channelFunction()
            : Tooltip(
                message: 'Discussions',
                child: Icon(
                  Icons.comment,
                  size: 35,
                  color: primary,
                ),
              ),
        centerTitle: true,

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
      body: Container(
          color: backColor,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (Get.width >= 810) channelFunction(),
                Expanded(
                  child: Container(
                    height: Get.width - 500,
                    child: StreamBuilder(
                        stream: firestoreinstance
                            .collection('Discussion')
                            .doc(channel)
                            .collection('Message')
                            .orderBy('date', descending: true)
                            .snapshots(),
                        builder: (context, snapMess) {
                          // if (snapMess.connectionState ==
                          //     ConnectionState.waiting)
                          //   return SpinKitThreeBounce(
                          //     color: primary,
                          //     size: 20,
                          //   );
                          if (snapMess.connectionState == ConnectionState.none)
                            return Center(
                              child: Text('Pas de connexion'),
                            );
                          if (snapMess.hasError) print('erreur');
                          if (!snapMess.hasData) {
                            print(snapMess.data);
                            print('pas de message');
                            return Center(
                              child: Text('Aucun message'),
                            );
                          } else {
                            print('debut message');
                            listMessage.clear();
                            snapMess.data.docs.forEach((element) {
                              listMessage.add(Message(
                                  date: element.data()['date'],
                                  userID: element.data()['userID'],
                                  message: element.data()['message']));
                            });
                            return ListView.builder(
                              reverse: true,
                              itemCount: listMessage.length,
                              itemBuilder: (context, index) {
                                bool isUser = (listMessage[index].userID ==
                                    widget.user.uid);

                                return Container(
                                  margin: EdgeInsets.only(
                                      left: isUser
                                          ? widget.isMobile
                                              ? 100.0
                                              : 30
                                          : 0.0,
                                      right: !isUser
                                          ? widget.isMobile
                                              ? 100.0
                                              : 30
                                          : 0.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: !isUser
                                            ? Radius.circular(0.0)
                                            : Radius.circular(30),
                                        bottomRight: !isUser
                                            ? Radius.circular(30.0)
                                            : Radius.circular(0.0),
                                      ),
                                    ),
                                    elevation: 3.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 0.0,
                                      ),
                                      child: Column(
                                        children: [
                                          userSection(index),
                                          contentSection(index),
                                          dateSection(index, isUser)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }),
                  ),
                ),
                inputMessage()
              ],
            ),
          )),
    );
  }

  Widget channelFunction() {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      child: SmartSelect<String>.single(
          modalType: S2ModalType.bottomSheet,
          placeholder: '',
          title: 'Serveur de discussion',
          value: channel,
          choiceItems: optionsChannel,
          onChange: (state) {
            setState(() => channel = state.value);
            print('$channel  a ete selectionne');
          }),
    );
  }

  Widget inputMessage() {
    return Card(
      elevation: 8.0,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                controller: messageText,
                keyboardType: TextInputType.multiline,
                //maxLines: 3,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 16, top: 11, right: 15),
                    hintText: 'Message...'),
              ),
            ),
          ),
          sending
              ? chargement()
              : IconButton(
                  alignment: Alignment.center,
                  tooltip: 'Envoyer',
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(channel, widget.user.uid);
                  })
        ],
      ),
    );
  }

  Widget dateSection(int index, bool isUser) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Tooltip(
        message:
            'Envoyé le ${DateFormat.yMMMMd('fr').format(listMessage[index].date.toDate())} à ${DateFormat.Hm().format(listMessage[index].date.toDate())}',
        child: Container(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            timeago.format(listMessage[index].date.toDate(), locale: 'fr'),
            style: TextStyle(fontFamily: 'Ubuntu', fontSize: 10),
          ),
        ),
      ),
    );
  }

  Container userSection(int index) {
    return Container(
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Utilisateur')
              .doc(listMessage[index].userID)
              .get(),
          builder: (context, snapUser) {
            var user;

            if (snapUser.hasData) {
              user = snapUser.data;
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
                      ],
                    ),
                    user['admin']
                        ? Tooltip(
                            message: 'Administrateur',
                            child: Icon(
                              Icons.star_purple500_outlined,
                              color: Colors.amber,
                              size: 20,
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.more_horiz),
                            onPressed: () {},
                          )
                  ],
                ),
              );
            } else
              return Container();
          }),
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
            listMessage[index].message,
            style: TextStyle(fontFamily: 'Ubuntu'),
          ),
        ],
      ),
    );
  }
}
