import 'dart:async';
import 'dart:convert';
import 'package:attendancewithfingerprint/database/db_helper.dart';
import 'package:attendancewithfingerprint/model/settings.dart';
import 'package:attendancewithfingerprint/screen/login_page.dart';
// import 'package:attendancewithfingerprint/screen/login_page.dart';
import 'package:attendancewithfingerprint/screen/main_menu_page.dart';
import 'package:attendancewithfingerprint/utils/strings.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../utils/utils.dart';
// import 'attendance_page.dart';

class ScanQrPage extends StatefulWidget {
  @override
  _ScanQrPageState createState() => new _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  DbHelper dbHelper = DbHelper();
  Utils utils = Utils();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _barcode = "";
  Settings settings;
  String _isAlreadyDoSettings = 'loading';

  Future scan() async {
    try {
      print("in try");
      var barcode = await BarcodeScanner.scan();
      // The value of Qr Code
      // Return the json data
      // We need replaceAll because Json from web use single-quote ({' '}) not double-quote ({" "})
      final newJsonData = barcode.rawContent;
      final data = json.decode(json.encode(newJsonData));
      print("hari");
      print(data);
      print("npnn");
      // Check the type of barcode
      if (data != null) {
        print("npn");
        // Decode the json data form QR
        // String getUrl = int.parse(data['url']) as String;
        // String getKey = int.parse(data['key']) as String;

        // Set the url and key
        settings = Settings(url: data.indexOf('url').toString(), key: data.indexOf('key').toString());
        // print(settings);
        // Insert the settings
        insertSettings(settings);
      } else {
        print("android");
        utils.showAlertDialog(format_barcode_wrong, "Error", AlertType.error,
            _scaffoldKey, false);
      }
    } on PlatformException catch (e) {
      setState(() {
        _isAlreadyDoSettings = 'no';
      });
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        _barcode = barcode_permission_cam_close;
        utils.showAlertDialog(
            _barcode, "Warning", AlertType.warning, _scaffoldKey, false);
      } else {
        _barcode = '$barcode_unknown_error $e';
        utils.showAlertDialog(
            _barcode, "Error", AlertType.error, _scaffoldKey, false);
      }
    } catch (e) {
      _barcode = '$barcode_unknown_error : $e';
      print(_barcode);
    }
  }

  // Insert the URL and KEY
  insertSettings(Settings object) async {
    await dbHelper.newSettings(object);
    setState(() {
      _isAlreadyDoSettings = 'yes';
      goToLoginPage();
    });
  }

  getSettings() async {
    var checking = await dbHelper.countSettings();
    setState(() {
      checking > 0 ? _isAlreadyDoSettings = 'yes' : _isAlreadyDoSettings = 'no';
      goToLoginPage();
    });
  }

  // Init for the first time
  @override
  void initState() {
    super.initState();
    splashScreen();
  }

  // Show splash scree with time duration
  splashScreen() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, () {
      getSettings();
    });
  }

  // Got to main menu after scanning the QR or if user scanned the QR.
  goToLoginPage() {
    if (_isAlreadyDoSettings == 'yes') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if user already do settings
    if (_isAlreadyDoSettings == 'no') {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xff3f6ae0),
          key: _scaffoldKey,
          body: Container(
            margin: EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('images/logo.png'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  setting_welcome_title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  setting_desc,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[300]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40.0,
                ),
                RaisedButton(
                  child: Text(button_scan),
                  color: Color(0xFFf7c846),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  textColor: Colors.black,
                  onPressed: () => scan(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      color: Colors.blue,
      child: Center(
        child: Image(
          image: AssetImage('images/logo.png'),
        ),
      ),
    );
  }
}
