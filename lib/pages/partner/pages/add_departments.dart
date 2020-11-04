import 'dart:convert';
import 'package:hashtagable/hashtagable.dart';
import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/partner/models/add_departments.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDepartments extends StatefulWidget {
  final AddDpt seleted;
  const AddDepartments({Key key,this.seleted}):super(key:key);
  @override
  _AddDepartmentsState createState() => _AddDepartmentsState();
}

class _AddDepartmentsState extends State<AddDepartments> with TickerProviderStateMixin {
  final int _startingTabCount = 4;
 String hint='eg #Name';
  List<Widget> formFields=[];
    final name1 = TextEditingController();
  final name2 = TextEditingController();
  final name3 = TextEditingController();
  final name4 = TextEditingController();
  final name5 = TextEditingController();
  String departments='';
  TextEditingController docController= TextEditingController();
  TextEditingController pharmController= TextEditingController();
  TextEditingController labController= TextEditingController();
  TextEditingController scanController= TextEditingController();
  
  List<String> docs=[],scan=[],lab=[],pharm=[], docList=[],pharmList=[],labList=[], scanList=[];
  List<Tab> _tabs = List<Tab>();
  List<Widget> _generalWidgets = List<Widget>();
  TabController _tabController;
  bool load=false;
  String header='Departments';
 

