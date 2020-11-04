import 'dart:io';
import 'dart:ui';

import 'package:digitAT/comm/chat/ChatScreen.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/constants.dart';
import 'package:digitAT/main.dart';
import 'package:digitAT/models/model/ConversationModel.dart';
import 'package:digitAT/models/model/HomeConversationModel.dart';
import 'package:digitAT/models/model/User.dart' ;
import 'package:digitAT/services/FirebaseHelper.dart';
import 'package:digitAT/services/helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


List<User> _friendsSearchResult = [];
List<HomeConversationModel> _conversationsSearchResult = [];
List<User> _friends = [];
List<HomeConversationModel> _conversations = [];

class ConversationsScreen extends StatefulWidget {
  final User user;

  const ConversationsScreen({Key key, @required this.user}) : super(key: key);

  @override
  State createState() {
    return _ConversationsState(user);
  }
}

class _ConversationsState extends State<ConversationsScreen> {
   User user;
   
   
   final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  final fireStoreUtils = FireStoreUtils();
  Future<List<User>> _friendsFuture;
  Stream<List<HomeConversationModel>> _conversationsStream;
  TextEditingController controller = new TextEditingController();

  _ConversationsState(this.user);

  @override
  void initState() {
    super.initState();
 
    fireStoreUtils.getBlocks().listen((shouldRefresh) {
      if (shouldRefresh) {
        setState(() {});
      }
    });
    _friendsFuture = fireStoreUtils.getFriends();
    _conversationsStream = fireStoreUtils.getConversations(user.userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldstate,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          onPressed: (){
            //TODO Paramters should be changed once user starts coming from the Core system
            //Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back,color: Theme.of(context).accentColor),
        ),
       /* actions:<Widget>[IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.contact_phone),
          onPressed: (){
             Navigator.of(context).pop();
            
          },
        ),],*/
        title: Text(
          "Chats",
          style:TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ), 
      ),
          body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
              child: TextField(
                onChanged: _onSearch,
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    fillColor:
                        isDarkMode(context) ? Colors.grey[700] : Colors.grey[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(360),
                        ),
                        borderSide: BorderSide(style: BorderStyle.none)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(360),
                        ),
                        borderSide: BorderSide(style: BorderStyle.none)),
                    hintText: 'Search Contact',
                    suffixIcon: IconButton(
                      focusColor:
                          isDarkMode(context) ? Colors.white : Colors.black,
                      iconSize: 20,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.clear();
                        _onSearch('');
                        setState(() {});
                      },
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20,
                    )),
              ),
            ),
            SizedBox(
              height: 100,
              child: FutureBuilder<List<User>>(
                future: _friendsFuture,
                initialData: [],
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(COLOR_ACCENT)),
                        ),
                      ),
                    );
                  } else if (!snap.hasData || snap.data.isEmpty) {
                    return Center(
                      child: Text(
                        'No Contact Found',
                        style: TextStyle(fontSize: 18),
                      )
                    );
                  } else {
                    return _friendsSearchResult.isNotEmpty ||
                        controller.text.isNotEmpty
                        ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _friendsSearchResult.length,
                      // ignore: missing_return
                      itemBuilder: (BuildContext context, int index) {
                        User friend = _friendsSearchResult[index];
                        return fireStoreUtils
                            .validateIfUserBlocked(friend.userID)
                            ? Container(
                          width: 0,
                          height: 0,
                        )
                            : Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 4, right: 4),
                          child: InkWell(
                            onTap: () async {
                              String channelID;
                              if (friend.userID
                                  .compareTo(user.userID) <
                                  0) {
                                channelID =
                                    friend.userID + user.userID;
                              } else {
                                channelID =
                                    user.userID + friend.userID;
                              }
                              ConversationModel conversationModel =
                              await fireStoreUtils
                                  .getChannelByIdOrNull(
                                  channelID);
                              push(
                                  context,
                                  ChatScreen(
                                      homeConversationModel:
                                      HomeConversationModel(
                                          isGroupChat: false,
                                          members: [friend],
                                          conversationModel:
                                          conversationModel)));
                            },
                            child: Column(
                              children: <Widget>[
                                displayCircleImage(
                                    friend.profilePictureURL,
                                    50,
                                    false),
                                Expanded(
                                  child: Container(
                                    width: 75,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0,
                                          left: 8,
                                          right: 8),
                                      child: Text(
                                        '${friend.firstName}',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snap.hasData ? snap.data.length : 0,
                      // ignore: missing_return
                      itemBuilder: (BuildContext context, int index) {
                        if (snap.hasData) {
                          _friends = snap.data;
                          User friend = snap.data[index];
                          return fireStoreUtils
                              .validateIfUserBlocked(friend.userID)
                              ? Container(
                            width: 0,
                            height: 0,
                          )
                              : Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 4, right: 4),
                            child: InkWell(
                              onTap: () async {
                                String channelID;
                                if (friend.userID
                                    .compareTo(user.userID) <
                                    0) {
                                  channelID =
                                      friend.userID + user.userID;
                                } else {
                                  channelID =
                                      user.userID + friend.userID;
                                }
                                ConversationModel conversationModel =
                                await fireStoreUtils
                                    .getChannelByIdOrNull(
                                    channelID);

                                push(
                                    context,
                                    ChatScreen(
                                        homeConversationModel:
                                        HomeConversationModel(
                                            isGroupChat: false,
                                            members: [friend],
                                            conversationModel:
                                            conversationModel)));
                              },
                              child: Column(
                                children: <Widget>[
                                  displayCircleImage(
                                      friend.profilePictureURL,
                                      50,
                                      false),
                                  Expanded(
                                    child: Container(
                                      width: 75,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            top: 8.0,
                                            left: 8,
                                            right: 8),
                                        child: Text(
                                          '${friend.firstName}',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
            StreamBuilder<List<HomeConversationModel>>(
              stream: _conversationsStream,
              initialData: [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Color(COLOR_ACCENT)),
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Center(
                    child: Text(
                      'noConversationsFound',
                      style: TextStyle(fontSize: 18),
                    )
                  );
                } else {
                  return _conversationsSearchResult.isNotEmpty ||
                      controller.text.isNotEmpty
                      ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _conversationsSearchResult.length,
                      itemBuilder: (context, index) {
                        final homeConversationModel =
                        _conversationsSearchResult[index];
                        if (homeConversationModel.isGroupChat) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, top: 8, bottom: 8),
                            child:
                            _buildConversationRow(homeConversationModel),
                          );
                        } else {
                          return fireStoreUtils.validateIfUserBlocked(
                              homeConversationModel.members.first.userID)
                              ? Container(
                            width: 0,
                            height: 0,
                          )
                              : Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16,
                                top: 8,
                                bottom: 8),
                            child: _buildConversationRow(
                                homeConversationModel),
                          );
                        }
                      })
                      : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        _conversations = snapshot.data;
                        final homeConversationModel = snapshot.data[index];
                        if (homeConversationModel.isGroupChat) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, top: 8, bottom: 8),
                            child:
                            _buildConversationRow(homeConversationModel),
                          );
                        } else {
                          return fireStoreUtils.validateIfUserBlocked(
                              homeConversationModel.members.first.userID)
                              ? Container(
                            width: 0,
                            height: 0,
                          )
                              : Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16,
                                top: 8,
                                bottom: 8),
                            child: _buildConversationRow(
                                homeConversationModel),
                          );
                        }
                      });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildConversationRow(HomeConversationModel homeConversationModel) {
    String user1Image = '';
    String user2Image = '';
    if (homeConversationModel.members.length >= 2) {
      user1Image = homeConversationModel.members.first.profilePictureURL;
      user2Image = homeConversationModel.members
          .elementAt(1)
          .profilePictureURL;
    }
    return homeConversationModel.isGroupChat
        ? Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 12.8),
      child: InkWell(
        onTap: () {
          push(context,
              ChatScreen(homeConversationModel: homeConversationModel));
        },
        child: Row(
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                displayCircleImage(user1Image, 44, false),
                Positioned.directional(
                    textDirection: Directionality.of(context),
                    start: -16,
                    bottom: -12.8,
                    child: displayCircleImage(user2Image, 44, true))
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsetsDirectional.only(top: 8, end: 8, start: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${homeConversationModel.conversationModel.name}',
                      style: TextStyle(
                        fontSize: 17,
                        color: isDarkMode(context)
                            ? Colors.white
                            : Colors.black,
                        fontFamily: Platform.isIOS ? 'sanFran' : 'Roboto',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${homeConversationModel.conversationModel
                            .lastMessage} • ${formatTimestamp(
                            homeConversationModel.conversationModel
                                .lastMessageDate.seconds)}',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14, color: Color(0xffACACAC)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    )
        : InkWell(
      onTap: () {
        push(context,
            ChatScreen(homeConversationModel: homeConversationModel));
      },
      child: Row(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              displayCircleImage(
                  homeConversationModel.members.first.profilePictureURL,
                  60,
                  false),
              Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 2.4,
                  bottom: 2.4,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: homeConversationModel.members.first.active
                            ? Colors.green
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: isDarkMode(context)
                                ? Color(0xFF303030)
                                : Colors.white,
                            width: 1.6)),
                  ))
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 8, end: 8,
                  start: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${homeConversationModel.members.first.fullName()}',
                    style: TextStyle(
                        fontSize: 17,
                        color: isDarkMode(context)
                            ? Colors.white
                            : Colors.black,
                        fontFamily:
                        Platform.isIOS ? 'sanFran' : 'Roboto'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${homeConversationModel.conversationModel
                          .lastMessage} • ${formatTimestamp(
                          homeConversationModel.conversationModel
                              .lastMessageDate.seconds)}',
                      maxLines: 1,
                      style: TextStyle(fontSize: 14, color: Color(0xffACACAC)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _onSearch(String text) {
    _friendsSearchResult.clear();
    _conversationsSearchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _friends.forEach((friend) {
      if (friend.fullName().toLowerCase().contains(text.toLowerCase())) {
        _friendsSearchResult.add(friend);
      }
    });

    _conversations.forEach((conversation) {
      if (conversation.isGroupChat) {
        if (conversation.conversationModel.name
            .toLowerCase()
            .contains(text.toLowerCase())) {
          _conversationsSearchResult.add(conversation);
        }
      } else {
        if (conversation.members.first
            .fullName()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          _conversationsSearchResult.add(conversation);
        }
      }
    });
    setState(() {});
  }
}
