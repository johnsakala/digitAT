import 'dart:convert';

import 'package:digitAT/comm/conversations/ConversationsScreen.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/model/User.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digitAT/pages/acount.dart';
import 'package:digitAT/pages/conversations.dart' as prefix0;
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class TabsWidget extends StatefulWidget {

  final List<dynamic> acountInfos;
  
  const TabsWidget({Key key, this.acountInfos}) : super(key: key);

  
  @override
  State<StatefulWidget> createState() {
    return _BubblesState();
  }
}

class _BubblesState extends State<TabsWidget> with SingleTickerProviderStateMixin {
  User user;
  String id;
 
  @override
  void initState(){
  super.initState();
   SharedPreferences.getInstance().then((SharedPreferences sp) {
     setState(() {
       user=User.fromJson(jsonDecode(sp.getString('user')));
     id= sp.getString('id');
     });
   });
   print(id);
   fireStoreUser=user;
  }
  
  AnimationController _controller;
  int _page = 0;
  String currentTitle = 'Home';
  Widget _currentPage (int page){
    switch (page){
      case 0 :
        currentTitle = 'Home';
        return Home();
      case 1 :
        currentTitle = 'chat';  
        return ConversationsScreen(user: user);
      case 2 :
        currentTitle = 'profile';
        return AcountWidget(acountInfos:widget.acountInfos[1]);
      default:
        currentTitle = 'Home';
        return Home();

    }
    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage(_page),
      bottomNavigationBar: CurvedNavigationBar(
        
        initialIndex: 0,
        items: <Widget>[
          Icon(Icons.home, size: 25,color: Theme.of(context).primaryColor,),
          Icon(Icons.chat, size: 25,color: Theme.of(context).primaryColor,),
          Icon(Icons.perm_identity, size: 25,color: Theme.of(context).primaryColor,),
        ],
        color: Theme.of(context).accentColor,
        buttonBackgroundColor: Theme.of(context).accentColor,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
            _currentPage(_page);
          });
        },
      ),
    );
  }
}
