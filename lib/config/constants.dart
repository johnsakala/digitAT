import 'package:digitAT/models/navigation.dart';

final doctorsId = 30;
final pharmahubId=32;
final scanItId=24;
final scanId=124;
final medId=126;
final labId=26;
final laId=58;
final coId=164;
final hospitalsId=28;
  PageNav pageNav= PageNav.min("PharmaHub", pharmahubId.toString(),"");
  PageNav pageNavScan= PageNav.min("Imaging Centers", scanItId.toString(),"");
  PageNav pageNavLab= PageNav.min("Laboritories", labId.toString(),"");
  PageNav pageNavCov= PageNav.min("Cov-ID", coId.toString(),"");
  PageNav pageNavDoc= PageNav.min("Doctors", doctorsId.toString(),"");
  

 List<int> myDoctors=[];