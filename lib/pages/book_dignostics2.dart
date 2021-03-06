import 'package:digitAT/models/medecine.dart';
import 'package:digitAT/models/medicine_list.dart';
import 'package:digitAT/models/navigation.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/medecine.dart' as model;
import 'package:digitAT/models/user.dart';
import 'package:digitAT/widgets/secondTestsWidget.dart';
class BookDignosticsOnlineSecondeStep extends StatefulWidget {

  final MedList value;
  const BookDignosticsOnlineSecondeStep( {Key key, this.value}) : super(key: key);
  @override
  _BookDignosticsOnlineSecondeStepState createState() => _BookDignosticsOnlineSecondeStepState();
}

class _BookDignosticsOnlineSecondeStepState extends State<BookDignosticsOnlineSecondeStep> {
  bool _loading=false;
  

  

  User currentUser=User.init().getCurrentUser();
  List<Medecine>medicines= [];
  List<String> medecineName=[];
  double bill=0.0;
  model.MedecinesList medecinesList;
  void initState() {
    setState(() {
      medicines.addAll(widget.value.list);
      bill=widget.value.bill;
    });
    this.medecinesList = new model.MedecinesList();
   // print("//////////////////////////////////////////////// pharmacistID"+widget.value[2].toString());
    super.initState();
  }
   final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
       appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Theme.of(context).primaryColor )
              
             
         ,
          onPressed: (){
            PageNav pageNav= PageNav(widget.value.pharmacy, widget.value.pid,bill,medicines, widget.value.responsibleId);
                  Navigator.of(context).pushNamed("/firstlabsbooking",arguments: pageNav);
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Checkout',
          style: TextStyle(
            fontSize:22.0,
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
                    height: 40,
                    padding: const EdgeInsets.only(left:0.0,right: 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25.0),bottomRight: Radius.circular(25.0)),
                      color: Theme.of(context).accentColor,
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 0,left: 12.0,right: 12.0),
                    child:Container(
                      padding:EdgeInsets.only(right: 12.0,left: 12.0,bottom: 12.0),
                      decoration: BoxDecoration(            
                       color: Theme.of(context).primaryColor,
                       borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: medicines.length ,
                            separatorBuilder: (context,index){
                              return SizedBox(height: 7,);
                            },
                            itemBuilder: (context,index){
                              return  Column(
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
                    '${medicines[index].name}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Theme.of(context).focusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${medicines[index].price}',
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
                    print(double.parse(medicines[index].price));
                    
                      
                    bill=bill-double.parse(medicines[index].price);
                    medicines.removeAt(index);
                    
                    
                    
                  });
                 print(bill);
                },
                icon: Icon(Icons.remove_circle_outline),
                color: Colors.red.withOpacity(0.8),
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
                          Container(
                            padding: EdgeInsets.only(left: 12.0,right: 17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      color: Theme.of(context).focusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$bill\$',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                      //fontWeight: FontWeight.bold,
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
             Container(
              padding:EdgeInsets.only(right: 0.0,left: 0.0,bottom: 0.0,top: 0),
              margin:EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1,color: Colors.grey.withOpacity(0.6)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      print('-----------------------'+widget.value.pid.toString());
                      PageNav pageNav= PageNav(widget.value.pharmacy, widget.value.pid,bill,medicines, widget.value.responsibleId);
                      Navigator.of(context).pushNamed('/bookTest',arguments: pageNav);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Colors.transparent,
                    child:Container(
                      margin: EdgeInsets.only(left: 45.0,right: 45.0,top: 12,bottom: 12),
                      child:Text(
                      '+ Add more scans',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Theme.of(context).focusColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child:Container(
              padding:EdgeInsets.only(right: 0.0,left: 40.0,bottom: 0.0,top: 0),
              margin:EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1,color: Colors.grey.withOpacity(0.6)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${medicines.length} medecines Added',
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
                          color: Theme.of(context).focusColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  _loading? CircularProgressIndicator(): RaisedButton(
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () async{
                   
                /* final snackBar = SnackBar(content: Text('Order Sent, you will receive a notification from the pharmacy'));
                    _scaffoldstate.currentState.showSnackBar(snackBar);
                  
                       if(result!=null){
                       print('*********************************appointment created');
                      }*/
                       MedList list= MedList.scan(widget.value.pharmacy, widget.value.pid, bill, medicines, widget.value.responsibleId);
                      Navigator.of(context).pushNamed("/thirdlabsbooking",arguments: list);
                      /*if(result!=null){
                       print('*********************************order created');
                      }*/
                     // Navigator.of(context).pushNamed('/home',arguments: [currentUser.name,currentUser.userID]);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Theme.of(context).accentColor,
                    child:Container(
                      margin: EdgeInsets.only(left: 35.0,right: 35.0,top: 12,bottom: 12),
                      child:Text(
                        'Checkout',
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