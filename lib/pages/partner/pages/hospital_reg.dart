import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/partner/models/add_departments.dart';
import 'package:digitAT/models/partner/models/hospital_departments.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalReg extends StatefulWidget {
  @override
  _HospitalRegState createState() => _HospitalRegState();
}

class _HospitalRegState extends State<HospitalReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            //Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Hospital Registration',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.0,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.white,
        child: FormWidget(),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool wchecked = true,
      dchecked = true,
      pchecked = true,
      ichecked = true,
      lchecked = true;
  int _stepNumber = 1, _hospitalId;
  bool load = false;
  Country _selected = Country.ZW; 
  String _country;
  List<int> responses = [];
  List<HospitalDepartment> hospitalDept = [];
  final name = TextEditingController();
  final address = TextEditingController();
  final country = TextEditingController();
  final other1 = TextEditingController();
  final other2 = TextEditingController();

  void saveData(BuildContext context) {
    _formKey.currentState.save();
  }

  void nextPage(BuildContext context) {
    setState(() {
      if (_stepNumber == 1)
        _stepNumber = 2;
      else if (_stepNumber == 2) _stepNumber = 1;
    });
  }

  Column formBuilder(BuildContext context) {
    return Column(children: <Widget>[
      Text('Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.0,
            color: Theme.of(context).focusColor,
            fontWeight: FontWeight.bold,
          )),
      TextFormField(
        controller: name,
        decoration: const InputDecoration(labelText: 'Hospital Name'),
      ),
      SizedBox(height: 20),
      TextFormField(
        controller: address,
        decoration: const InputDecoration(labelText: 'Address'),
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Select Country'),
          CountryPicker(
            dense: false,
            showFlag: true, //displays flag, true by default

            showDialingCode: false, //displays dialing code, false by default
            showName: true, //eg. 'GBP'
            onChanged: (Country country) {
              setState(() {
                _selected = country;
                _country=_selected.name;
              });
            },
            dialingCodeTextStyle: TextStyle(
              fontSize: (18),
            ),
            nameTextStyle: TextStyle(
              fontSize: (18),
            ),
            selectedCountry: _selected,
          ),
        ],
      ),
      SizedBox(height: 20),
      Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Feedback',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      color: Colors.grey),
                ),
              ],
            ),
            RaisedButton(
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                nextPage(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Theme.of(context).accentColor,
              child: Container(
                margin: EdgeInsets.only(
                    left: 45.0, right: 45.0, top: 12, bottom: 12),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  Column formOneBuilder(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(top: 12.0, right: 12.0, left: 12.0, bottom: 12.0),
          alignment: Alignment.topLeft,
          child: Text(
            'Select Departments:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.0,
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              CheckboxListTile(
                title: Text("Waiting Room"),
                value: wchecked,
                onChanged: (bool value) {
                  setState(() {
                    wchecked = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Doctors"),
                value: dchecked,
                onChanged: (bool value) {
                  setState(() {
                    dchecked = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("PharmaHub"),
                value: pchecked,
                onChanged: (bool value) {
                  setState(() {
                    pchecked = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("ScaniT"),
                value: ichecked,
                onChanged: (bool value) {
                  setState(() {
                    ichecked = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("TheLab"),
                value: lchecked,
                onChanged: (bool value) {
                  setState(() {
                    lchecked = value;
                  });
                },
              ),
            ],
          ),
        ),
        
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  nextPage(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Colors.grey.withOpacity(0.6),
                child: Container(
                  margin: EdgeInsets.only(
                      left: 45.0, right: 45.0, top: 12, bottom: 12),
                  child: Text(
                    'Previous',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              load
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      elevation: 0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () async {
                        hospitalDept.clear();
                        HospitalDepartment doctors = HospitalDepartment.add(
                            'Doctors',
                            dchecked,
                            'images/nurse-grey.png',
                            'Doctors Category');
                        HospitalDepartment wroom = HospitalDepartment.add(
                            'Waiting Room',
                            wchecked,
                            'images/pulse.png',
                            'Departments');
                        HospitalDepartment pharmacy = HospitalDepartment.add(
                            'Pharmacy',
                            pchecked,
                            'images/pill-grey.png',
                            'Pharmacies');
                        HospitalDepartment lab = HospitalDepartment.add('Lab',
                            lchecked, 'images/TheLab-grey.png', 'Laboratories');
                        HospitalDepartment scan = HospitalDepartment.add(
                            'Scan',
                            ichecked,
                            'images/microscope-grey.png',
                            'Imaging Centres');
                        HospitalDepartment custom1 =
                            HospitalDepartment.add(other1.text, true, '', '');
                        HospitalDepartment custom2 =
                            HospitalDepartment.add(other2.text, true, '', '');
                        if (other1.text.isNotEmpty) {
                          hospitalDept.add(custom1);
                        }
                        if (other2.text.isNotEmpty) {
                          hospitalDept.add(custom2);
                        }
                        if (wroom.isSelected) hospitalDept.add(wroom);
                        if (doctors.isSelected) hospitalDept.add(doctors);
                        if (pharmacy.isSelected) hospitalDept.add(pharmacy);
                        if (lab.isSelected) hospitalDept.add(lab);
                        if (scan.isSelected) hospitalDept.add(scan);

                        _hospitalId =
                            await _registerHospital(name.text, hospitalsId);
                        depts.add(_hospitalId);
                        await _registerHospitalDept(hospitalDept, _hospitalId);

                        // await _putResponsible(depts, id);
                        await _registerHospitalCompany(
                            name.text, address.text, country.text, _hospitalId);
                        AddDpt addDpt = AddDpt(responses, hospitalDept);

                        Navigator.of(context)
                            .pushNamed('/addDepart', arguments: addDpt);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Theme.of(context).accentColor,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 45.0, right: 45.0, top: 12, bottom: 12),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
        
      ],
    );
  }

  Column formTwoBuilder(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('add employees'),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Theme.of(context).accentColor,
                  child: Text('Previous'),
                  onPressed: () {
                    nextPage(context);
                  },
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Theme.of(context).accentColor,
                  child: Text('Save'),
                  onPressed: () async {
                    _hospitalId =
                        await _registerHospital(name.text, hospitalsId);
                    _registerHospitalDept(hospitalDept, _hospitalId);

                    hospitalDept.clear();
                    Navigator.of(context).pushNamed(
                      '/home',
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_stepNumber) {
      case 1:
        return Form(
          key: _formKey,
          child: this.formBuilder(context),
        );
        break;

      case 2:
        return Form(
          key: _formKey,
          child: this.formOneBuilder(context),
        );
        break;
      case 3:
        return Form(
          key: _formKey,
          child: this.formTwoBuilder(context),
        );
        break;
    }
  }

  Future<int> _registerHospital(String name, int id) async {
    setState(() {
      load = true;
    });
    int result = 0;
    final http.Response response = await http
        .post('${webhook}department.add',
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"NAME": name, "PARENT": id}))
        .catchError((error) => print('///////////////////////error' + error));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      result = responseBody['result'];
      print("//////////contact" + result.toString());
    } else {
      print(response.statusCode);
    }

    return result;
  }

  Future<int> _registerHospitalDept(
      List<HospitalDepartment> list, int id) async {
    setState(() {
      load = true;
    });
    print(list.length.toString());
    int result = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].isSelected) {
        final http.Response response = await http
            .post('${webhook}department.add',
                headers: {"Content-Type": "application/json"},
                body: jsonEncode({"NAME": list[i].name, "PARENT": id}))
            .catchError(
                (error) => print('///////////////////////error' + error));
        if (response.statusCode == 200) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          result = responseBody['result'];
          print("//////////id" + result.toString());
          depts.add(result);
          responses.add(result);
        } else {
          print(response.statusCode);
        }
      }
    }
    return result;
  }

  Future<int> _registerHospitalCompany(
      String name, String address, String country, int id) async {
    setState(() {
      load = true;
    });
    int result = 0;
    final http.Response response = await http
        .post('${webhook}crm.company.add',
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "fields": {
                "TITLE": name,
                "ADDRESS": address,
                "ADDRESS_COUNTRY": country,
                "COMPANY_TYPE": "CUSTOMER",
                "INDUSTRY": "MANUFACTURING",
                "EMPLOYEES": "EMPLOYEES_2",
                "CURRENCY_ID": "GBP",
                "REVENUE": 3000000,
                "OPENED": "Y",
                "ASSIGNED_BY_ID": id
              }
            }))
        .catchError((error) => print('///////////////////////error' + error));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      result = responseBody['result'];
      print("//////////company" + result.toString());
    } else {
      print(response.statusCode);
    }
    print(result);
    return result;
  }

  Future<bool> _putResponsible(List dept, int id) async {
    setState(() {
      load = true;
    });
    bool result = false;
    final http.Response response = await http
        .post('${webhook}user.update',
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"ID": id, "UF_DEPARTMENT": dept}))
        .catchError((error) => print('///////////////////////error' + error));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      print("//////////update" + responseBody['result'].toString());
    } else {
      print(response.statusCode);
    }
    print(result);
    return result;
  }

  void dispose() {
    other1.dispose();
    other2.dispose();
    name.dispose();
    address.dispose();
    country.dispose();

    super.dispose();
  }
}
