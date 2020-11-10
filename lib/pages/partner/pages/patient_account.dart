import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/partner/models/account_card.dart';
import 'package:digitAT/models/partner/models/medecine.dart';
import 'package:digitAT/models/partner/models/medicine_list.dart';
import 'package:digitAT/models/partner/models/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Color primaryColor = Color(0xff0074ff);

class PatientAccount extends StatefulWidget {
  final PatientCard patient;
  const PatientAccount({Key key, this.patient}) : super(key: key);

  @override
 _PatientAccountState  createState() =>_PatientAccountState ();
}
class _PatientAccountState extends State<PatientAccount>{
  bool _appointmentConfirmed=false;
  bool _presciptionConfirmed= false;
  bool _diagnosticsConfirmed= false;
  bool _scanConfirmed= false;
  String docName;
  int id;
  List<String> medNames=[];
  


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      String _name;
      int _testValue;
      _testValue = sp.getInt('id');
      _name = sp.getString('name');

      // will be null if never previously saved
      if (_testValue == null ) {
        _testValue = null;
       
         // set an initial value
      }
      
      setState(() {
        id=_testValue;
        docName=_name;
        

      });
    
    });
  

  }

  @override
  Widget build(BuildContext context) {
     Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomBar(context),
      body: _buildBody(context,  media),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Patient',
      style: TextStyle(
        color: Theme.of(context).primaryColor
      ),),
      backgroundColor: Theme.of(context).accentColor,
      elevation: 0,
       leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
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
              icon:Image.asset('images/nurse-grey.png'),
              onPressed: (){
                Navigator.of(context).pushNamed('/home');
              },
              color: Colors.grey,
            ),
            IconButton(
              iconSize: 30,
              icon:Image.asset('images/pill-grey.png'),
              onPressed: (){

              },
              color: Colors.grey,
            ),
            IconButton(
              iconSize: 30,
              icon:Image.asset('images/TheLab-grey.png'),
              onPressed: (){

              },
              color: Colors.grey,
            ),
            IconButton(
              iconSize: 30,
              icon:Image.asset('images/microscope-grey.png'),
              onPressed: (){

              },
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Size media) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            height: 160,
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
                  
                  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "images/asset-2.png"),
                ),
              ),
            ),
            Container(
              width: 180,
              child: ListTile(
                title: Text(
                  widget.patient.name,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('ID: BA953',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    
                  ),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.call,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.mail,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
              Icon(
                  Icons.message,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20,),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: <Widget>[
            
            Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                     
                       child: Text(
                          widget.patient.date,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                         Container(child: Text('0900hrs',
                         style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    
                  ),)),
                      
                    
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width/3,),
                  Column(
                  children: <Widget>[
                    Container(
                     
                       child: Text(
                          "Consultation",
                          style: TextStyle(
                             color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                         Container(child: Text('Specialist',
                         style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    
                  ),)),
                      
                    
                  ],
                ),
              ],
            ),
           
          ],
        )

                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 4,
          child: SingleChildScrollView(
                      child: Container(
             
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Vitals",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                   Column(
                     children: <Widget>[
                       buildDashboardRow1(),
                     
                       buildDashboardRow2(),
                     ],
                   ),
                   Column(
                            children: <Widget>[
                                 Center(
                      child: Text(
                        "Book for client",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                              _appointmentConfirmation(media),
                              
                            ],
                          ),
                 
                    SizedBox(height: 20),
                    
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  
   Widget buildDashboardRow1() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('images/bp.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Blood Pressure",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "120/60",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            width: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
   
                        image: ExactAssetImage('images/covid19-score.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Covid-19 Score",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "36.9ºC",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDashboardRow2() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('images/pulse.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Pulse Rate",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "85",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            width: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('images/res-rate.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Respiration rate",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "14",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentConfirmation(Size media) {
    return  SingleChildScrollView(
          child: Column(
          
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: media.width/2,
                    child: ListTile(
                      leading:Image.asset('images/nurse.png',
                      height: 30,
                      width: 30,),
                      
                      trailing: CupertinoSwitch(
                        activeColor: Theme.of(context).accentColor,
                        onChanged: (bool value) {
                          setState(() {
                            _appointmentConfirmed=value;
                            if(value)
                             Navigator.of(context).pushNamed('/doctorcategories', arguments: pageNavDoc);
                          });
                        },
                        value: _appointmentConfirmed,
                      ),
                    ),
                  ),
                ),
                 Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: media.width/2,
                child: ListTile(

                  leading:Image.asset('images/pill.png',
                      height: 30,
                      width: 30,) ,
                  
                  
                  trailing: CupertinoSwitch(
                    activeColor: Theme.of(context).accentColor,
                    onChanged: (bool value)async {
                   //  
                      PageNav pageNavi= PageNav.special("Pharmacy", pharmahubId.toString(), widget.patient.id, docName);
                      setState(() {
                        _presciptionConfirmed=value;

                        if(value){
                          List<Medecine> meds=[];
                          MedList list =MedList.p("1", meds, 0.0, "Medicines","1",0,pageNavi, medNames);
                          Navigator.of(context).pushNamed('/medecines',arguments:list );
                        }
                       // Navigator.of(context).pushNamed('/pharmacies',arguments: pageNavi);
                      });
                    },
                    value: _presciptionConfirmed,
                  ),
                ),
              ),
            ),
              ],
            ),
           
            Row(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: media.width/2 ,
                    child: ListTile(
                      leading: Image.asset('images/TheLab.png',
                      height: 30,
                      width: 30,) ,
                     
                      
                      trailing: CupertinoSwitch(
                        activeColor: Theme.of(context).accentColor,
                        onChanged: (bool value) {
                          setState(() {
                            _diagnosticsConfirmed=value;
                            if(value)
                             Navigator.of(context).pushNamed('/labs', arguments: pageNavLab);
                          });
                        },
                        value: _diagnosticsConfirmed,
                      ),
                    ),
                  ),
                ),
                 Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: media.width/2,
                child: ListTile(
                  leading: Image.asset('images/microscope.png',
                      height: 30,
                      width: 30,),
                  
                  trailing: CupertinoSwitch(
                    activeColor: Theme.of(context).accentColor,
                    onChanged: (bool value) {
                      setState(() {
                        _scanConfirmed=value;
                        if(value)
                         Navigator.of(context).pushNamed('/imagingcentres', arguments: pageNavScan);
                      });
                    },
                    value: _scanConfirmed,
                  ),
                ),
              ),
            ),
              ],
            ),
           
          ],
       
      ),
    );
  }


  String getMonth(int index) {
     final months = [ 'Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sept'];
    return months[index];
  }

}