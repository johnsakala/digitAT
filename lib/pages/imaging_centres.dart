import 'dart:convert';
import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/medecine.dart';
import 'package:digitAT/models/navigation.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:digitAT/widgets/searchWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ImagingCentres extends StatefulWidget {
  final PageNav pageNav;
  const ImagingCentres({Key key, this.pageNav}):super(key:key);
  @override
  _ImagingCentresState createState() => _ImagingCentresState();
}

class _ImagingCentresState extends State<ImagingCentres> {
  User currentUser=User.init().getCurrentUser();
  //model.MedecinesList medecinesList;
  
  Future< List< dynamic >> _fetchDocCatergories() async {
//  showAlertDialog(context);
    final http.Response response = await http
        .get('${webhook}department.get?PARENT=${widget.pageNav.id}',
    )  .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    
    List< dynamic> result=[];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
         
            print('result //////////////////////////////'+ responseBody["result"].toString());
      result = responseBody["result"];
         
                      print('list //////////////////////////////'+ result.toString());
   
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
    print('response //////////////////////////////'+result.toString());
    return result;
  }
      

  void initState() {
    //this.medecinesList = new model.MedecinesList();
    super.initState();
   
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
            fontSize:22.0,
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
                    padding: const EdgeInsets.only(top: 0,left: 12.0,right: 12.0),
                    child:SearchBarWidget(),
                  ),
              ],
            ),
            Container(
              padding:EdgeInsets.only(top:12.0,right: 12.0,left: 12.0,bottom: 12.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Imaging Centres',
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
                  InkWell(
                    onTap: (){
                      print('add');
                    List<Medecine> list=[];
                    PageNav pageNav= PageNav(snapshot.data[index]['NAME'], snapshot.data[index]['ID'],0.0,list,widget.pageNav.responsibleId);
  
          Navigator.of(context).pushNamed("/bookTest",arguments: pageNav);
                    },
                                      child: Column(
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
               
                ],
              ),
              IconButton(
                onPressed: (){
                     print('add');
                    List<Medecine> list=[];
                    PageNav pageNav= PageNav(snapshot.data[index]['NAME'], snapshot.data[index]['ID'],0.0,list,widget.pageNav.responsibleId);
  
          Navigator.of(context).pushNamed("/bookTest",arguments: pageNav); 
                
                 },
                icon: Icon(Icons.arrow_forward),
                color: Theme.of(context).accentColor.withOpacity(0.8),
                iconSize: 30,

              )
            ],
          ),
        ),
        SizedBox(height: 15.0,child: Center(child: Container(height: 1.0,color: Colors.grey.withOpacity(0.1),),),),
      ],
    ),
                  );
                },
              ),                
            ),
          ],
        ),
      );
          }
          else{
            return Center(
              child: CircularProgressIndicator()
            );
          }
        } ,
        future: _fetchDocCatergories(),
      ),
     
    );
  }
}