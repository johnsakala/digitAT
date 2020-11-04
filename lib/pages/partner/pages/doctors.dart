import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/partner/models/navigation.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/partner/models/doctor.dart' as model;
import 'package:digitAT/widgets/partner/widgets/doctorsWidget.dart';
import 'package:digitAT/api/doctors.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:digitAT/models/partner/models/doctor.dart';

class DoctorsList extends StatefulWidget {
  final PageNav pageNav;
 const DoctorsList({Key key,this.pageNav}) : super(key: key); 
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

TextEditingController searchDoctorController = new TextEditingController();
String searchString;

@override
class _DoctorsListState extends State<DoctorsList> {
  model.DoctorsList doctorsList;
  @override
  void initState() {
    this.doctorsList = new model.DoctorsList();
    super.initState();
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
          '${widget.pageNav.title}',
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
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                          controller: searchDoctorController,
                          onTap: () {},
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontFamily: 'Poppins'),
                            prefixIcon: Icon(Icons.search,
                                size: 20, color: Theme.of(context).hintColor),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                        print("*-*-*-*-*-*-*-*-*-*-*-*-"+snapshot.data[0].resId);
                        return _jobsListView(data);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(child:CircularProgressIndicator());
                    })),
                
          ],
        ),
      ),
    );
  }

  Future<List<Doctor>> _fetchDoctors() async {
//  showAlertDialog(context);
    final http.Response response = await http
        .get(
      '${webhook}user.get.json?UF_DEPARTMENT=${widget.pageNav.id}',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List serverResponse = [];
    List<Doctor> _doctorsList = [];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
//        print(responseBody);
          DepartmentUsers doctors_list = DepartmentUsers.fromJson(responseBody);
          serverResponse = doctors_list.result;
          doctors_list.result.forEach((user) {
            print("------\n");
            print(user.nAME);
            print("------\n");
            if(user.pERSONALPHOTO==null){
              user.pERSONALPHOTO="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU";
            }
            bool isFavoured= myDoctors.contains(int.parse(user.iD));
            _doctorsList.add(
              new Doctor(
                  user.nAME + " " + user.lASTNAME,
                  " ${user.pERSONALPROFESSION} 26 years of experience ",
                  user.pERSONALPHOTO,
                  "Closed To day",
                  Colors.green,
                  user.iD,isFavoured,
                  widget.pageNav.responsibleId),
            );
          });

          serverResponse = _doctorsList;
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