  @override
  void initState() {
    
    _tabs = getTabs(widget.seleted.depts.length);
    _tabController = getTabController();
     
     
    formFields.add( TextFormField(
          controller: name1,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
              labelText: 'Name'
          ),
        ),);
        formFields.add( TextFormField(
          controller: name2,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
              labelText: 'Name'
          ),
        ),);
        formFields.add( TextFormField(
          controller: name3,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
              labelText: 'Name'
          ),
        ),); 
        formFields.add( TextFormField(
        
          controller: name4,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
              labelText: 'Name'
          ),
        ),);
        formFields.add( TextFormField(
          controller: name5,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
              labelText: 'Name'
          ),
        ),); 
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Registration",
        style: TextStyle(
          color: Theme.of(context).primaryColor
        ),),
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
    
   });
            print(formFields.length);
            
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).accentColor,
        ),*/
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: getWidgets(),
            ),
          ),
          Row(
            children: <Widget>[
              if (!isFirstPage())
                Expanded(
                  child: RaisedButton(
                    elevation: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color:Colors.grey.withOpacity(0.6),
                    child: Container(
                       margin: EdgeInsets.only(
                        left: 45.0, right: 45.0, top: 12, bottom: 12),
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      
                      ),
                  onPressed: (){
                    goToPreviousPage();
                  }
                  ),
                ),
              Expanded(
                child: load? CircularProgressIndicator(): RaisedButton(
                    elevation: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Theme.of(context).accentColor,
                  child: Container(
                     margin: EdgeInsets.only(
                        left: 45.0, right: 45.0, top: 12, bottom: 12),
                    child: Text(
                       isLastPage() ? "Finish" : "Next",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    ), onPressed:(){
                   
                   
                   addSubDept(widget.seleted.depts[_tabController.index].name);
                   goToNextPage();
                  } ),
              )
            ],
          )
        ],
      ),
    );
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this)..addListener(_updatePage);
  }

  Tab getTab(int i) {
    return Tab(
      
      icon: ImageIcon(AssetImage(widget.seleted.depts[i].avatar,),
      color:Colors.white,
      size: 30,
      ),
    );
  }

  Widget getWidget(String name) {
    return Center(
      child: Column(
        children: <Widget>[
          Text("Widget nr: $name"),
         
        ],
      ),
    );
  }

  List<Tab> getTabs(int count) {
    _tabs.clear();
    
    for (int i = 0; i < count; i++) {
      _tabs.add(getTab(i));
    }
    return _tabs;
  }

  List<Widget> getWidgets() {
    _generalWidgets.clear();
    
                   
       
       
     
    for (int i = 0; i < _tabs.length; i++) {
  if(widget.seleted.depts[i].name=='Waiting Room'){
        _generalWidgets.add(Center(child:Text('No Categories required')));
       }else{
      _generalWidgets.add(formBuilder(context,i));
      
    }
       }
    return _generalWidgets;
  }
  void addSubDept(String i){

          
          
       
   
    switch(i){
     
      case 'Doctors':{
        List  list=extractHashTags(docController.text);
        setState(() {
          docList=list;
          header='Catergories';
        });
        print(docList);
        for(int i=0;i<docList.length;i++){
          docs.add(docList[i].substring(1));
        }
        
       
             }
      break;
       case 'Pharmacy':{
         List  list=extractHashTags(pharmController.text);
           setState(() {
             pharmList=list;
          header='Pharmacies';
        });
        print(pharmList);
        for(int i=0;i<pharmList.length;i++){
          pharm.add(pharmList[i].substring(1));
        }
      
       
             }
      break;
       case 'Lab':{
         List  list=extractHashTags(labController.text);
           setState(() {
             labList=list;
          header='Laboritories';
        });
        print(labList);
        for(int i=0;i<labList.length;i++){
          lab.add(labList[i].substring(1));
        }
        
       
             }
      break;
       case 'Scan':{
         List  list=extractHashTags(scanController.text);
           setState(() {
             scanList=list;
          header='Imaging Centres';
        });
        print(scanList);
        for(int i=0;i<scanList.length;i++){
          scan.add(scanList[i].substring(1));
        }
        
       
             }
      break;
    }
  }
  void _addIfCanAnotherTab() {
    if (_startingTabCount == _tabController.length) {
      showWarningTabAddDialog();
    } else {
      _addAnotherTab();
    }
  }

  void _addAnotherTab() {
    _tabs = getTabs(_tabs.length + 1);
    _tabController.index = 0;
    _tabController = getTabController();
    _updatePage();
  }

  void _removeTab() {
    _tabs = getTabs(_tabs.length - 1);
    _tabController.index = 0;
    _tabController = getTabController();
    _updatePage();
  }

  void _updatePage() {
    setState(() {});
  }

  //Tab helpers

  bool isFirstPage() {
    return _tabController.index == 0;
  }

  bool isLastPage() {
    return _tabController.index == _tabController.length - 1;
  }

  void goToPreviousPage() {
    _tabController.animateTo(_tabController.index - 1);
    if(widget.seleted.depts[_tabController.index].name=='Doctors'){
       docs.clear();
        }
        else if(widget.seleted.depts[_tabController.index].name=='Pharmacy'){
      pharm.clear();
        }
        else  if(widget.seleted.depts[_tabController.index].name=='Lab'){
         lab.clear();
        } 
        else{
          scan.clear();        } 
    
   
  }

  Future goToNextPage() async {
    if(isLastPage()){
      
      for(int i=0;i<widget.seleted.depts.length;i++){
          await saveSubdepartments(i,widget.seleted.depts[i].name);
      }
      SharedPreferences preferences= await SharedPreferences.getInstance();
                    int id = preferences.getInt('id');
                  await  _putResponsible( depts, id);
      
      
    Navigator.of(context).pushNamed('/home');

    }else{

      
_tabController.animateTo(_tabController.index + 1);
    }
        
  }

  void showWarningTabAddDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Cannot add more tabs"),
              content: Text("Let's avoid crashing, shall we?"),
              actions: <Widget>[
                FlatButton(
                    child: Text("Crash it!"),
                    onPressed: () {
                      _addAnotherTab();
                      Navigator.pop(context);
                    }),
                FlatButton(child: Text("Ok"), onPressed: () => Navigator.pop(context))
              ],
            ));
  }

   Column formBuilder(BuildContext context,int index) {
    return Column(
      children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text( widget.seleted.depts[index].categoryName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    color: Theme.of(context).focusColor,
                    fontWeight: FontWeight.bold,)),
            ),
       dynamicForm(index),
        SizedBox(height:20),
       
        
       /* Expanded(
                  child: ListView.builder(
            itemCount: formFields.length,
            itemBuilder: (BuildContext context, int i){
              return formFields[i];
            }),
        ),
          TextFormField(
          controller: name1,
          decoration: const InputDecoration(
              labelText: 'Name'
          ),
        ),
        SizedBox(height:20),
        TextFormField(
          controller: name2,
          decoration: const InputDecoration(
              labelText: 'Name'
          ),
        ),
        SizedBox(height:20),
        TextFormField(
          controller: name3,
          decoration: const InputDecoration(
              labelText: 'Name'
          ),
        ),*/
        SizedBox(height:20),
        
      
        
      ],
            );
          
   
       
  }
  Widget dynamicForm(int index){
     if(widget.seleted.depts[index].name=='Doctors'){
    return HashTagTextField(
          controller: docController,
          decoration: InputDecoration(
            hintText: ' eg #Dematologists #General',
            hintStyle: TextStyle(
              color: Colors.grey
            )
          ),
           
                basicStyle: TextStyle(fontSize: 15, color: Colors.black),
                decoratedStyle: TextStyle(fontSize: 15, color: Colors.blue),
              );
        }
        else if(widget.seleted.depts[index].name=='Pharmacy'){
    return HashTagTextField(
          controller: pharmController,
          decoration: InputDecoration(
            hintText: 'eg #Pharmacy1 #Pharmacy2',
            hintStyle: TextStyle(
              color: Colors.grey
            )
          ),
           
                basicStyle: TextStyle(fontSize: 15, color: Colors.black),
                decoratedStyle: TextStyle(fontSize: 15, color: Colors.blue),
              );
        }
        else  if(widget.seleted.depts[index].name=='Lab'){
    return HashTagTextField(
          controller: labController,
          decoration: InputDecoration(
            hintText:'eg #Lab1 #Lab2',
            hintStyle: TextStyle(
              color: Colors.grey
            )
          ),
           
                basicStyle: TextStyle(fontSize: 15, color: Colors.black),
                decoratedStyle: TextStyle(fontSize: 15, color: Colors.blue),
              );
        } 
        else{
          return HashTagTextField(
          controller: scanController,
          decoration: InputDecoration(
            hintText: 'eg #ImagingCentre #Radiology',
            hintStyle: TextStyle(
              color: Colors.grey
            )
          ),
           
                basicStyle: TextStyle(fontSize: 15, color: Colors.black),
                decoratedStyle: TextStyle(fontSize: 15, color: Colors.blue),
              );
        }
  }
 
    Future <bool>_putResponsible( List dept, int id) async {
   setState(() {
     load=true;
   });
  bool result=false;
    final http.Response response = await http.post(
        '${webhook}user.update',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
           "ID": id, 
           "UF_DEPARTMENT":dept
            
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
      
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
         
        print("//////////update"+responseBody['result'].toString());
 
       }
       else{
         print(response.statusCode);
       }
       print(result);
       return result;
  }

  Future  saveSubdepartments(int index, String name) async{
     setState(() {
     load=true;
   });
     switch(name){
      case 'Doctors':{
       
    for(int i=0;i<docs.length;i++){
       final http.Response response = await http.post(
        '${webhook}department.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         "NAME": docs[i], 
         "PARENT": widget.seleted.ids[index]
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
     
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
          
        print("//////////id"+responseBody['result'].toString());
         depts.add(responseBody['result']);
       }
       else{
         print(response.statusCode);
       }
       }
       
             }
      break;
       case 'Pharmacy':{
        for(int i=0;i<pharm.length;i++){
       final http.Response response = await http.post(
        '${webhook}department.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         "NAME": pharm[i], 
         "PARENT": widget.seleted.ids[index]
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
     
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
          
        print("//////////id"+responseBody['result'].toString());
        depts.add(responseBody['result']);
         
       }
       else{
         print(response.statusCode);
       }
       }
       
             }
      break;
       case 'Lab':{
  for(int i=0;i<lab.length;i++){
       final http.Response response = await http.post(
        '${webhook}department.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         "NAME": lab[i], 
         "PARENT": widget.seleted.ids[index]
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
     
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
          
        print("//////////id"+responseBody['result'].toString());
        depts.add(responseBody['result']);
         
       }
       else{
         print(response.statusCode);
       }
       }
       
             }
      break;
       case 'Scan':{
      for(int i=0;i<scan.length;i++){
       final http.Response response = await http.post(
        '${webhook}department.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         "NAME": scan[i], 
         "PARENT": widget.seleted.ids[index]
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
     
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
          
        print("//////////id"+responseBody['result'].toString());
        depts.add(responseBody['result']);
         
       }
       else{
         print(response.statusCode);
       }
       }
       
             }
      break;
    }



    }

}