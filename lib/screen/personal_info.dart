import 'dart:convert';
import 'dart:io';

import 'package:attendancewithfingerprint/screen/scan_qr_page.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';

class P_info extends StatefulWidget {
  const P_info({required Key key}) : super(key: key);

  @override
  _P_info createState() => _P_info();
  static _P_info? of(BuildContext context) => context.findAncestorStateOfType<_P_info>();
}

class _P_info extends State<P_info> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool _validate5 = false;
  bool _validate6 = false;
  bool _validate7 = false;
  bool _validate8 = false;
  bool _validate9 = false;
  // bool _validate10 = false;
  // bool _validate11 = false;
  // bool _validate12 = false;
  // bool _validate13 = false;
  // bool _validate14 = false;
  // bool _validate15 = false;
  // bool _validate16 = false;
  // bool _validate17 = false;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController doorController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController talukController = TextEditingController();
  // TextEditingController districtController = TextEditingController();
  // TextEditingController stateController = TextEditingController();
  // TextEditingController pincodeController = TextEditingController();
  // TextEditingController BankNameController = TextEditingController();
  // TextEditingController BankAccoutNumberController = TextEditingController();
  // TextEditingController IFSCcodeController = TextEditingController();
  // TextEditingController Bank_BranchController = TextEditingController();
  // TextEditingController Bank_Address_PINCodeController = TextEditingController();

  // File seimage;
  // File ceimage;
  // File idproof3;
  // File idproof;
  // File idproof2;

  bool inProcess = false;
  bool increate = false;
  bool isLoading = false;

  Locale? _locale;
  bool _autoValidate = true;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }
  getImageFile(ImageSource source) async {
    this.setState(() {
      inProcess = true;
    });
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      File? cropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Color.fromRGBO(46, 59, 110,0),
            statusBarColor: Color.fromRGBO(45, 90, 143,0),
            backgroundColor: Colors.black,
          ));

      // this.setState(() {
      //   seimage = cropped;
      //   inProcess = false;
      // });
    } else {
      this.setState(() {
        inProcess = false;
      });
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {
      increate = true;
    });
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      File? cropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Color.fromRGBO(46, 59, 110,0),
            statusBarColor: Color.fromRGBO(45, 90, 143,0),
            backgroundColor: Colors.black,
          ));

      this.setState(() {
        // ceimage = cropped;
        increate = false;
      });
    } else {
      this.setState(() {
        increate = false;
      });
    }
  }

  // ignore: non_constant_identifier_names
  void Upload_id(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        getImageFile(ImageSource.camera);

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Gallery'),
                    onTap: () {
                      getImageFile(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // ignore: non_constant_identifier_names
  void Upload_proofid(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        getImage(ImageSource.camera);

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Gallery'),
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: formKey,
        body: Stack(alignment: Alignment.center, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: Image.asset('assets/icon/icon.png')),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Personal Info",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 5, 50, 109),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        // Container(
                        //     margin: EdgeInsets.only(right: 22),
                        //     height: 50,
                        //     width: 50,
                        //     child: Image(image: AssetImage("assets/add.png"))
                        // )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid First Name"),
                        ]),
                        controller: fnameController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          // labelText: 'username',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(46, 59, 110, 1),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                          labelText: 'Name *',
                          errorText: _validate ? 'Enter the Name' : null,


                        ),
                        keyboardType: TextInputType.text,

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: TextFormField(
                        controller: lnameController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          // labelText: 'username',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(46, 59, 110, 1),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                          labelText: 'Date of Brith*',
                          errorText: _validate1 ? 'Enter valid Date of Brith' : null,

                        ),
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid Date of Brith"),
                        ]),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: fullnameController,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       // labelText: 'username',
                    //       prefixIcon: Icon(
                    //         Icons.person,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'Age*',
                    //       errorText: _validate2 ? 'Enter valid Age' : null,
                    //
                    //     ),
                    //     keyboardType: TextInputType.text,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Enter valid Age"),
                    //     ]),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: TextFormField(
                        controller: mobileController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          // labelText: 'username',
                          prefixIcon: Icon(
                            Icons.phone_sharp,
                            color: Color.fromRGBO(46, 59, 110, 1),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                          labelText: 'Blood Group*',
                          errorText: _validate3 ? 'Blood Group is required' : null,

                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Blood Group is required'),
                          MinLengthValidator(10, errorText: 'Blood Group must be at least 10 digits long'),
                        ]),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: TextFormField(
                        controller: passController,
                        // obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(46, 59, 110, 1),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                          labelText: 'Email Id*',
                          errorText: _validate4 ? 'Email Id is required' : null,

                        ),
                        // inputFormatters: [
                        //   LengthLimitingTextInputFormatter(10),
                        // ],
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Mobile_Number is required'),
                          ]),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: TextFormField(
                        controller: talukController,
                        // obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(46, 59, 110, 1),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                          labelText: 'Mobile Number*',
                          errorText: _validate9 ? 'Mobile Number is required' : null,

                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Mobile Number is required'),
                          // MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
                          // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
                        ]),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: TextFormField(
                        controller: doorController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          prefixIcon: Icon(
                            Icons.location_on_sharp,
                            color: Color.fromRGBO(46, 59, 110, 1),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                          labelText: 'Marital Status *',
                          errorText: _validate5 ? 'Enter valid Marital Status' : null,

                        ),
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid Marital Status"),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: TextFormField(
                        controller: wardController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          prefixIcon: Icon(
                            Icons.location_on_sharp,
                            color: Color.fromRGBO(46, 59, 110, 1),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                          labelText: 'Nationality*',
                          errorText: _validate6 ? 'Enter valid Nationality' : null,

                        ),
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid Nationality"),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: TextFormField(
                        controller: streetController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          prefixIcon: Icon(
                            Icons.location_on_sharp,
                            color: Color.fromRGBO(46, 59, 110, 1),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                          labelText: 'Religion*',
                          errorText: _validate7 ? 'Enter valid Religion' : null,

                        ),
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid Religion"),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: TextFormField(
                        controller: villageController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                          ),
                          prefixIcon: Icon(
                            Icons.location_on_sharp,
                            color: Color.fromRGBO(46, 59, 110, 1),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                          labelText: 'Address*',
                          errorText: _validate8 ? 'Enter valid Address' : null,

                        ),
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid Address"),
                        ]),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: talukController,
                    //     // obscureText: true,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.location_on_sharp,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'Taluk *',
                    //       errorText: _validate9 ? 'Enter valid Taluk' : null,
                    //
                    //     ),
                    //     keyboardType: TextInputType.text,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Enter valid Taluk"),
                    //     ]),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: districtController,
                    //     // obscureText: true,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.location_on_sharp,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'District',
                    //       errorText: _validate10 ? 'Enter valid District' : null,
                    //
                    //     ),
                    //     keyboardType: TextInputType.text,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Enter valid District"),
                    //     ]),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: stateController,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.location_on_sharp,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'State *',
                    //       errorText: _validate11 ? 'Enter valid State' : null,
                    //
                    //     ),
                    //     keyboardType: TextInputType.text,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Enter valid State"),
                    //     ]),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: pincodeController,
                    //     // obscureText: true,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.location_on_sharp,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'Pincode',
                    //       errorText: _validate12 ? 'Enter valid Pincode' : null,
                    //
                    //     ),
                    //     inputFormatters: [
                    //       LengthLimitingTextInputFormatter(6),
                    //     ],
                    //     keyboardType: TextInputType.number,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Enter valid First Name"),
                    //       MaxLengthValidator(6, errorText: 'Pincode must be at least 6 digits long'),
                    //
                    //     ]),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: BankNameController,
                    //     // obscureText: true,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.money,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'Bank Name',
                    //       errorText: _validate13 ? 'Enter valid Bank Name' : null,
                    //
                    //     ),
                    //     keyboardType: TextInputType.text,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Enter valid Bank Name"),
                    //     ]),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: BankAccoutNumberController,
                    //     // obscureText: true,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.money,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'Account Number',
                    //       errorText: _validate14 ? 'Enter valid Account Number' : null,
                    //
                    //     ),
                    //     keyboardType: TextInputType.number,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Enter valid Account Number"),
                    //     ]),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: IFSCcodeController,
                    //     // obscureText: true,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.money,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'IFSCcode',
                    //       errorText: _validate15 ? 'Enter valid IFSCcode' : null,
                    //
                    //     ),
                    //     keyboardType: TextInputType.text,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Enter valid IFSCcode"),
                    //     ]),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: Bank_BranchController,
                    //     // obscureText: true,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.money,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'Branch',
                    //       errorText: _validate16 ? 'Enter valid Branch' : null,
                    //
                    //     ),
                    //     keyboardType: TextInputType.text,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Enter valid Branch"),
                    //     ]),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 13, right: 13),
                    //   child: TextFormField(
                    //     controller: Bank_Address_PINCodeController,
                    //     // obscureText: true,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //         BorderSide(color: Color.fromRGBO(45, 90, 143, 1)),
                    //       ),
                    //
                    //       prefixIcon: Icon(
                    //         Icons.money,
                    //         color: Color.fromRGBO(46, 59, 110, 1),
                    //       ),
                    //       labelStyle: TextStyle(color: Color.fromRGBO(46, 59, 110, 1)),
                    //       labelText: 'Bank Address PINCode',
                    //       errorText: _validate17 ? 'Enter Bank Address PINCode' : null,
                    //
                    //     ),
                    //     inputFormatters: [
                    //       LengthLimitingTextInputFormatter(6),
                    //     ],
                    //     keyboardType: TextInputType.number,
                    //     validator: MultiValidator([
                    //       RequiredValidator(errorText: "* Required"),
                    //       EmailValidator(errorText: "Bank Address PINCode"),
                    //       MaxLengthValidator(6, errorText: 'Bank Address PINCode must be at least 6 digits long'),
                    //
                    //     ]),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         Text('Upload Photo*',
                    //             style: TextStyle(
                    //                 color: Color.fromRGBO(
                    //                   46,
                    //                   59,
                    //                   110,
                    //                   1,
                    //                 ))),
                    //         Container(
                    //           width: 70.43,
                    //           margin: EdgeInsets.all(5),
                    //           height: 30.79,
                    //           child: RaisedButton(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10.0),
                    //                 side: BorderSide(
                    //                   color: Color.fromARGB(255, 45, 90, 143),
                    //                 )),
                    //             onPressed: () {
                    //               Upload_proofid(context);
                    //             },
                    //             // padding: EdgeInsets.all(10.0),
                    //             color: Color.fromARGB(255, 45, 90, 143),
                    //             textColor: Colors.white,
                    //             child: Text("Upload",
                    //                 style: TextStyle(
                    //                     fontSize: 10, fontWeight: FontWeight.w400)),
                    //           ),
                    //         ),
                    //         ceimage == null
                    //             ? Container(
                    //           width: 77.43,
                    //           margin: EdgeInsets.all(5),
                    //           height: 77.79,
                    //           child: RaisedButton(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10.0),
                    //                 side: BorderSide(
                    //                   color: Color.fromRGBO(46, 59, 110, 1 / 2),
                    //                 )),
                    //             onPressed: () async {
                    //               if (await Permission.camera
                    //                   .request()
                    //                   .isGranted) {
                    //                 print("camera Permission is granted");
                    //                 Upload_proofid(context);
                    //               } else {
                    //                 print("camera Permission is denied.");
                    //                 Navigator.pop(context);
                    //               }
                    //             },
                    //             // padding: EdgeInsets.all(10.0),
                    //             color: Color.fromRGBO(46, 59, 110, 0.5),
                    //             textColor: Colors.white,
                    //             child: Align(
                    //               alignment: Alignment.center,
                    //               child: Container(
                    //                 child: Padding(
                    //                     padding: EdgeInsets.all(5),
                    //                     child: Icon(
                    //                       Icons.add_a_photo_sharp,
                    //                       size: 15,
                    //                       color: Color.fromRGBO(46, 59, 110, 1),
                    //                     )),
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //             : Container(
                    //           child: Image.file(
                    //             ceimage,
                    //             width: 77.43,
                    //             height: 77.79,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         Text('Upload ID Proof*',
                    //             style: TextStyle(
                    //                 color: Color.fromRGBO(
                    //                   46,
                    //                   59,
                    //                   110,
                    //                   1,
                    //                 ))),
                    //         Container(
                    //           width: 70.43,
                    //           margin: EdgeInsets.all(5),
                    //           height: 30.79,
                    //           child: RaisedButton(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10.0),
                    //                 side: BorderSide(
                    //                   color: Color.fromARGB(255, 45, 90, 143),
                    //                 )),
                    //             onPressed: () {
                    //               Upload_id(context);
                    //             },
                    //             // padding: EdgeInsets.all(10.0),
                    //             color: Color.fromARGB(255, 45, 90, 143),
                    //             textColor: Colors.white,
                    //             child: Text("Upload",
                    //                 style: TextStyle(
                    //                     fontSize: 10, fontWeight: FontWeight.w400)),
                    //           ),
                    //         ),
                    //         seimage == null
                    //             ? Container(
                    //           width: 77.43,
                    //           margin: EdgeInsets.all(5),
                    //           height: 77.79,
                    //           child: RaisedButton(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10.0),
                    //                 side: BorderSide(
                    //                   color: Color.fromRGBO(46, 59, 110, 1 / 2),
                    //                 )),
                    //             onPressed: () async {
                    //               if (await Permission.camera
                    //                   .request()
                    //                   .isGranted) {
                    //                 print("camera Permission is granted");
                    //                 Upload_id(context);
                    //               } else {
                    //                 print("camera Permission is denied.");
                    //                 Navigator.pop(context);
                    //               }
                    //             },
                    //             // padding: EdgeInsets.all(10.0),
                    //             color: Color.fromRGBO(46, 59, 110, 0.5),
                    //             textColor: Colors.white,
                    //             child: Align(
                    //               alignment: Alignment.center,
                    //               child: Container(
                    //                 child: Padding(
                    //                     padding: EdgeInsets.all(5),
                    //                     child: Icon(
                    //                       Icons.add_a_photo_sharp,
                    //                       size: 15,
                    //                       color: Color.fromRGBO(46, 59, 110, 1),
                    //                     )),
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //             : Container(
                    //           child: Image.file(
                    //             seimage,
                    //             width: 77.43,
                    //             height: 77.79,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    //     SizedBox(height: 10),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Column(
                    //           children: [
                    //             Text('Upload ID Proof*',
                    //                 style: TextStyle(
                    //                     color: Color.fromRGBO(
                    //                       46,
                    //                       59,
                    //                       110,
                    //                       1,
                    //                     ))),
                    //             Container(
                    //               width: 70.43,
                    //               margin: EdgeInsets.all(5),
                    //               height: 30.79,
                    //               child: RaisedButton(
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(10.0),
                    //                     side: BorderSide(
                    //                       color: Color.fromARGB(255, 45, 90, 143),
                    //                     )),
                    //                 onPressed: () {
                    //                   Upload_proofid(context);
                    //                 },
                    //                 // padding: EdgeInsets.all(10.0),
                    //                 color: Color.fromARGB(255, 45, 90, 143),
                    //                 textColor: Colors.white,
                    //                 child: Text("Upload",
                    //                     style: TextStyle(
                    //                         fontSize: 10, fontWeight: FontWeight.w400)),
                    //               ),
                    //             ),
                    //             idproof == null
                    //                 ? Container(
                    //               width: 77.43,
                    //               margin: EdgeInsets.all(5),
                    //               height: 77.79,
                    //               child: RaisedButton(
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(10.0),
                    //                     side: BorderSide(
                    //                       color: Color.fromRGBO(46, 59, 110, 1 / 2),
                    //                     )),
                    //                 onPressed: () async {
                    //                   if (await Permission.camera
                    //                       .request()
                    //                       .isGranted) {
                    //                     print("camera Permission is granted");
                    //                     Upload_proofid(context);
                    //                   } else {
                    //                     print("camera Permission is denied.");
                    //                     Navigator.pop(context);
                    //                   }
                    //                 },
                    //                 // padding: EdgeInsets.all(10.0),
                    //                 color: Color.fromRGBO(46, 59, 110, 0.5),
                    //                 textColor: Colors.white,
                    //                 child: Align(
                    //                   alignment: Alignment.center,
                    //                   child: Container(
                    //                     child: Padding(
                    //                         padding: EdgeInsets.all(5),
                    //                         child: Icon(
                    //                           Icons.add_a_photo_sharp,
                    //                           size: 15,
                    //                           color: Color.fromRGBO(46, 59, 110, 1),
                    //                         )),
                    //                   ),
                    //                 ),
                    //               ),
                    //             )
                    //                 : Container(
                    //               child: Image.file(
                    //                 idproof!,
                    //                 width: 77.43,
                    //                 height: 77.79,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Column(
                    //           children: [
                    //             Text('Upload ID Proof*',
                    //                 style: TextStyle(
                    //                     color: Color.fromRGBO(
                    //                       46,
                    //                       59,
                    //                       110,
                    //                       1,
                    //                     ))),
                    //             Container(
                    //               width: 70.43,
                    //               margin: EdgeInsets.all(5),
                    //               height: 30.79,
                    //               child: RaisedButton(
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(10.0),
                    //                     side: BorderSide(
                    //                       color: Color.fromARGB(255, 45, 90, 143),
                    //                     )),
                    //                 onPressed: () {
                    //                   Upload_id(context);
                    //                 },
                    //                 // padding: EdgeInsets.all(10.0),
                    //                 color: Color.fromARGB(255, 45, 90, 143),
                    //                 textColor: Colors.white,
                    //                 child: Text("Upload",
                    //                     style: TextStyle(
                    //                         fontSize: 10, fontWeight: FontWeight.w400)),
                    //               ),
                    //             ),
                    //             idproof3 == null
                    //                 ? Container(
                    //               width: 77.43,
                    //               margin: EdgeInsets.all(5),
                    //               height: 77.79,
                    //               child: RaisedButton(
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(10.0),
                    //                     side: BorderSide(
                    //                       color: Color.fromRGBO(46, 59, 110, 1 / 2),
                    //                     )),
                    //                 onPressed: () async {
                    //                   if (await Permission.camera
                    //                       .request()
                    //                       .isGranted) {
                    //                     print("camera Permission is granted");
                    //                     Upload_id(context);
                    //                   } else {
                    //                     print("camera Permission is denied.");
                    //                     Navigator.pop(context);
                    //                   }
                    //                 },
                    //                 // padding: EdgeInsets.all(10.0),
                    //                 color: Color.fromRGBO(46, 59, 110, 0.5),
                    //                 textColor: Colors.white,
                    //                 child: Align(
                    //                   alignment: Alignment.center,
                    //                   child: Container(
                    //                     child: Padding(
                    //                         padding: EdgeInsets.all(5),
                    //                         child: Icon(
                    //                           Icons.add_a_photo_sharp,
                    //                           size: 15,
                    //                           color: Color.fromRGBO(46, 59, 110, 1),
                    //                         )),
                    //                   ),
                    //                 ),
                    //               ),
                    //             )
                    //                 : Container(
                    //               child: Image.file(
                    //                 idproof3!,
                    //                 width: 77.43,
                    //                 height: 77.79,
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(height: 10),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Column(
                    //           children: [
                    //             Text('Upload ID Proof',
                    //                 style: TextStyle(
                    //                     color: Color.fromRGBO(
                    //                       46,
                    //                       59,
                    //                       110,
                    //                       1,
                    //                     ))),
                    //             Container(
                    //               width: 70.43,
                    //               margin: EdgeInsets.all(5),
                    //               height: 30.79,
                    //               child: RaisedButton(
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(10.0),
                    //                     side: BorderSide(
                    //                       color: Color.fromARGB(255, 45, 90, 143),
                    //                     )),
                    //                 onPressed: () {
                    //                   Upload_proofid(context);
                    //                 },
                    //                 // padding: EdgeInsets.all(10.0),
                    //                 color: Color.fromARGB(255, 45, 90, 143),
                    //                 textColor: Colors.white,
                    //                 child: Text("Upload",
                    //                     style: TextStyle(
                    //                         fontSize: 10, fontWeight: FontWeight.w400)),
                    //               ),
                    //             ),
                    //             idproof2 == null
                    //                 ? Container(
                    //               width: 77.43,
                    //               margin: EdgeInsets.all(5),
                    //               height: 77.79,
                    //               child: RaisedButton(
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(10.0),
                    //                     side: BorderSide(
                    //                       color: Color.fromRGBO(46, 59, 110, 1 / 2),
                    //                     )),
                    //                 onPressed: () async {
                    //                   if (await Permission.camera
                    //                       .request()
                    //                       .isGranted) {
                    //                     print("camera Permission is granted");
                    //                     Upload_proofid(context);
                    //                   } else {
                    //                     print("camera Permission is denied.");
                    //                     Navigator.pop(context);
                    //                   }
                    //                 },
                    //                 // padding: EdgeInsets.all(10.0),
                    //                 color: Color.fromRGBO(46, 59, 110, 0.5),
                    //                 textColor: Colors.white,
                    //                 child: Align(
                    //                   alignment: Alignment.center,
                    //                   child: Container(
                    //                     child: Padding(
                    //                         padding: EdgeInsets.all(5),
                    //                         child: Icon(
                    //                           Icons.add_a_photo_sharp,
                    //                           size: 15,
                    //                           color: Color.fromRGBO(46, 59, 110, 1),
                    //                         )),
                    //                   ),
                    //                 ),
                    //               ),
                    //             )
                    //                 : Container(
                    //               child: Image.file(
                    //                 idproof2!,
                    //                 width: 77.43,
                    //                 height: 77.79,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //   ],
                    // ),
                    Container(
                      width: 318,
                      margin: EdgeInsets.all(10),
                      height: 51.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: Color.fromARGB(255, 45, 90, 143),
                            )),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            fnameController.text.isEmpty ? _validate = true : _validate = false;
                            lnameController.text.isEmpty ? _validate1 = true : _validate1 = false;
                            fullnameController.text.isEmpty ? _validate2 = true : _validate2 = false;
                            mobileController.text.isEmpty ? _validate3 = true : _validate3 = false;
                            passController.text.isEmpty ? _validate4 = true : _validate4 = false;
                            doorController.text.isEmpty ? _validate5 = true : _validate5 = false;
                            wardController.text.isEmpty ? _validate6 = true : _validate6 = false;
                            streetController.text.isEmpty ? _validate7 = true : _validate7 = false;
                            villageController.text.isEmpty ? _validate8 = true : _validate8 = false;
                            talukController.text.isEmpty ? _validate9 = true : _validate9 = false;
                            });
                          approval(
                            fnameController.text,
                            lnameController.text,
                            fullnameController.text,
                            passController.text,
                            mobileController.text,
                            doorController.text,
                            wardController.text,
                            streetController.text,
                            villageController.text,
                            // talukController.text,
                          );
                          setState(() {
                            isLoading = true;
                          });


                        },
                        padding: EdgeInsets.all(10.0),
                        color: Color.fromARGB(255, 45, 90, 143),
                        textColor: Colors.white,
                        child: Text("Next",
                            style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(height: 25,)
                  ],
                )),
          ),


        ]));
  }

  approval(
      firstname,
      lastname,
      fullname,
      password,
      mobilenumber,
      doorno,
      wardno,
      streetname,
      villagecityname,
      ) async {
    var msg =
    jsonEncode(
    {
      "Name": fnameController.text.toString(),
      "Date_of_birth": lnameController.text.toString(),
      "Blood_Group": mobileController.text.toString(),
      "Email_Id": passController.text.toString(),
      "Mobile_Number": talukController.text.toString(),
      "Marital_Status": doorController.text.toString(),
      "Nationality": wardController.text.toString(),
      "Religion": streetController.text.toString(),
      "Address": villageController.text.toString(),
      });

    var url = "http://172.25.80.1/connectiv_api/personal_info.php";

    var response = await http.post(Uri.parse(url),
        body: msg);
    print(msg);
    print(response.body);

    var responseJson = await json.decode(response.body);
    print(responseJson);
    var status = responseJson['Account_Active_Status'];
    var message = responseJson['message'];
    if (message == "Register successful!")
    {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 14.0);

      Navigator.pop(context, MaterialPageRoute(builder: (context) => ScanQrPage()));

    }
    else{
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }
}
