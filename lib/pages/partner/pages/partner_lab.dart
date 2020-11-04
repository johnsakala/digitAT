import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:digitAT/api/url.dart';
import 'package:digitAT/comm/chat/ChatScreen.dart';
import 'package:digitAT/constants.dart';
import 'package:digitAT/models/model/ConversationModel.dart';
import 'package:digitAT/models/model/HomeConversationModel.dart';
import 'package:digitAT/models/model/User.dart';
import 'package:digitAT/models/partner/models/account_card.dart';
import 'package:digitAT/pages/partner/pages/account.card.dart';
import 'package:digitAT/pages/partner/pages/appointment.card.dart';
import 'package:digitAT/pages/partner/pages/chart-painter.dart';
import 'package:digitAT/pages/partner/pages/partner_pharmacy.dart';
import 'package:digitAT/pages/partner/pages/partner_scan.dart';
import 'package:digitAT/services/FirebaseHelper.dart';
import 'package:digitAT/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Color(0xff0074ff);
PatientCard patientCard =
    PatientCard('20-Oct-2020', 'Lewis Moyo', false, 'harare', "1");
PatientCard patientCard1 =
    PatientCard('21-Sep-2020', ' Tinotenda Ruzane', false, 'haare', "2");
PatientCard patientCard2 =
    PatientCard('10-Jan-2021', 'Blessing Chamu', false, 'harare', "3");

class PartnerLab extends StatefulWidget {
  final User user;
  const PartnerLab({Key key, this.user}) : super(key: key);

  @override
  PartnerLabState createState() => PartnerLabState();
}

