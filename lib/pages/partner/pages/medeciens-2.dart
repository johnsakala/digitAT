import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:digitAT/models/partner/models/medecine.dart';
import 'package:digitAT/models/partner/models/medicine_list.dart';
import 'package:digitAT/models/partner/models/payment.dart';
import 'package:digitAT/pages/partner/pages/medecines.dart';
import 'package:digitAT/pages/partner/pages/payment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:digitAT/models/partner/models/medecine.dart' as model;
import 'package:digitAT/models/partner/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MedecinesSlected extends StatefulWidget {
   final MedList value;
  const MedecinesSlected( {Key key, this.value}) : super(key: key);
  @override
  _MedecinesSlectedState createState() => _MedecinesSlectedState();
}

class _MedecinesSlectedState extends State<MedecinesSlected> {
 
  bool _loading=false;
int itemcount=0;
List<Medecine> groupCart(unGroupedCart){

List<Medecine> groupedCart=[];
int quantity=1;
for(int i=0;i<unGroupedCart.length;i++)
{
	int counter=i+1;
	while(counter<unGroupedCart.length)
	{	
		if(unGroupedCart[i].name==unGroupedCart[counter].name)
		{
			quantity++;
			
		}
    counter++;
	}
  List names=[];
for(int j=0;j<groupedCart.length;j++){
  
  names.add(groupedCart[j].name);
}
	if(names.contains(unGroupedCart[i].name)==false)
	{
    groupedCart.add(Medecine.cart(unGroupedCart[i].name,(double.parse(unGroupedCart[i].price)*quantity).toString(),quantity,double.parse(unGroupedCart[i].price)));

	}
	quantity=1;
}
setState(() {
  
  medicines=groupedCart;
});
print(groupedCart);
return groupedCart;
    }

  User currentUser=User.init().getCurrentUser();
  List<Medecine>medicines= [];
  double bill=0.0;
  model.MedecinesList medecinesList;
  void initState() {
    setState(() {
      itemcount=widget.value.quantity;
      bill=widget.value.bill;
    });
    this.medecinesList = new model.MedecinesList();
      groupCart(widget.value.list);
 
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
          icon: Icon(Icons.arrow_back, color:Theme.of(context).primaryColor ),
          onPressed: (){
            MedList list=MedList.p(widget.value.pid, medicines, bill,widget.value.pharmacy,widget.value.responsibleId, itemcount,widget.value.pageNav);
                      Navigator.of(context).pushNamed('/medecines',arguments: list);
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
                  Row(
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
                    '   X ${medicines[index].quantity}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      color: Colors.grey
                    ),
                  ),
                    ],
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
                    
                      
                    bill-=medicines[index].unitPrice;
                    if(medicines[index].quantity==1)
                    {
                      medicines.removeAt(index);
                       }
                    
                    else
                    medicines[index].quantity-=1;
                    itemcount-=1;
                    
                    
                    
                    
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
                      MedList list=MedList.p(widget.value.pid, medicines, bill,widget.value.pharmacy,widget.value.responsibleId,itemcount,widget.value.pageNav);
                      Navigator.of(context).pushNamed('/medecines',arguments: list);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Colors.transparent,
                    child:Container(
                      margin: EdgeInsets.only(left: 45.0,right: 45.0,top: 12,bottom: 12),
                      child:Text(
                      '+ Add more medicines',
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
                        '$itemcount medecines Added',
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
                   
                
                      Payments payments= Payments('Medicines Prescription',medicines.toString(), widget.value.pharmacistID,medicines, widget.value.bill,DateTime.now(), widget.value.responsibleId);
                     await _createPresciption(payments);
                      await confirmDialog( context, 'Prescription created'); 
                      Navigator.of(context).pushNamed('/patientacc'); 
                      
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

  Future<bool> confirmDialog(BuildContext context,String message) {

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Confirmation'),
            content: Container(
              height: 85,
              child:Text('$message'),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                 shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                color: Theme.of(context).accentColor,
                child: Text('OK'),
                onPressed: () {
                
                                     Navigator.of(context).pop();

                },
              )
            ],
          );
        });
  }

    Future _createPresciption(Payments payments) async {
//  showAlertDialog(context);
  SharedPreferences preferences= await SharedPreferences.getInstance();
  int id= preferences.getInt('id');
 //int result=0;
 
     final http.Response response = await http.post(
        '${webhook}tasks.task.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
  "fields":{ 
   "TITLE":payments.title,
   "DESCRIPTION":payments.description,
   "UF_AUTO_831530867848":widget.value.pageNav.patientId,
   "UF_AUTO_197852543914":payments.medicines.toJson(),
  
   "UF_AUTO_229319567783":"prescription",
   "RESPONSIBLE_ID":widget.value.pageNav.docName
  }

})).catchError((error) => print(error));
       if(response.statusCode==200)
       {
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           
        print('//////////////////////////////zvaita'+responseBody.toString());
 
       }
       else{
         print(response.statusCode);
       }
       //return responseBody['result'];
  }
}