import 'package:digitAT/comm/chat/ChatScreen.dart';
import 'package:digitAT/models/model/ConversationModel.dart';
import 'package:digitAT/models/model/HomeConversationModel.dart';
import 'package:digitAT/models/model/User.dart';
import 'package:digitAT/services/FirebaseHelper.dart';
import 'package:digitAT/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/doctor.dart' as model;
import 'package:digitAT/main.dart';

List<User> _friendsSearchResult = [];
List<HomeConversationModel> _conversationsSearchResult = [];
List<User> _friends = [];
List<HomeConversationModel> _conversations = [];

class MyDoctorsCardWidget extends StatefulWidget {
  final model.Doctor doctors;
  const MyDoctorsCardWidget({Key key, this.doctors}) : super(key: key);
  
  @override
  _MyDoctorsCardWidgetState createState() => _MyDoctorsCardWidgetState();
}

class _MyDoctorsCardWidgetState extends State<MyDoctorsCardWidget> {

  final fireStoreUtils= FireStoreUtils();
  List<User> _friendsSearchResult = [];
  
  Future<List<User>> _friendsFuture;
  Stream<List<HomeConversationModel>> _conversationsStream;
  User friend ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireStoreUtils.getBlocks().listen((shouldRefresh) {
      if (shouldRefresh) {
        setState(() {});
      }
    });
    _friendsFuture = fireStoreUtils.getFriends();
   // _conversationsStream = fireStoreUtils.getConversations(MyAppState.currentUser.userID);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: (){
              Navigator.of(context).pushNamed('/doctorProfil', arguments: widget.doctors);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Card(
              elevation:0.2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1), offset: Offset(0,4), blurRadius: 10)
                  ],
                ),
                padding: const EdgeInsets.only(top:20.0,bottom: 20.0,left: 12.0,right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 25.0),
                          child:ball(this.widget.doctors.avatar),
                        ),
                        Container(
                          width: 150,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${widget.doctors.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 12,),
                              Text(
                                widget.doctors.description==null?'${widget.doctors.profession}':'${widget.doctors.description}',
                                textWidthBasis: TextWidthBasis.longestLine,
                                
                                style: TextStyle(

                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          )

                        ),
                      ],
                    ),
                    /*Container(
                      child: IconButton(  
                        padding: EdgeInsets.all(0),
                        onPressed: ()async{
 

      
  
                          Navigator.of(context).pushNamed('/chat');
                          /* String channelID;
                            if ("1"
                                .compareTo("2") <
                                0) {
                              channelID =
                                  "1" +"2";
                            } else {
                              channelID =
                                  "2" + "1";
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
                                        conversationModel)));*/
                        },
                        icon: Icon(Icons.chat_bubble_outline),
                        iconSize: 20,
                        color: Theme.of(context).accentColor,
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ),

        ],
      )
      
    );
  }
  Widget ball(String image){
    return Container(
      height: 60,width: 60.0,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(100.0),
        image: DecorationImage(image: Image.network(image).image, fit: BoxFit.cover,)

      ),
    );
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
}