class PartnerLabState extends State<PartnerLab> {
  User user;
  List<User> _friendsSearchResult = [];
  List<HomeConversationModel> _conversationsSearchResult = [];
  List<User> _friends = [];
  List<HomeConversationModel> _conversations = [];
  final fireStoreUtils = FireStoreUtils();
  Future<List<User>> _friendsFuture;
  Stream<List<HomeConversationModel>> _conversationsStream;
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sp.setString('user', jsonEncode(widget.user.toJson()));
    });
    setState(() {
      user = widget.user;
    });
    /*SharedPreferences.getInstance().then((SharedPreferences sp) {
     setState(() {
       user=User.fromJson(jsonDecode(sp.getString('user')));
       
     });
   });*/

    fireStoreUtils.getBlocks().listen((shouldRefresh) {
      if (shouldRefresh) {
        setState(() {});
      }
    });
    _friendsFuture = fireStoreUtils.getFriends();
    _conversationsStream = fireStoreUtils.getConversations(user.userID);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(context),
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('digitAT',
          style: TextStyle(
              fontSize: 26,
              color: Theme.of(context).primaryColor,
              fontFamily: 'Bauhaus')),
      backgroundColor: Theme.of(context).accentColor,
      elevation: 0,
      actions: <Widget>[
        Icon(
          Icons.notifications,
          color: Theme.of(context).primaryColor,
        ),
        Container(
          width: 50,
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/asset-1.png"),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text("Chat",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22.0,
                        fontFamily: 'Bauhaus',
                      ))),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
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
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(COLOR_ACCENT)),
                        ),
                      ),
                    );
                  } else if (!snap.hasData || snap.data.isEmpty) {
                    return Center(
                        child: Text(
                      'No Contact Found',
                      style: TextStyle(fontSize: 18),
                    ));
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
                                            ConversationModel
                                                conversationModel =
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
                                                      textAlign:
                                                          TextAlign.center,
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
                  ));
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
                                child: _buildConversationRow(
                                    homeConversationModel),
                              );
                            } else {
                              return fireStoreUtils.validateIfUserBlocked(
                                      homeConversationModel
                                          .members.first.userID)
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
                                child: _buildConversationRow(
                                    homeConversationModel),
                              );
                            } else {
                              return fireStoreUtils.validateIfUserBlocked(
                                      homeConversationModel
                                          .members.first.userID)
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

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 30,
              icon: Image.asset('images/nurse-grey.png'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/home', arguments: widget.user);
              },
              color: Colors.grey,
            ),
            IconButton(
              iconSize: 30,
              icon: Image.asset('images/pill-grey.png'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/partnerpharmacy', arguments: widget.user);
              },
              color: Colors.grey,
            ),
            IconButton(
              iconSize: 30,
              icon: Image.asset('images/TheLab.png'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/partnerlab', arguments: widget.user);
              },
              color: Colors.grey,
            ),
            IconButton(
              iconSize: 30,
              icon: Image.asset('images/microscope-grey.png'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/partnerscan', arguments: widget.user);
              },
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Monthly",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: CustomPaint(
                      foregroundPainter: ChartPainter(),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: _buildChartLegend(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView(
                children: <Widget>[
                  Text(
                    "Presciptions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildCard(context, child: AppointmentCard()),
                  SizedBox(height: 20),
                  Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200.0,
                    child: FutureBuilder<List<Widget>>(
                        future: _fetchOrders(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Widget> data = snapshot.data;
                            return _doctorsListView(data);
                          } else if (snapshot.hasError) {
                            return Text(
                                "Please check your internet connection! ${snapshot.error}");
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(context, {Widget child}) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }

  List<Widget> _buildChartLegend(BuildContext context) {
    List<Widget> legend = [];
    int monthIndex = 0;
    for (double i = 1; i < 16.0; i++) {
      if (i % 2 != 0) {
        legend.add(
          Positioned(
            left: (i * 23) - 10,
            top: 10,
            child: Container(
              height: 30,
              child: Text(
                getMonth(monthIndex++),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }
    }

    return legend.toList();
  }

  String getMonth(int index) {
    final months = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sept'];
    return months[index];
  }

  ListView _doctorsListView(data) {
    return ListView(
      children: data,
    );
  }

  Future<List<Widget>> _fetchOrders() async {
    List<Widget> _applist = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int resposibleId = preferences.getInt('id');
    print(resposibleId);
//  showAlertDialog(context);
    final http.Response response = await http
        .get(
          '${webhook}tasks.task.list?filter[RESPONSIBLE_ID]=$resposibleId&filter[TITLE]=Test Booking&select[]=UF_AUTO_831530867848&select[]=UF_AUTO_206323634806',
        )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    List<dynamic> result = [];

    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
          result = responseBody["result"]["tasks"];
          for (int i = 0; i < result.length; i++) {
            final http.Response aids = await http
                .get(
                  '${webhook}crm.lead.get?ID=${result[i]['ufAuto831530867848']}',
                )
                .catchError((error) => print(error));
            Map<String, dynamic> aidsBody = jsonDecode(aids.body);
            if (aids.statusCode == 200) {
              List<Widget> _appList = [];
              try {
                if (aidsBody["result"] != null) {
                  print("*************************" +
                      aidsBody["result"].toString());

                  PatientCard patientCard = PatientCard(
                      result[i]['ufAuto206323634806'],
                      aidsBody["result"]['NAME'] +
                          aidsBody["result"]['LAST_NAME'],
                      false,
                      aidsBody["result"]["ADDRESS_CITY"],
                      aidsBody["result"]["ID"]);
                  _appList.add(_buildCard(
                    context,
                    child: AccountCard(
                      patient: patientCard,
                    ),
                  ));
                  _applist.addAll(_appList);
                } else {
                  print('-----------------' + response.body);
                }
              } catch (error) {
                print('-----------------' + error);
              }
            } else {
              print("Please check your internet connection ");
              Fluttertoast.showToast(
                  msg: "Please check your internet connection ",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 4,
                  fontSize: ScreenUtil(allowFontScaling: false).setSp(16));
            }
          }
        } else {
          print('-----------------' + response.statusCode.toString());
        }
      } catch (error) {
        print('-----------------' + error);
      }
    } else {
      print("Please check your internet connection ");
      Fluttertoast.showToast(
          msg: "Please check your internet connection ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 4,
          fontSize: ScreenUtil(allowFontScaling: false).setSp(16));
    }
    print('response //////////////////////////////' + _applist.toString());
    return _applist;
  }

  Widget _buildConversationRow(HomeConversationModel homeConversationModel) {
    String user1Image = '';
    String user2Image = '';
    if (homeConversationModel.members.length >= 2) {
      user1Image = homeConversationModel.members.first.profilePictureURL;
      user2Image = homeConversationModel.members.elementAt(1).profilePictureURL;
    }
    return homeConversationModel.isGroupChat
        ? Padding(
            padding:
                const EdgeInsetsDirectional.only(start: 16.0, bottom: 12.8),
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
                      padding: const EdgeInsetsDirectional.only(
                          top: 8, end: 8, start: 12),
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
                              '${homeConversationModel.conversationModel.lastMessage} • ${formatTimestamp(homeConversationModel.conversationModel.lastMessageDate.seconds)}',
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
                    padding: const EdgeInsetsDirectional.only(
                        top: 8, end: 8, start: 12),
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
                            '${homeConversationModel.conversationModel.lastMessage} • ${formatTimestamp(homeConversationModel.conversationModel.lastMessageDate.seconds)}',
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
          );
  }
}
