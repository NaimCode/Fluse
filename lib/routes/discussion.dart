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
import 'package:website_university/services/service.dart';
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
  String channel = '';
  List<Message> listMessage = [];

  bool errorSending = false;
  getShare() async {
    String channell = await sharedChannelGet();
    print(channell);
    setState(() {
      channel = channell;
    });
  }

  @override
  void initState() {
    getShare();
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    //listMessage = listMessages;
    super.initState();
  }

  bool sending = false;
  TextEditingController messageText = TextEditingController();
//
  sendMessage(String channelF, String utilisateurID) async {
    if (messageText.text.isNotEmpty) {
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
                    // height: Get.width - 500,
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
                            return Scrollbar(
                              child: ListView.builder(
                                reverse: true,
                                itemCount: listMessage.length,
                                itemBuilder: (context, index) {
                                  bool isUser = (listMessage[index].userID ==
                                      widget.user.uid);

                                  return ListTile(
                                    subtitle: MessageSection(
                                        isUser: isUser,
                                        listMessage: listMessage,
                                        index: index,
                                        channel: channel),
                                    title: (index == listMessage.length - 1)
                                        ? UserSection(
                                            listMessage: listMessage,
                                            isUser: isUser,
                                            index: index)
                                        : (listMessage[index].userID ==
                                                listMessage[index + 1].userID)
                                            ? Container()
                                            : UserSection(
                                                listMessage: listMessage,
                                                isUser: isUser,
                                                index: index),
                                  );
                                },
                              ),
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
            sharedChannelSet(channel);
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
}
