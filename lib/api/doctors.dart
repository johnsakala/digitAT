import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:digitAT/api/server_response.dart';


class DepartmentUsers {
  List<Result> result;

  DepartmentUsers({this.result});

  DepartmentUsers.fromJson(Map<String, dynamic> json) {
    if (json["result"] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        print("Processing someone\n");
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String iD;
  bool aCTIVE;
  String eMAIL;
  String nAME;
  String lASTNAME;
  String sECONDNAME;
  String pERSONALGENDER;
  String pERSONALPROFESSION;
  String pERSONALWWW;
  String pERSONALBIRTHDAY;
  String pERSONALPHOTO="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU";
  Null pERSONALICQ;
  Null pERSONALPHONE;
  Null pERSONALFAX;
  String pERSONALMOBILE;
  Null pERSONALPAGER;
  Null pERSONALSTREET;
  String pERSONALCITY;
  Null pERSONALSTATE;
  Null pERSONALZIP;
  Null pERSONALCOUNTRY;
  Null wORKCOMPANY;
  String wORKPOSITION;
  String wORKPHONE;
  List<int> uFDEPARTMENT;
  Null uFINTERESTS;
  Null uFSKILLS;
  Null uFWEBSITES;
  Null uFXING;
  Null uFLINKEDIN;
  Null uFFACEBOOK;
  Null uFTWITTER;
  Null uFSKYPE;
  Null uFDISTRICT;
  String uFPHONEINNER;
  String uSERTYPE;
   Result.init();
  Result(
      {this.iD,
        this.aCTIVE,
        this.eMAIL,
        this.nAME,
        this.lASTNAME,
        this.sECONDNAME,
        this.pERSONALGENDER,
        this.pERSONALPROFESSION,
        this.pERSONALWWW,
        this.pERSONALBIRTHDAY,
        this.pERSONALPHOTO,
        this.pERSONALICQ,
        this.pERSONALPHONE,
        this.pERSONALFAX,
        this.pERSONALMOBILE,
        this.pERSONALPAGER,
        this.pERSONALSTREET,
        this.pERSONALCITY,
        this.pERSONALSTATE,
        this.pERSONALZIP,
        this.pERSONALCOUNTRY,
        this.wORKCOMPANY,
        this.wORKPOSITION,
        this.wORKPHONE,
        this.uFDEPARTMENT,
        this.uFINTERESTS,
        this.uFSKILLS,
        this.uFWEBSITES,
        this.uFXING,
        this.uFLINKEDIN,
        this.uFFACEBOOK,
        this.uFTWITTER,
        this.uFSKYPE,
        this.uFDISTRICT,
        this.uFPHONEINNER,
        this.uSERTYPE});

  Result.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    aCTIVE = json['ACTIVE'];
    eMAIL = json['EMAIL'];
    nAME = json['NAME'];
    lASTNAME = json['LAST_NAME'];
    sECONDNAME = json['SECOND_NAME'];
    pERSONALGENDER = json['PERSONAL_GENDER'];
    pERSONALPROFESSION = json['PERSONAL_PROFESSION'];
    pERSONALWWW = json['PERSONAL_WWW']??"";
    pERSONALBIRTHDAY = json['PERSONAL_BIRTHDAY'];
    if(pERSONALPHOTO.isEmpty || pERSONALPHOTO==null){
      pERSONALPHOTO="images/asset-1.png";
    }else{
      pERSONALPHOTO = json['PERSONAL_PHOTO'];
    }
    pERSONALICQ = json['PERSONAL_ICQ'];
    pERSONALPHONE = json['PERSONAL_PHONE'];
    pERSONALFAX = json['PERSONAL_FAX'];
    pERSONALMOBILE = json['PERSONAL_MOBILE'];
    pERSONALPAGER = json['PERSONAL_PAGER'];
    pERSONALSTREET = json['PERSONAL_STREET'];
    pERSONALCITY = json['PERSONAL_CITY'];
    pERSONALSTATE = json['PERSONAL_STATE'];
    pERSONALZIP = json['PERSONAL_ZIP'];
    pERSONALCOUNTRY = json['PERSONAL_COUNTRY'];
    wORKCOMPANY = json['WORK_COMPANY'];
    wORKPOSITION = json['WORK_POSITION'];
    wORKPHONE = json['WORK_PHONE'];
    uFDEPARTMENT = json['UF_DEPARTMENT'].cast<int>();
    uFINTERESTS = json['UF_INTERESTS'];
    uFSKILLS = json['UF_SKILLS'];
    uFWEBSITES = json['UF_WEB_SITES'];
    uFXING = json['UF_XING'];
    uFLINKEDIN = json['UF_LINKEDIN'];
    uFFACEBOOK = json['UF_FACEBOOK'];
    uFTWITTER = json['UF_TWITTER'];
    uFSKYPE = json['UF_SKYPE'];
    uFDISTRICT = json['UF_DISTRICT'];
    uFPHONEINNER = json['UF_PHONE_INNER'];
    uSERTYPE = json['USER_TYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ACTIVE'] = this.aCTIVE;
    data['EMAIL'] = this.eMAIL;
    data['NAME'] = this.nAME;
    data['LAST_NAME'] = this.lASTNAME;
    data['SECOND_NAME'] = this.sECONDNAME;
    data['PERSONAL_GENDER'] = this.pERSONALGENDER;
    data['PERSONAL_PROFESSION'] = this.pERSONALPROFESSION;
    data['PERSONAL_WWW'] = this.pERSONALWWW;
    data['PERSONAL_BIRTHDAY'] = this.pERSONALBIRTHDAY;
    data['PERSONAL_PHOTO'] = this.pERSONALPHOTO;
    data['PERSONAL_ICQ'] = this.pERSONALICQ;
    data['PERSONAL_PHONE'] = this.pERSONALPHONE;
    data['PERSONAL_FAX'] = this.pERSONALFAX;
    data['PERSONAL_MOBILE'] = this.pERSONALMOBILE;
    data['PERSONAL_PAGER'] = this.pERSONALPAGER;
    data['PERSONAL_STREET'] = this.pERSONALSTREET;
    data['PERSONAL_CITY'] = this.pERSONALCITY;
    data['PERSONAL_STATE'] = this.pERSONALSTATE;
    data['PERSONAL_ZIP'] = this.pERSONALZIP;
    data['PERSONAL_COUNTRY'] = this.pERSONALCOUNTRY;
    data['WORK_COMPANY'] = this.wORKCOMPANY;
    data['WORK_POSITION'] = this.wORKPOSITION;
    data['WORK_PHONE'] = this.wORKPHONE;
    data['UF_DEPARTMENT'] = this.uFDEPARTMENT;
    data['UF_INTERESTS'] = this.uFINTERESTS;
    data['UF_SKILLS'] = this.uFSKILLS;
    data['UF_WEB_SITES'] = this.uFWEBSITES;
    data['UF_XING'] = this.uFXING;
    data['UF_LINKEDIN'] = this.uFLINKEDIN;
    data['UF_FACEBOOK'] = this.uFFACEBOOK;
    data['UF_TWITTER'] = this.uFTWITTER;
    data['UF_SKYPE'] = this.uFSKYPE;
    data['UF_DISTRICT'] = this.uFDISTRICT;
    data['UF_PHONE_INNER'] = this.uFPHONEINNER;
    data['USER_TYPE'] = this.uSERTYPE;
    return data;
  }
}

showAlertDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 10),child:Text("Please Wait\nSigning-in" )),
      ],),
  );
  showDialog(barrierDismissible: true,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}