import 'package:digitAT/config/app_config.dart' as config;
import 'package:digitAT/pages/Welcome.dart';
import 'package:digitAT/pages/tabs.dart';
import 'package:digitAT/pages/verification_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:digitAT/routes_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:starflut/starflut.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name,city,phone,vId,_platformVersion="Unknown";
  int id;
getId()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.getInt("id");
}
fetchId()async{
  id= await getId();
  
}
 Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      int TestCase = 8;  //7 -- lua //6 -- go //---5 ruby  //---4 ios //--3 call back;  //--2  call python //--1 android api //--0 develop

      if (TestCase == 0) {
        StarCoreFactory starcore = await Starflut.getFactory();
        int Result = 0;
        Result =
            await starcore.initCore(true, false, false, true, "", 0, "", 0);
        await starcore.regMsgCallBackP(
            (int serviceGroupID, int uMsg, Object wParam, Object lParam) async{
          print("platform $serviceGroupID  $uMsg   $wParam   $lParam");
          return null;
        });
        //StarSrvGroupClass StarSrvGroup = await starcore.getSrvGroup(0);
        //print("$Result");
        //StarSrvGroupClass StarSrvGroup = await starcore.initSimpleEx(0, 0, []);
        StarServiceClass StarService =
            await starcore.initSimple("test", "123", 0, 0, []);
        StarSrvGroupClass StarSrvGroup = await StarService["_ServiceGroup"];
        print("starsrvgroup = " + await StarSrvGroup.getString());

        print("$Result");
        var lang = await starcore.getLocale();
        print("$lang");

        var ver = await starcore.version();
        print("$ver");

        var hand = await starcore.coreHandle();
        print("$hand");

        StarParaPkgClass ParaPkg = await StarSrvGroup.newParaPkg([
          'aaaa',
          234,
          [345]
        ]);
        var isp = StarSrvGroup.isParaPkg(ParaPkg);
        print("$isp");

        print("parapkg " + await ParaPkg[0]);
        print(await ParaPkg[1]);

        await ParaPkg.setValue(0, '22222222');
        print("parapkg new value =" + await ParaPkg[0]);

        await ParaPkg.setValue(1, ['22222222']);

        print(await ParaPkg.toTuple());

        //--map
        StarParaPkgClass ParaPkg1 = await StarSrvGroup.newParaPkg({"a":1, "b":2, "c":3});
        print(await ParaPkg1[0]);
        print(await ParaPkg1.toTuple());

        StarParaPkgClass ParaPkg2 = await StarSrvGroup.newParaPkg([345.67,{"a":1, "b":2, "c":3}]);
        print(await ParaPkg2[1]);
        print(await ParaPkg2.toTuple());

        await ParaPkg1.build([345.67,{"a":1, "b":2, "c":3}]);
        print(await ParaPkg1.toTuple());

        await ParaPkg1.build({"a":1, "b":2, "c":3});
        print(await ParaPkg1.toTuple());
      

        var srvp = await StarSrvGroup.getServicePath();
        print("$srvp");

        var curp = await StarSrvGroup.getCurrentPath();
        print("$curp");

        /*---script python--*/
        bool isAndroid = await Starflut.isAndroid();
        if( isAndroid == true ){
          var py_result1 =
            await Starflut.copyFileFromAssets("python3.6.zip", "flutter_assets/starfiles",null);   //desRelatePath must be null
          print("$py_result1");
          py_result1 =
              await Starflut.copyFileFromAssets("zlib.cpython-36m.so", null,null);
          print("$py_result1");
          py_result1 = await Starflut.copyFileFromAssets(
            "unicodedata.cpython-36m.so", null,null);
          print("$py_result1");

          py_result1 = await Starflut.loadLibrary("libpython3.6m.so");
           print("$py_result1");
        }

        bool run_result =
            await StarSrvGroup.runScript("python36", "print(123)", "");
        print("$run_result");

        //---moduleExit run before runScript, so will cause exception,
        //---moduleExit should be run on mainthread.
        await starcore.moduleExit();
      }else if (TestCase == 1) {
        StarCoreFactory starcore = await Starflut.getFactory();
        StarServiceClass Service = await starcore.initSimple("test", "123", 0, 0, []);
        await starcore.regMsgCallBackP(
            (int serviceGroupID, int uMsg, Object wParam, Object lParam) async{
          print("$serviceGroupID  $uMsg   $wParam   $lParam");
          return null;
        });
        StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];
        await SrvGroup.initRaw("java",Service); 
        var Android_Build = await Service.importRawContext("java","android.os.Build",false,""); 
        print("Android_Build = "+ await Android_Build.getString());
        StarObjectClass VERSION = await Android_Build["VERSION"];  
        print("$VERSION = ");
        var c_acti = await Starflut.getActivity(Service);
        print("Activity = "+await c_acti.getString());
        
        dynamic obj1 = await c_acti.call("getApplicationContext",[]);
        print("getApplicationContext = $obj1");
        print("getApplicationContext = "+ await obj1.getString());

        dynamic Android_Context = await Service.importRawContext("java","android.content.Context",false,""); 
        dynamic TELEPHONY_SERVICE = await Android_Context['TELEPHONY_SERVICE'];
        print("TELEPHONY_SERVICE = $TELEPHONY_SERVICE ");

        dynamic obj2 = await obj1.call("getPackageManager",[]);
        print("getPackageManager = "+ await obj2.getString());

        dynamic obj3 = await obj2["FEATURE_CAMERA"];
        print("FEATURE_CAMERA = $obj3");

        dynamic Android_PackageManager = await Service.importRawContext("java","android.content.pm.PackageManager",false,"");
        print("Android_PackageManager = "+ await Android_PackageManager.getString());

        dynamic obj4 = await Android_PackageManager["FEATURE_CAMERA"];
        print("FEATURE_CAMERA = $obj4");        

      }else if (TestCase == 2) {
        StarCoreFactory starcore = await Starflut.getFactory();
        StarServiceClass Service = await starcore.initSimple("test", "123", 0, 0, []);
        await starcore.regMsgCallBackP(
            (int serviceGroupID, int uMsg, Object wParam, Object lParam) async{
          print("$serviceGroupID  $uMsg   $wParam   $lParam");
          return null;
        });
        StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];

        /*---script python--*/
        bool isAndroid = await Starflut.isAndroid();
        if( isAndroid == true ){
          await Starflut.copyFileFromAssets("testcallback.py", "flutter_assets/starfiles","flutter_assets/starfiles");
          await Starflut.copyFileFromAssets("testpy.py", "flutter_assets/starfiles","flutter_assets/starfiles");
          await Starflut.copyFileFromAssets("python3.6.zip", "flutter_assets/starfiles",null);  //desRelatePath must be null 
          await Starflut.copyFileFromAssets("zlib.cpython-36m.so", null,null);
          await Starflut.copyFileFromAssets("unicodedata.cpython-36m.so", null,null);
          await Starflut.loadLibrary("libpython3.6m.so");
        }

        String docPath = await Starflut.getDocumentPath();
        print("docPath = $docPath");

        String resPath = await Starflut.getResourcePath();
        print("resPath = $resPath");

        dynamic rr1 = await SrvGroup.initRaw("python36", Service);

        print("initRaw = $rr1");
		    var Result = await SrvGroup.loadRawModule("python", "", resPath + "/flutter_assets/starfiles/" + "testpy.py", false);
        print("loadRawModule = $Result");

		    dynamic python = await Service.importRawContext("python", "", false, "");
        print("python = "+ await python.getString());

		    StarObjectClass retobj = await python.call("tt", ["hello ", "world"]);
        print(await retobj[0]);
        print(await retobj[1]);

        print(await python["g1"]);
        
        StarObjectClass yy = await python.call("yy", ["hello ", "world", 123]);
        print("result ---------------"+ await yy.call("__len__",[]));

        StarObjectClass multiply = await Service.importRawContext("python", "Multiply", true, "");
        StarObjectClass multiply_inst = await multiply.newObject(["", "", 33, 44]);
        print(await multiply_inst.getString());

        print(await multiply_inst.call("multiply", [11, 22]));

        await SrvGroup.clearService();
		    await starcore.moduleExit();

      }else if (TestCase == 3) {      
        StarCoreFactory starcore = await Starflut.getFactory();
        
        Starflut.pushLocalFrame();

        StarServiceClass Service = await starcore.initSimple("test", "123", 0, 0, []);
        await starcore.regMsgCallBackP(
            (int serviceGroupID, int uMsg, Object wParam, Object lParam) async{
          print("$serviceGroupID  $uMsg   $wParam   $lParam");
          return null;
        });
        StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];

        /*---script python--*/
        bool isAndroid = await Starflut.isAndroid();
        if( isAndroid == true ){
          await Starflut.copyFileFromAssets("testcallback.py", "flutter_assets/starfiles","flutter_assets/starfiles");
          await Starflut.copyFileFromAssets("testpy.py", "flutter_assets/starfiles","flutter_assets/starfiles");
          await Starflut.copyFileFromAssets("python3.6.zip", "flutter_assets/starfiles",null);   //desRelatePath must be null
          await Starflut.copyFileFromAssets("zlib.cpython-36m.so", null,null);
          await Starflut.copyFileFromAssets("unicodedata.cpython-36m.so", null,null);
          await Starflut.loadLibrary("libpython3.6m.so");
        }

        String docPath = await Starflut.getDocumentPath();
        print("docPath = $docPath");

        String resPath = await Starflut.getResourcePath();
        print("resPath = $resPath");

        print("begin init Raw)");
        bool rr1 = await SrvGroup.initRaw("python36", Service);
        print("initRaw = $rr1");

		    StarObjectClass python = await Service.importRawContext("python", "", false, "");
        
        python.lock();

        print(await python.getValue(["_Service","_Class","_ID","_Name"]));

        print("python = "+ await python.getString());

		    await SrvGroup.doFile("python", resPath + "/flutter_assets/starfiles/" + "testcallback.py");

		    StarObjectClass CallBackObj = await Service.newObject([]);
		    await python.setValue("CallBackObj", CallBackObj);

		    await CallBackObj.regScriptProcP("PrintHello", (StarObjectClass cleObject, List paras ) async {
			    print("$paras");
			    return ["return from go", {"pa":1, "pb":2, "pc":3},345.4];
		      });
        
        /*
        StarObjectClass retobj = await python.call("tt", ["hello ", "world"]);
        print("retobj  = $retobj");
        */

        Starflut.popLocalFrame();

        var rrr = await python.call("tt", [{"a":1, "b":2, "c":3}, "world"]);
        print("return from python $rrr");

       }else if (TestCase == 4) {
         StarCoreFactory starcore = await Starflut.getFactory();
         int Result = 0;
        /*Result =
            await starcore.initCore(true, false, false, true, "", 0, "", 0);
            */
        StarServiceClass Service = await starcore.initSimple("test", "123", 0, 0, []);
        print("$Service");
        await starcore.regMsgCallBackP(
            (int serviceGroupID, int uMsg, Object wParam, Object lParam) async{
          print("$serviceGroupID  $uMsg   $wParam   $lParam");
          return null;
        });
        StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];
        print("$SrvGroup");

        print(await SrvGroup.activeScriptInterface("ruby"));
        print(await Service.runScript("python36","print(123)",null,null));
        print("+++++++++++++++++++++++");

        var srvp = await SrvGroup.getServicePath();
        print("$srvp");

        var curp = await SrvGroup.getCurrentPath();
        print("$curp");

        List<int> listB = [1, 2, 3, 4, 5];
        List<String> numbersB = ['one', 'two', 'three', 'four'];
        Map<String, int> map = {"a":1, "b":2, "c":3};

        StarParaPkgClass ParaPkg = await SrvGroup.newParaPkg([
          34359738367,
          'aaaa',
          234,
          false,
          [345,345],
          listB,
          numbersB,
          map
        ]);
        print(await ParaPkg.getValue([1,4,5]));

        print(await ParaPkg.toTuple());

        StarParaPkgClass ParaPkg1 = await SrvGroup.newParaPkg([map]);

        StarBinBufClass BinBuf = await SrvGroup.newBinBuf();
        print(await BinBuf.read(0,100));
        
        String docPath = await Starflut.getDocumentPath();
        print("docPath = $docPath");

        /*---script python--*/
        bool isAndroid = await Starflut.isAndroid();
        if( isAndroid == true ){
          await Starflut.copyFileFromAssets("testcallback.py", "flutter_assets/starfiles","flutter_assets/starfiles");
          await Starflut.copyFileFromAssets("testpy.py", "flutter_assets/starfiles","flutter_assets/starfiles");
          await Starflut.copyFileFromAssets("python3.6.zip", "flutter_assets/starfiles",null);  //desRelatePath must be null 
          await Starflut.copyFileFromAssets("zlib.cpython-36m.so", null,null);
          await Starflut.copyFileFromAssets("unicodedata.cpython-36m.so", null,null);
          await Starflut.loadLibrary("libpython3.6m.so");
        }

        print("begin init Raw)");
        bool rr1 = await SrvGroup.initRaw("python36", Service);
        print("initRaw = $rr1");

		    StarObjectClass python = await Service.importRawContext("python", "", false, "");
        print(await python.getString());

        bool run_result =
            await SrvGroup.runScript("python", "print(123)", "");
        print("$run_result");

