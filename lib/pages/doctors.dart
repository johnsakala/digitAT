import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/model/ContactModel.dart';
import 'package:digitAT/models/navigation.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/doctor.dart' as model;
import 'package:digitAT/models/user.dart';
import 'package:digitAT/widgets/doctorsWidget.dart';
import 'package:digitAT/widgets/searchWidget.dart';
import 'package:digitAT/api/doctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:digitAT/models/doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

//List<ContactModel> _searchResult = [];
//List<ContactModel> _contacts = [];

class DoctorsList extends StatefulWidget {
  
 const DoctorsList({Key key}) : super(key: key); 
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

TextEditingController searchDoctorController = new TextEditingController();
String searchString;

@override
class _DoctorsListState extends State<DoctorsList> {
  model.DoctorsList doctorsList;
List myDocs=[];
  Future<List> _getList()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String list= preferences.getString('docs');
    List result= jsonDecode(list);
    return result;
  
  }
  @override
  void initState() {
    this.doctorsList = new model.DoctorsList();
    super.initState();
    
    _getList().then((value) {
     myDocs.addAll(value);
    });
    searchDoctorController.addListener(() {
      setState(() {
        searchString = searchDoctorController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Doctors',
          style: TextStyle(
            fontSize: 22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 20,
                  padding:
                  const EdgeInsets.only(top: 0, left: 12.0, right: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0)),
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 0.0, left: 12.0, right: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color:
                            Theme.of(context).hintColor.withOpacity(0.10),
                            offset: Offset(0, 4),
                            blurRadius: 10)
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        TypeAheadField(
  textFieldConfiguration: TextFieldConfiguration(
  
    
    decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              hintText: 'Search',
              hintStyle: TextStyle(color: Theme.of(context).hintColor,fontFamily: 'Poppins'),
              prefixIcon: Icon(Icons.search, size: 20, color: Theme.of(context).hintColor),
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
  ),
 suggestionsCallback: (pattern) async {
    return await _fetchSugestions(pattern);
  },
  itemBuilder: (context, suggestion) {
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: Container(
      height: 40.0,width: 40.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100.0),
        image: DecorationImage(image: NetworkImage(suggestion.avatar), fit: BoxFit.cover,
      ),

      ),
      
    ),
      title: Text(suggestion.name,
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),),
      subtitle: Text(suggestion.description),
    );
  },
  onSuggestionSelected: (suggestion) {
   Navigator.of(context).pushNamed('/doctorProfil', arguments: suggestion);
  },
),
          
            Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: FutureBuilder<List<Doctor>>(
                    future: _fetchDoctors(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Doctor> data = snapshot.data;
                      
                        return _jobsListView(data);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(child:CircularProgressIndicator());
                    })),
                
          ],
        ),
      ),
              
                )
              ]
          
          )
          ]
          ))
    );
              
  }
List responseList = [];
  Future<List<Doctor>> _fetchDoctors() async {
//  showAlertDialog(context);
    final http.Response response = await http
        .get(
      '${webhook}crm.contact.list?filter[UF_CRM_1604303008535]=30',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List <Doctor> serverResponse = [];
    List<Doctor> _doctorsList = [];
    if (response.statusCode == 200) {
      try {
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++result ${responseBody["result"]}');
        if (responseBody["result"] != null) {
          //DepartmentUsers doctors_list = DepartmentUsers.fromJson(responseBody);
          
          //serverResponse = doctors_list.result;
          responseBody['result'].forEach((user) {
            print(" user");
            print("------\n");
            print(user['UF_CRM_1604090065799']);
            print("------\n");
            if(user['UF_CRM_1604303532891']==null){
              user['UF_CRM_1604303532891']="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU";
            }
            bool isFavoured= myDocs.contains(int.parse(user['UF_CRM_1598992339725']));
            _doctorsList.add(
              new Doctor(
                  user['NAME'] + " " + user['LAST_NAME'],
                  " ${user['UF_CRM_1604090065799']} 26 years of experience ",
                 "${user['UF_CRM_1604303532891']}",
                  "Open today",
                  Colors.green,
                 "${user['UF_CRM_1598992339725']}",isFavoured,
                  '1'),
            );
          });

          serverResponse = _doctorsList;
          print('----*------*-------* ${serverResponse.length}');
        } else {
          serverResponse = [];
          print(response.body);
        }
      } catch (error) {
        print(error);
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
    return serverResponse;
  }


Future<List<Doctor>> _fetchSugestions(String name) async {

    final http.Response response = await http
       .get(
         '${webhook}crm.contact.list?filter[UF_CRM_1604303008535]=30',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List <Doctor> serverResponse = [];
    List<Doctor> _doctorsList = [];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
        
          //DepartmentUsers doctors_list = DepartmentUsers.fromJson(responseBody);
          
          //serverResponse = doctors_list.result;
          responseBody['result'].forEach((user) {
            print("/*/*/*/*/*/*/*/*/*/*/*/* user");
            print("------\n");
            print(user['UF_CRM_1604303008535']);
            print("------\n");
            if(user['UF_CRM_1604303532891']==null){
              user['UF_CRM_1604303532891']="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU";
            }
            bool isFavoured= myDocs.contains(int.parse(user['UF_CRM_1598992339725']));
            _doctorsList.add(
              new Doctor(
                  user['NAME'] + " " + user['LAST_NAME'],
                  " ${user['UF_CRM_1604090065799']} 26 years of experience ",
                  "${user['UF_CRM_1604303532891']}",
                  "Open today",
                  Colors.green,
                  "${user['UF_CRM_1598992339725']}",isFavoured,
                  '1'),
            );
          });

          serverResponse = _doctorsList;
          setState(() {
            responseList=_doctorsList;
          });
        } else {
          serverResponse = [];
          print(response.body);
        }
      } catch (error) {
        print(error);
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
    return serverResponse;
  }
}

ListView _jobsListView(data) {
  return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: data.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 4.0);
      },
      
      itemBuilder: (context, index) {
//        return searchString == null || searchString == ""
//            ? DoctorsCardWidget(doctors: data.elementAt(index),) : items[index].contains(searchString)
//            ? DoctorsCardWidget(doctors: data.elementAt(index),) : new Container();

        return DoctorsCardWidget(
          doctors: data.elementAt(index),
        );



      });
}
