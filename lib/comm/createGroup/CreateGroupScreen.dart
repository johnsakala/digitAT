import 'package:digitAT/comm/chat/ChatScreen.dart';
import 'package:digitAT/constants.dart';
import 'package:digitAT/models/model/HomeConversationModel.dart';
import 'package:digitAT/models/model/User.dart';
import 'package:digitAT/services/FirebaseHelper.dart';
import 'package:digitAT/services/helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:digitAT/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  List<User> _selectedUsers = [];
  Future<List<User>> _futureUsers;
  FireStoreUtils _fireStoreUtils = FireStoreUtils();
  TextEditingController _groupNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureUsers = _fireStoreUtils.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_PRIMARY),
        centerTitle: true,
        title: Text(
          'choosePeople',
          style: TextStyle(
              color: isDarkMode(context) ? Colors.grey.shade200 : Colors.white,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          _selectedUsers.isNotEmpty
              ? InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 16,
                        child: Container(
                          height: 200,
                          width: 350,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 40.0,
                                  left: 16,
                                  right: 16,
                                  bottom: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  TextField(
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                    TextCapitalization.sentences,
                                    controller: _groupNameController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: Color(COLOR_ACCENT),
                                              width: 2.0)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              25.0)),
                                      labelText: 'groupName',
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
//                                          spacing: 30,
                                    children: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'cancel',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          )),
                                      FlatButton(
                                          onPressed: () async {
                                            if (_groupNameController
                                                .text.isNotEmpty) {
                                              showProgress(
                                                  context,
                                                  'creatingGroupPleaseWait'
                                                      ,
                                                  false);
                                              HomeConversationModel
                                              groupChatConversationModel =
                                              await _fireStoreUtils
                                                  .createGroupChat(
                                                  _selectedUsers,
                                                  _groupNameController
                                                      .text);
                                              hideProgress();
                                              Navigator.pop(context);
                                              pushReplacement(
                                                  context,
                                                  ChatScreen(
                                                      homeConversationModel:
                                                      groupChatConversationModel));
                                            }
                                          },
                                          child: Text('create',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(
                                                      COLOR_ACCENT)))),
                                    ],
                                  )
                                ],
                              )),
                        ));
                  });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('create', style: TextStyle
                (color: isDarkMode(context)
                  ? Colors.grey.shade200 : Colors.white),)),
            ),
          )
              : Container(
            width: 0,
            height: 0,
          )
        ],
        iconTheme: IconThemeData(color: isDarkMode(context)
            ? Colors.grey.shade200 : Colors.white),
      ),
      body: FutureBuilder<List<User>>(
          future: _futureUsers,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data.isEmpty &&
                snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Text('noUsersFound'),
              );
            } else {
              snapshot.data.remove(MyAppState.currentUser);
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    User user = snapshot.data[index];
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                              onTap: () {
                                if (!user.selected) {
                                  user.selected = true;
                                  _selectedUsers.add(user);
                                } else {
                                  user.selected = false;
                                  _selectedUsers.remove(user);
                                }
                                setState(() {});
                              },
                              leading: displayCircleImage(
                                  user.profilePictureURL, 55, false),
                              title: Text(
                                '${user.fullName()}',
                                style: TextStyle(
                                    color: isDarkMode(context)
                                        ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              trailing: user.selected
                                  ? Icon(
                                Icons.check_circle,
                                color: isDarkMode(context)
                                    ? Colors.white : Colors.black,
                              )
                                  : Container(
                                width: 0,
                                height: 0,
                              )),
                        ),
                        Divider()
                      ],
                    );
                  });
            }
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _groupNameController.dispose();
  }
}
