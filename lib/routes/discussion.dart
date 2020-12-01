import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/services/variableStatic.dart';

// ignore: must_be_immutable
class Discussion extends StatefulWidget {
  bool isMobile;
  Discussion(this.isMobile);
  @override
  _DiscussionState createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  String channel = 'Global';

  List<Message> listMessage;
  Usere user = Usere(nom: 'Naim Abdelkerim', admin: true, image: avatar);
  @override
  void initState() {
    listMessage = listMessages;
    super.initState();
  }

  TextEditingController messageText = TextEditingController();
//
  List<String> listChannel = [
    'Global',
    'SMAI',
    'STU',
    'SMPC',
    'Droit',
    'Ali',
    'Economie'
  ];
//Animation
  double heightChannel = 0.0;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 810 && widget.isMobile == true) {
      Navigator.pop(context);
    }
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        elevation: (Get.width >= 810) ? 0.0 : 10.0,
        backgroundColor: (Get.width <= 810) ? Colors.white : backColor,
        //check
        title: Tooltip(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                channelFunction(),
                Expanded(
                  child: Container(
                    // height: Get.width - 500,
                    child: ListView.builder(
                      reverse: true,
                      itemCount: listMessage.length,
                      itemBuilder: (context, index) {
                        bool isUser = (listMessage[index].user.nom == user.nom);

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
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                    ),
                  ),
                ),
                inputMessage()
              ],
            ),
          )),
    );
  }

  FlatButton channelFunction() {
    return FlatButton(
      onPressed: () {
        double check = heightChannel;
        setState(() {
          (check == 80) ? heightChannel = 0.0 : heightChannel = 80.0;
        });
      },
      child: Card(
        elevation: 0.0,
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(channel,
                      style: TextStyle(
                          fontFamily: 'Ubuntu', fontSize: 18, color: primary)),
                  Icon(Icons.expand_more),
                ],
              ),
            ),
            AnimatedContainer(
              //width: double.infinity / 3,
              height: heightChannel,
              duration: Duration(seconds: 1),
              curve: Curves.linearToEaseOut,
              child: Container(
                child: ListView.builder(
                  itemCount: listChannel.length,
                  itemBuilder: (context, index) {
                    if (listChannel[index] != channel)
                      return InkWell(
                        onTap: () {
                          Get.snackbar('Changement de serveur',
                              'Vous êtes actuellement sur le serveur de discussion \'${listChannel[index]}\'');
                          setState(() {
                            heightChannel = 0.0;
                            channel = listChannel[index];
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              listChannel[index],
                            ),
                            Text(''),
                          ],
                        ),
                      );
                    else
                      return Container();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding inputMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Card(
        elevation: 8.0,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: messageText,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
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
            IconButton(
              alignment: Alignment.center,
              tooltip: 'Envoyer',
              icon: Icon(Icons.send),
              onPressed: () {
                Message m = Message(
                  user: user,
                  message: messageText.text,
                  date: '06h:09 | 12-5-22',
                );
                setState(() {
                  listMessage.add(m);
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Container dateSection(int index, bool isUser) {
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        listMessage[index].date,
        style: TextStyle(fontFamily: 'Ubuntu', fontSize: 10),
      ),
    );
  }

  Container userSection(int index) {
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
                  backgroundImage: NetworkImage(listMessage[index].user.image),
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                listMessage[index].user.nom,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ],
          ),
          listMessage[index].user.admin
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