/*
        run_result =
            await SrvGroup.runScript("ruby", "puts(123)", "");
        print("ruby == $run_result");
*/        
        
        python.lock();

        print(await python.getValue(["_Service","_Class","_ID","_Name"]));

        print("python = "+ await python.getString());

        String resPath = await Starflut.getResourcePath();
        print("resPath = $resPath");

        await SrvGroup.doFile("python", resPath + "/flutter_assets/starfiles/" + "testcallback.py");

		    StarObjectClass CallBackObj = await Service.newObject([]);
		    await python.setValue("CallBackObj", CallBackObj);

		    await CallBackObj.regScriptProcP("PrintHello", (StarObjectClass cleObject, List paras ) async {
			    print("$paras");
			    return ["return from go", 345.4];
		      });
         await python.call("tt", ["hello ", "world"]);

      }else if (TestCase == 5) {
        StarCoreFactory starcore = await Starflut.getFactory();
        StarServiceClass Service = await starcore.initSimple("test", "123", 0, 0, []);
        print("$Service");
        await starcore.regMsgCallBackP(
            (int serviceGroupID, int uMsg, Object wParam, Object lParam) async{
          print("$serviceGroupID  $uMsg   $wParam   $lParam");
          return null;
        });
        StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];
        print("$SrvGroup");

        String docPath = await Starflut.getDocumentPath();
        print("docPath = $docPath");

        String resPath = await Starflut.getResourcePath();
        print("resPath = $resPath");

        await SrvGroup.initRaw("ruby",Service);
		    StarObjectClass ruby = await Service.importRawContext("ruby","",false,"");
		    print(await ruby["LOAD_PATH"]);
		    print(await ruby["File"]);
    
		    StarObjectClass loadPATH = await ruby["LOAD_PATH"];
		    print(loadPATH);
		    await loadPATH.call("unshift", [docPath]);

        bool isAndroid = await Starflut.isAndroid();
        if( isAndroid == true ){
          await Starflut.copyFileFromAssets("testcallback.rb", "flutter_assets/starfiles","flutter_assets/starfiles");
          await Starflut.loadLibrary("libruby.so");
        }
 
        await SrvGroup.doFile("ruby", resPath + "/flutter_assets/starfiles/" + "testcallback.rb");

        var srvp = await SrvGroup.getServicePath();
        print("$srvp");   

        print(await ruby["\$g1"]);
        print("\$g1");

        StarObjectClass CallBackObj = await Service.newObject([]);
		    await ruby.setValue("\$CallBackObj", CallBackObj);

		    await CallBackObj.regScriptProcP("PrintHello", (StarObjectClass cleObject, List paras ) async {
			    print("$paras");
			    return ["return from go", {"pa":1, "pb":2, "pc":3},345.4];
		      });
          
        StarObjectClass rrr = await ruby.call("tt", [{"a":1, "b":2, "c":3}, "world"]);
        print("return from ruby $rrr");

        var rw = await rrr.rawToParaPkg();
        print(rw);
      }else if (TestCase == 6) {
        StarCoreFactory starcore = await Starflut.getFactory();
        StarServiceClass Service = await starcore.initSimple("test", "123", 0, 0, []);
        print("$Service");
        await starcore.regMsgCallBackP(
            (int serviceGroupID, int uMsg, Object wParam, Object lParam) async{
          print("$serviceGroupID  $uMsg   $wParam   $lParam");
          return null;
        });
        await Service.checkPassword(false);
        StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];
        print("$SrvGroup");

        String docPath = await Starflut.getDocumentPath();
        print("docPath = $docPath");

        String resPath = await Starflut.getResourcePath();
        print("resPath = $resPath");

        print(await Service.doFile("","libstar_go.dynlib",""));
        var goObj = await Service.getObject("GoObject"); 
        print(goObj);

        print("--------------"); 
        
        var result = await goObj.call("PrintHello",["------------1",234.56]);
        print(result);

        print("----call lua---");
        await SrvGroup.initRaw("lua",Service);
        StarObjectClass lua = await Service.importRawContext("lua","",false,"");  
        print(await lua.getString());

        StarObjectClass luapackage = await lua["package"];
        String luapath = await luapackage["path"];
        print(luapath);

        bool isAndroid = await Starflut.isAndroid();
        if( isAndroid == true ){
          await Starflut.copyFileFromAssets("mymath.lua", "flutter_assets/starfiles","flutter_assets/starfiles");
        }

        await luapackage.setValue("path",luapath + ";$resPath/flutter_assets/starfiles/?.lua");
        print(await luapackage["path"]);
        await lua.call("execute",['mymath=require \"mymath\"']);

        StarObjectClass mymath = await lua["mymath"];
        print(await mymath.call("add",[3334,5666]));

      }else if (TestCase == 7) {
        StarCoreFactory starcore = await Starflut.getFactory();
        StarServiceClass Service = await starcore.initSimple("test", "123", 0, 0, []);
        print("$Service");
        await starcore.regMsgCallBackP(
            (int serviceGroupID, int uMsg, Object wParam, Object lParam) async{
          print("$serviceGroupID  $uMsg   $wParam   $lParam");
          return null;
        });
        await Service.checkPassword(false);
        StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];
        print("$SrvGroup");

        String docPath = await Starflut.getDocumentPath();
        print("docPath = $docPath");

        String resPath = await Starflut.getResourcePath();
        print("resPath = $resPath");

        print("----call lua---");
        await SrvGroup.initRaw("lua",Service);
        StarObjectClass lua = await Service.importRawContext("lua","",false,"");  
        print(await lua.getString());

        StarObjectClass luapackage = await lua["package"];
        String luapath = await luapackage["path"];
        print(luapath);

        bool isAndroid = await Starflut.isAndroid();
        if( isAndroid == true ){
          await Starflut.copyFileFromAssets("mymath.lua", "flutter_assets/starfiles","flutter_assets/starfiles");
        }

        await luapackage.setValue("path",luapath + ";$resPath/flutter_assets/starfiles/?.lua");
        print(await luapackage["path"]);
        await lua.call("execute",['mymath=require \"mymath\"']);

        StarObjectClass mymath = await lua["mymath"];
        print(await mymath.call("add",[3334,5666]));

      }else if (TestCase == 8) {
          StarCoreFactory starcore = await Starflut.getFactory();
    StarServiceClass service = await starcore.initSimple("test", "123", 0, 0, []);
     StarSrvGroupClass srvGroup = await service["_ServiceGroup"];
    bool isAndroid = await Starflut.isAndroid();
    if (isAndroid == true) {
        String libraryDir = await Starflut.getNativeLibraryDir();
        String docPath = await Starflut.getDocumentPath();
        if (libraryDir.indexOf("arm64") > 0) {
            Starflut.unzipFromAssets("lib-dynload-arm64.zip", docPath, true);
        } else if (libraryDir.indexOf("x86_64") > 0) {
            Starflut.unzipFromAssets("lib-dynload-x86_64.zip", docPath, true);
        } else if (libraryDir.indexOf("arm") > 0) {
            Starflut.unzipFromAssets("lib-dynload-armeabi.zip", docPath, true);
        } else {
            Starflut.unzipFromAssets("lib-dynload-x86.zip", docPath, true);
        }
        await Starflut.copyFileFromAssets("python3.6.zip",
            "flutter_assets/starfiles", null);
    }
    await srvGroup.initRaw("python36", service);

    String resPath = await Starflut.getResourcePath();
    srvGroup.loadRawModule("python", "",
        resPath + "/flutter_assets/starfiles/" + "testpy.py", false);

    dynamic python = await service.importRawContext("python", "", false, "");

    StarObjectClass retobj = await python.call("tt", ["hello ", "world"]);
    print(await retobj[0]);
    print(await retobj[1]);

    print(await python["g1"]);

    StarObjectClass yy = await python.call("yy", ["hello ", "world", 123]);
    print(await yy.call("__len__",[]));

    StarObjectClass multiply = await service.importRawContext("python", "Multiply", true, "");
    StarObjectClass multiply_inst = await multiply.newObject(["", "", 33, 44]);
    print(await multiply_inst.getString());

    print(await multiply_inst.call("multiply", [11, 22]));

    await srvGroup.clearService();
    await starcore.moduleExit();
      }
    } on PlatformException catch (e) {
      print("{$e.message}");
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

 @override
  void initState()  {
    // TODO: implement initState
    super.initState();
 initPlatformState();
 
   SharedPreferences.getInstance().then((SharedPreferences sp) {
      String _name,_city,_phone,_vId;
      int _testValue;
      _testValue = sp.getInt('id');
      _name = sp.getString('name');
      _city = sp.getString('city');
      _phone = sp.getString('phone');
      _vId = sp.getString('vId');

      // will be null if never previously saved
      if (_testValue == null ) {
        _testValue = null;
       
         // set an initial value
      }
      if (_vId == null ) {
        _vId = null;
       
         // set an initial value
      }
      setState(() {
        id=_testValue;
        name=_name;
        city=_city;
        phone=_phone;
        vId=_vId;

      });
    
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
           debugShowCheckedModeBanner: false,
          home: Scaffold(
            body:SplashScreen(

              imageBackground: AssetImage('images/splash.jpg'),
            seconds: 3,
          navigateAfterSeconds: new AfterSplash([id,name,city,phone,vId]),
    
      
        
          backgroundColor:Hexcolor('#1DA1F2').withOpacity(0.8),
       
          photoSize: 100.0,
      
          loaderColor:Hexcolor('#1DA1F2'),
        ),
      ),
    );
  }


}

class AfterSplash extends StatelessWidget {
 const AfterSplash(this.id);
 final List<dynamic> id;
 
  @override
  Widget build(BuildContext context) {
    print(id[1]);
    return MaterialApp(
      title: 'digitAT',
      home:id[0]==null?Welcome():TabsWidget(acountInfos: [id[1],id[0],id[2]]),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color(0xFF252525),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        accentColor: config.Colors().mainDarkColor(1),
        hintColor: config.Colors().secondDarkColor(1),
        focusColor: config.Colors().accentDarkColor(1),
        textTheme: TextTheme(
          button: TextStyle(color: Color(0xFF252525)),
          headline: TextStyle(fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
          display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainDarkColor(1)),
          display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondDarkColor(1)),
          subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
          title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainDarkColor(1)),
          body1: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
          body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        accentColor: config.Colors().mainColor(1),
        focusColor: config.Colors().accentColor(1),
        hintColor: config.Colors().secondColor(1),
        textTheme: TextTheme(
          button: TextStyle(color: Theme.of(context).primaryColor),
          headline: TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
          display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainColor(1)),
          display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1)),
          subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondColor(1)),
          title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainColor(1)),
          body1: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
          body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(0.6)),
        ),
      ),
    );
  }
}
