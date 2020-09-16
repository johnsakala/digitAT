import 'package:flutter/material.dart';
import 'package:digitAT/models/user.dart';
import 'package:digitAT/models/offer.dart' as model;
import 'package:digitAT/widgets/offersWidget.dart';
class OffersList extends StatefulWidget {
  final User currentUser=User.init().getCurrentUser();
  @override
  _OffersListState createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  
  model.OffersList offersList;
  @override
  void initState() {
    this.offersList = new model.OffersList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(16.0),bottomRight: Radius.circular(16.0)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Theme.of(context).primaryColor )
              
             
         ,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Offers',
          style: TextStyle(
            fontSize:22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

      ),
      body: SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(            
               color: Colors.transparent,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: offersList.offer.length,
                separatorBuilder: (context,index){
                  return SizedBox(height: 4.0);
                },
                itemBuilder: (context,index){
                  return OffersCardWidget(
                    offer: offersList.offer.elementAt(index),
                  );
                },
              ),
            ),
          ],
        ),      
      ),
    );
  }
  
}
