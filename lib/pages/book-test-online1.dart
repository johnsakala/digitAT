import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/medecine.dart';
import 'package:digitAT/models/medecine.dart' as model;
import 'package:digitAT/models/navigation.dart';
import 'package:flutter/material.dart';

import 'package:digitAT/models/medicine_list.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart'as http;
import 'package:digitAT/models/test.dart' as model;
import 'package:digitAT/models/user.dart';
import 'package:digitAT/widgets/searchWidget.dart';
import 'package:digitAT/widgets/testsWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
class BookTestsOnline extends StatefulWidget {
  final PageNav pageNav;
 const BookTestsOnline({Key key,this.pageNav}) : super(key: key); 
  @override
  _BookTestsOnlineState createState() => _BookTestsOnlineState();
}

class _BookTestsOnlineState extends State<BookTestsOnline> {
  User currentUser=User.init().getCurrentUser();
   List<Medecine>medicines= [];
   List allscans=[];
  double bill=0.0;
  final TextEditingController _typeAheadController = TextEditingController();
  model.TestsList testsList;
  void initState() {
    this.testsList = new model.TestsList();
    super.initState();
    bill= widget.pageNav.bill;
      medicines= widget.pageNav.list;
  }
  Future<List<dynamic>> _suggestScans(String pattern) async {
    List<dynamic> result = [];

    for (int i = 0; i < allscans.length; i++) {
      print(pattern);
      print(allscans[i]['NAME']);
      print(allscans[i]['NAME'].contains(pattern, 1));

      if (allscans[i]['NAME']
          .toLowerCase()
          .contains(pattern.toLowerCase().trim())) {
        result.add(allscans[i]);
      }
    }
    
    return result;
  }
    Future <List<dynamic>> _fetchScans() async {
//  showAlertDialog(context);
    final http.Response response = await http
        .get('${webhook}crm.product.list?filter[SECTION_ID]=$scanId',
    )  .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    
    List< dynamic> result=[];
    if (response.statusCode == 200) {
     

      try {
        if (responseBody["result"] != null) {
               result = responseBody["result"];
            
        } else {
          
          print('-----------------'+response.body);
        }
      } catch (error) {
        print('-----------------'+error);
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
    print(result);
    setState(() {
      allscans=result;
    });
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Theme.of(context).primaryColor )
              
             
         ,
          onPressed: (){
            Navigator.of(context).pop();
           // Navigator.of(context).pushNamed('/home', arguments:[currentUser.name,currentUser.phoneNumber]);
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          widget.pageNav.title,
          style: TextStyle(
            fontSize:18.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

      ),
      body: FutureBuilder(
        builder:(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
          if(snapshot.hasData){
          return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
                    children: <Widget>[
                       Container(
                    height: 20,
                    padding: const EdgeInsets.only(left:0.0,right: 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25.0),bottomRight: Radius.circular(25.0)),
                      color: Theme.of(context).accentColor,
                    ),
                    
                  ),
                  Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 12.0, right: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.10),
                                    offset: Offset(0, 4),
                                    blurRadius: 10)
                              ],
                            ),
                            child: Column(children: <Widget>[  TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: this._typeAheadController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(12),
                                    hintText: 'Find Scans',
                                    hintStyle: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontFamily: 'Poppins'),
                                    prefixIcon: Icon(Icons.search,
                                        size: 20,
                                        color: Theme.of(context).hintColor),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  return await _suggestScans(pattern);
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                noItemsFoundBuilder: (Object error) => ListTile(
                                    title: Text('No scan(s) match ',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).errorColor))),
                                itemBuilder: (context, suggestion) {
                                  return 
                                      SingleChildScrollView(
                                       
                                               child:ListTile(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  
                                                  
                                                  title: Text(
                                                    suggestion['NAME'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle: Text(suggestion['PRICE']),
                                                   trailing:                                                  
                                                      IconButton(
                                                        onPressed: () {
                                                         setState(() {
                   bill= bill+ double.parse(suggestion['PRICE']);
                 medicines.add(model.Medecine(suggestion['NAME'], suggestion['PRICE']));
             }); 
                                                        },
                                                        icon: Icon(
                                                            Icons.add_circle_outline),
                                                        color: Theme.of(context)
                                                            .accentColor
                                                            .withOpacity(0.8),
                                                        iconSize: 30,
                                                      ),
                                                  
                                                  
                                                )
                                      );
                                            
                                    
                                },
                                onSuggestionSelected: (suggestion) {
                                           
                                },
                       ),
                            ]),
                          ))
              ],
            ),
            /*Container(
              padding:EdgeInsets.only(top:12.0,right: 12.0,left: 12.0,bottom: 12.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Select Service:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                  color: Theme.of(context).focusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding:EdgeInsets.only(right: 12.0,left: 12.0,bottom: 12.0),
              decoration: BoxDecoration(            
               color: Theme.of(context).primaryColor,
               borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                shrinkWrap: true,
                primary: false,
                itemCount: snapshot.data.length,
                separatorBuilder: (context,index){
                  return SizedBox(height: 7,);
                },
                itemBuilder: (context,index){
                  return 
                  Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 12.0,right: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${snapshot.data[index]['NAME']}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Theme.of(context).focusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${snapshot.data[index]['PRICE']}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      color: Colors.grey
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: (){
                  
                 setState(() {
                   bill= bill+ double.parse(snapshot.data[index]['PRICE']);
                 medicines.add(model.Medecine(snapshot.data[index]['NAME'], snapshot.data[index]['PRICE']));
             });
                
                 },
                icon: Icon(Icons.add_circle_outline),
                color: Theme.of(context).accentColor.withOpacity(0.8),
                iconSize: 30,

              )
            ],
          ),
        ),
        SizedBox(height: 15.0,child: Center(child: Container(height: 1.0,color: Colors.grey.withOpacity(0.1),),),),
      
      
      
                         
      ],
    );
                },
              ), 
                             
            ),*/
             
          ],
        ),
      );}else{
     return Center(child: CircularProgressIndicator(),);
      }
        },
        future: _fetchScans(),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
              padding:EdgeInsets.only(right: 0.0,left: 30.0,bottom: 0.0,top: 0),
              margin:EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1,color: Colors.grey.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${medicines.length} medecine Added',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.grey
                        ),
                      ),
                      Text(
                        '\$ $bill',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: (){
                      MedList list= MedList.scan(widget.pageNav.title, widget.pageNav.id, bill, medicines,widget.pageNav.responsibleId);
                      Navigator.of(context).pushNamed("/secondeBookTest",arguments: list);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Theme.of(context).accentColor,
                    child:Container(
                      margin: EdgeInsets.only(left: 45.0,right: 45.0,top: 12,bottom: 12),
                      child:Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
      ),
    );
  }
}