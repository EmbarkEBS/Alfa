import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:churchIn/utils/colors.dart';
import 'package:churchIn/utils/valiidator.dart';
import 'package:churchIn/widgets/button_plain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/encrypter.dart';
import 'helpers/helper.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _gender="Gender";
  String successtxt="",errtxt="";

  final TextEditingController _fullnamecontroller=TextEditingController();
  final TextEditingController _addresscontroller=TextEditingController();
  final TextEditingController _emailcontroller=TextEditingController();
  final TextEditingController _citycontroller=TextEditingController();
  final TextEditingController _statecontroller=TextEditingController();
  final TextEditingController _countrycontroller=TextEditingController();
  final TextEditingController _postalcodecontroller=TextEditingController();
  final TextEditingController _phonecontroller=TextEditingController();
  final TextEditingController _occupationcontroller=TextEditingController();
  final TextEditingController _teachercontroller=TextEditingController();
  //final TextEditingController vaue=TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController anniversaryInput = TextEditingController();
  String imageurl="";
  String fullname="";
  String address="";
  String email="";
  String city="";
  String postalcode="";
  String state_1="";
  String country="";
  String phone="";
  String occupation="";
  String dropdownvalue1 = 'Gender';
  var items1 = [
    'Gender',
    'Male',
    'Female',
  ];
  String referred_by = 'Referred By';
  var referrence = [
    'Referred By',
    'Invited By Friend',
    'Google',
    'Youtube',
    'Facebook',
    'Instagram',
  ];
  String teacher="";
  String classgroup = '0-9 years';
  var items4 = [
    '0-9 years',
    '9-12 years',
    '13-18 years',
    '19-25 years',
  ];
  String marital = '-';
  var items2 = [
    '-',
    'Married',
    'Unmarried',
  ];
  String children = '0';
  var items3 = [
    '0',
    '1',
    '2',
  ];
  String _selectedType="-";
  final _formkey=GlobalKey<FormState>();
  final _formkey_1=GlobalKey<FormState>();
  final _formkey_2=GlobalKey<FormState>();
  final _formkey_4=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final eventid = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    print("ddddddd"+eventid.toString());
    if(Helper.type=="1"){
    return Scaffold(
    resizeToAvoidBottomInset: false,
    body: SingleChildScrollView(
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
    child:Form(
    key:_formkey,
    child:Column(
    children: <Widget>[
    Container(
    // margin: EdgeInsets.fromLTRB(0, 0, 5,5),
    child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    //FlutterLogo(size: 100,),
    SvgPicture.asset(
    "assets/images/newlogo.svg",
    width: 50,
    height: 50,
    ),
    IconButton(
    onPressed: (){
    Navigator.pushNamed(context, "/scanner");
    },
    icon: Icon(
    Icons.home, size: 30,color: Colors.orange,
    )
    ),
    ]
    ),
    ) ,
    SizedBox(height: 10,),
    //Image(image: AssetImage('assets/images/UA_170_Logo.png'),width: 200,),
    Text('First Time User Registration',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    style: TextStyle(height: 0,),
    controller: _fullnamecontroller,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter name';
    }
    return null;
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.account_circle_rounded,color: Colors.orange,),
    //labelText: "Full Name",
    hintText: "Full Name",
    fillColor: Colors.orange.shade50,
    filled: true,
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    /*border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.lightBlue),
                  ),*/
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepPurple.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    fullname=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ),
    DropdownButtonFormField(
    value: dropdownvalue1,
    validator: (value) {
    if (value == null || value=="Gender") {
    return 'Please select gender';
    }
    return null;
    },
    items: items1.map((String items) {
    return DropdownMenuItem(
    value: items,
    child: Text(items),
    );
    }).toList(),
    onChanged: (String? newValue) {
    setState(() {
    dropdownvalue1 = newValue!;
    });
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.person, color: Colors.orange,),
    fillColor:Colors.orange.shade50,
    filled: true,
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter date of birth';
    }
    return null;
    },
    controller: dateInput,
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.calendar_today, color: Colors.orange,), //icon of text field
    // labelText: "Enter DOB",
    hintText: "Enter DOB",
    fillColor:Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )

    ),

    readOnly: true,
    //set it true, so that user will not able to edit text
    onTap: () async {
    DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime(2015),
    firstDate: DateTime(1950),
    //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2015));

    if (pickedDate != null) {
    print(
    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate =
    DateFormat('yyyy-MM-dd').format(pickedDate);
    print(
    formattedDate); //formatted date output using intl package =>  2021-03-16
    setState(() {
    dateInput.text =
    formattedDate; //set output date to TextField value.
    });
    } else {}
    },

    ),

    SizedBox(
    height: 15,
    ),
    TextFormField(
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter Address';
    }
    return null;
    },
    controller: _addresscontroller,
    keyboardType: TextInputType.multiline,
    textInputAction: TextInputAction.newline,
    maxLines: 5,
    minLines: 1,
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.notes,color: Colors.orange,),
    //labelText: "Address",
    hintText: "Enter Address",
    fillColor: Colors.orange.shade50,
    filled: true,
    // labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    address=value;
    });
    }
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter City';
    }
    return null;
    },
    controller: _citycontroller,
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.location_city, color: Colors.orange,),
    //labelText: "City",
    hintText: "Enter City",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    city=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter State';
    }
    return null;
    },
    controller: _statecontroller,
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.location_city, color: Colors.orange,),
    //labelText: "City",
    hintText: "Enter State",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    state_1=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _countrycontroller,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter valid country';
    }
    return null;
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.location_city, color: Colors.orange,),
    //labelText: "City",
    hintText: "Enter Country",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    country=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter valid postal code';
    }
    return null;
    },
    controller: _postalcodecontroller,
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.pin_drop, color: Colors.orange,),
    //labelText: "City",
    hintText: "Enter Postal Code",
    fillColor:Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    postalcode=value;
    });}
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _emailcontroller,
    validator: (value)=>FieldValidator.validateEmail(value!),
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.email_outlined, color: Colors.orange,),
    //labelText: "Email",
    hintText: "Enter Email",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    email=value;
    });
    }
    ),
    SizedBox(
    height: 15,
    ),
    DropdownButtonFormField(
    value: marital,
    validator: (value) {
    if (value == null || value=="-") {
    return 'Please enter valid Marital status';
    }
    return null;
    },
    items: items2.map((String items) {
    return DropdownMenuItem(
    value: items,
    child: Text(items),
    );
    }).toList(),
    onChanged: (String? newValue) {
    setState(() {
    marital = newValue!;
    });
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.person, color: Colors.orange,),
    fillColor: Colors.orange.shade50,
    filled: true,

    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    ),
    SizedBox(
    height: 15,
    ),

    TextFormField(
    controller: anniversaryInput,
    validator: (value) {
    if (value == null || (value.isEmpty && marital=="Married")) {
    return 'Please enter anniversary date';
    }
    return null;
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.calendar_today, color: Colors.orange,), //icon of text field
    // labelText: "Enter DOB",
    hintText: "Enter Date",
    fillColor: Colors.orange.shade50,
    filled: true,
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )

    ),

    readOnly: true,
    //set it true, so that user will not able to edit text
    onTap: () async {
    DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime.now());

    if (pickedDate != null) {
    print(
    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate =
    DateFormat('yyyy-MM-dd').format(pickedDate);
    print(
    formattedDate); //formatted date output using intl package =>  2021-03-16
    setState(() {
    anniversaryInput.text =
    formattedDate; //set output date to TextField value.
    });
    } else {}
    },

    ),

    SizedBox(
    height: 15,
    ),
    DropdownButtonFormField(
    value: children,
    items: items3.map((String items) {
    return DropdownMenuItem(
    value: items,
    child: Text(items),
    );
    }).toList(),
    onChanged: (String? newValue) {
    setState(() {
    children = newValue!;
    });
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.person, color: Colors.orange,),
    fillColor: Colors.orange.shade50,
    filled: true,
    hintText: "No of childs",
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    ),
    SizedBox(
    height: 15,
    ),

    TextFormField(
    controller: _phonecontroller,
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.phone, color: Colors.orange,
    ),
    //labelText: "Email",
    hintText: "Enter Phone",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    validator: (value) {
    if (value == null || value.isEmpty || value.length!=10) {
    return 'Please enter valid phone number';
    }
    return null;
    },
    keyboardType: TextInputType.phone,
    onChanged: (value){
    setState((){
    phone=value;
    });
    }
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _occupationcontroller,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter Occupation';
    }
    return null;
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.laptop, color: Colors.orange,),
    //labelText: "Email",
    hintText: "Enter Occupation",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    occupation=value;
    });
    }
    ),
    SizedBox(
    height: 15,
    ),
    DropdownButtonFormField(
    value: referred_by,
    validator: (value) {
    if (value == null || value=="Referred By") {
    return 'Please select how do you know';
    }
    return null;
    },
    items: referrence.map((String items) {
    return DropdownMenuItem(
    value: items,
    child: Text(items),
    );
    }).toList(),
    onChanged: (String? newValue) {
    setState(() {
    referred_by = newValue!;
    });
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.person, color: Colors.orange,),
    fillColor:Colors.orange.shade50,
    filled: true,
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    ),
    (errtxt!="")?Text(errtxt,
    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
    ):(successtxt!="")?Text(successtxt,
    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
    ):Text("",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    SizedBox(
    height: 25,
    ),


    ElevatedButton(
    // color: wood_smoke,
    //textColor: white,
    //borderColor: wood_smoke,
    // text: "Register",
    /* onTap: () async{
    if (_formkey.currentState!.validate()) {
    var url = 'https://churchinapp.com/public/api/memberregister';
    final Map<String,String> data = {
    'id':eventid["id"],"name":fullname,"gender":dropdownvalue1,"dob":dateInput.text,"address":address,"city":city,"state":state_1,"postalcode":postalcode,"country":country,"marital_status":marital,"anniversary":anniversaryInput.text,"no_of_children":children,"email":email,"phone_number":phone,"occupation":occupation};
    print("testing data"+data.toString());
    setState(()
    {
      vaue.text=data.toString();
    });

    /*final response = await http.post(Uri.parse(url),
    body: encryption(json.encode(data)),
    encoding: Encoding.getByName('utf-8'),
    headers:{
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    });
    if (response.statusCode == 200) {
    *///Map<String,dynamic> result=json.decode(decryption(response.body));

    final Map<String,dynamic> result = {
    "message":"success","user_id":"1"};
    if(result["message"]=="success"){
    SharedPreferences prefs = await SharedPreferences
        .getInstance();
    prefs.setString("user_type", "1");
    prefs.setString("user_id", result["user_id"]);
    setState(() {
      Helper.type="1";
    });
    }
    //}
    }
    }, */
    onPressed: () async{
    if (_formkey.currentState!.validate()) {


    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('M/d/y');
    String formatted = formatter.format(now);
    DateFormat formatter1 = DateFormat('jm');
    String formatted1 = formatter1.format(now);
    //print(formatted);

    var url = 'https://churchinapp.com/api/memberregister';
    final Map<String,String> data = {"entry_date":formatted,"entry_time":formatted1,
    'qrcode':eventid["value"],"member_type":Helper.type.toString(),"name":fullname,"gender":dropdownvalue1,"dob":dateInput.text,"address":address,"city":city,"state":state_1,"pincode":postalcode,"country":country,"marital_status":marital,"wed_anniversary":anniversaryInput.text,"no_of_child":children,"email":email,"phone_no":phone,"occupation":occupation,"referred_by":referred_by};
    print("testing data"+data.toString());
    /*  setState(()
        {
          vaue.text=json.encode({"data":encryption(json.encode(data))}).toString();
        });*/
    Map<String,String> dat={"data":encryption(json.encode(data))};
    print("testing data"+dat.toString());
    try{
    final response = await http.post(Uri.parse(url),
    body: json.encode(dat),
    headers:{
    "CONTENT-TYPE":"application/json"
    }).timeout(const Duration(seconds: 20));/*setState(() {
    vaue.text=decryption(response.body.toString().trim()).split("}")[0]+"}hai";
    });*/
    if (response.statusCode == 200) {
    Map<String,dynamic> result=jsonDecode(decryption(response.body.toString().trim()).split("}")[0]+"}") as Map<String,dynamic>;

    /* final Map<String,dynamic> result = {
    "message":"success","user_id":"1"};*/
    if(result["status"]=="1"){
    setState((){
    successtxt= result["message"];
    errtxt="";
    _fullnamecontroller.clear();
    _addresscontroller.clear();
    _emailcontroller.clear();
    _citycontroller.clear();
    _countrycontroller.clear();
    _occupationcontroller.clear();
    _phonecontroller.clear();
    _postalcodecontroller.clear();
    _statecontroller.clear();
    dateInput.clear();
    anniversaryInput.clear();
    dropdownvalue1='Gender';
    //state_1="";
    marital="-";
    children="0";

    });
    } else{
    setState((){
    errtxt=result["message"];
    successtxt="";

    });
    }
    }else{
    setState((){
    successtxt="";
    errtxt=response.statusCode.toString()+" :Please Check your Internet Connection And data";
    });
    }
    }on TimeoutException catch(e) {
    setState((){
    errtxt="Please Check your Internet Connection And data"
    ;successtxt="";

    });

    }on Exception catch(e){
    setState((){
    errtxt=e.toString();
    successtxt="";

    });

    }
    }
    }, child: Text(
    "Register",
    ),
    style: ElevatedButton.styleFrom(
    primary: Colors.orange,
    minimumSize: Size(150, 40),
    shape: RoundedRectangleBorder( //to set border radius to button
    borderRadius: BorderRadius.circular(10)
    ),// NEW
    ),
    ),
    ElevatedButton(onPressed: (){
    /*final Map<String,String> data = {"entry_date":formatted,"entry_time":formatted1,
    'qrcode':eventid["value"],"member_type":Helper.type.toString(),"name":fullname,"gender":dropdownvalue1,"dob":dateInput.text,"address":address,"city":city,"state":state_1,"pincode":postalcode,"country":country,"marital_status":marital,"wed_anniversary":anniversaryInput.text,"no_of_child":children,"email":email,"phone_no":phone,"occupation":occupation};
    print("testing data"+data.toString());*/
    setState(()
    {
    _fullnamecontroller.clear();
    _addresscontroller.clear();
    _emailcontroller.clear();
    _citycontroller.clear();
    _countrycontroller.clear();
    _occupationcontroller.clear();
    _phonecontroller.clear();
    _postalcodecontroller.clear();
    _statecontroller.clear();
    dateInput.clear();
    anniversaryInput.clear();
    dropdownvalue1='Gender';
    //state_1="";
    marital="-";
    children="0";
    });
    }, child: Text(
    "Reset",
    ),
    style: ElevatedButton.styleFrom(
    primary: Colors.blue,
    minimumSize: Size(150, 40),
    shape: RoundedRectangleBorder( //to set border radius to button
    borderRadius: BorderRadius.circular(10)
    ),// NEW
    ),
    ),
    Column(

    mainAxisAlignment: MainAxisAlignment.end,
    children: [
    SizedBox(height: 20,),
    Container(
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    TextButton(
    onPressed: (){
    Navigator.pushNamed(context, "/policy");
    },
    child:Text("Privacy Policy" ,
    textAlign: TextAlign.start,
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: Colors.blue,
    decoration: TextDecoration.underline

    ),
    )                          ),
    ],
    ),
    )

    ],
    ),
    ],
    ),
    )
    ),
    ),
    );
    }else if(Helper.type=="2"){

    return  Scaffold(
    resizeToAvoidBottomInset: false,
    body: SingleChildScrollView(
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    child: Form(
    key:_formkey_1,
    child:Column(
    children: <Widget>[
    SizedBox(
    height: 50,
    ),
    Container(
    // margin: EdgeInsets.fromLTRB(0, 0, 5,5),
    child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    //FlutterLogo(size: 100,),
    SvgPicture.asset(
    "assets/images/newlogo.svg",
    width: 50,
    height: 50,
    ),
    IconButton(
    onPressed: (){
    Navigator.pushNamed(context, "/scanner");
    },
    icon: Icon(
    Icons.home, size: 30,color: Colors.orange,
    )
    ),
    ]
    ),
    ) ,

    //Image(image: AssetImage('assets/images/UA_170_Logo.png'),width: 200,),
    Text('Children Entry',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _fullnamecontroller,

    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.account_circle_rounded, color:Colors.orange),
    //labelText: "Full Name",
    hintText: "Full Name",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),

    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter name';
    }
    return null;
    },
    onChanged: (value){
    setState((){
    fullname=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ),
    DropdownButtonFormField(
    value: _gender,

    validator: (value) {
    if (value == null || value=="Gender") {
    return 'Please select Gender';
    }
    return null;
    },
    items: items1.map((String items) {
    return DropdownMenuItem(
    value: items,
    child: Text(items),
    );
    }).toList(),
    onChanged: (String? newValue) {
    setState(() {
    _gender = newValue!;
    });
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.person, color:Colors.orange),
    fillColor: Colors.orange.shade50,
    filled: true,
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _teachercontroller,
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.person, color:Colors.orange),
    //labelText: "Full Name",
    hintText: "Teacher Name",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    teacher=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ),
    DropdownButtonFormField(
    value: classgroup,
    validator: (value) {
    if (value == null || value=="-") {
    return 'Please select age';
    }
    return null;
    },
    items: items4.map((String items) {
    return DropdownMenuItem(
    value: items,
    child: Text(items),
    );
    }).toList(),
    onChanged: (String? newValue) {
    setState(() {
    classgroup = newValue!;
    });
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.person, color:Colors.orange),
    fillColor: Colors.orange.shade50,
    filled: true,
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    ),
    SizedBox(
    height: 15,
    ),
    (errtxt!="")?Text(errtxt,
    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
    ):(successtxt!="")?Text(successtxt,
    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
    ):Text("",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    SizedBox(
    height: 25,
    ),
    ElevatedButton(
    onPressed: ()async{
    if (_formkey_1.currentState!.validate()) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('M/d/y');
    String formatted = formatter.format(now);
    DateFormat formatter1 = DateFormat('jm');
    String formatted1 = formatter1.format(now);
    //print(formatted);

    var url = 'https://churchinapp.com/api/signinchildren';
    final Map<String,String> data = {"entry_date":formatted,"entry_time":formatted1,
    'qrcode':eventid["value"],"member_type":Helper.type.toString(),"name":fullname,"gender":_gender,"teacher":teacher,"class_group":classgroup};
    print("testing data"+data.toString());
    /*  setState(()
    {
    vaue.text=encryption(json.encode(data)).toString();
    });*/
    try{
    final response = await http.post(Uri.parse(url),
    body:json.encode({"data":encryption(json.encode(data))}),
    encoding: Encoding.getByName('utf-8'),
    headers:{
    "CONTENT-TYPE":"application/json"
    }).timeout(const Duration(seconds: 20));/*setState(() {
    vaue.text=response.statusCode.toString();
    });*/
    if (response.statusCode == 200) {
    Map<String,dynamic> result=jsonDecode(decryption(response.body.toString().trim()).split("}")[0]+"}") as Map<String,dynamic>;
    /*final Map<String,dynamic> result = {
    "message":"success","user_id":"1"};*/
    if(result["status"]=="1"){
    setState((){
    successtxt=result["message"];
    errtxt="";
    _formkey_1.currentState!.reset();
    _fullnamecontroller.clear();
    classgroup="0-9 years";
    _teachercontroller.clear();
    _gender='Gender';
    });
    } else{
    setState((){
    errtxt=result["message"];
    successtxt="";
    _formkey_1.currentState!.reset();
    });
    }
    }else{
    setState((){
    errtxt="Please Check your Internet Connection And data";
    successtxt="";
    _formkey_1.currentState!.reset();
    });
    }
    }on TimeoutException catch(e) {
    setState((){
    errtxt="Please Check your Internet Connection And data";
    successtxt="";
    _formkey_1.currentState!.reset();
    });

    }on Exception catch(e){
    setState((){
    errtxt=e.toString();
    successtxt="";
    _formkey_1.currentState!.reset();
    });

    }
    }
    },
    child: Text("Register",),
    style: ElevatedButton.styleFrom(
    primary: Colors.orange,
    minimumSize: Size(150, 40),
    shape: RoundedRectangleBorder( //to set border radius to button
    borderRadius: BorderRadius.circular(10)
    ),// NEW
    ),
    ),
    ElevatedButton(onPressed: (){
    /*final Map<String,String> data = {"entry_date":formatted,"entry_time":formatted1,
    'qrcode':eventid["value"],"member_type":Helper.type.toString(),"name":fullname,"gender":dropdownvalue1,"dob":dateInput.text,"address":address,"city":city,"state":state_1,"pincode":postalcode,"country":country,"marital_status":marital,"wed_anniversary":anniversaryInput.text,"no_of_child":children,"email":email,"phone_no":phone,"occupation":occupation};
    print("testing data"+data.toString());*/
    setState(()
    {
    _fullnamecontroller.clear();
    classgroup="0-9 years";
    _teachercontroller.clear();
    _gender='Gender';
    });
    }, child: Text(
    "Reset",
    ),
    style: ElevatedButton.styleFrom(
    primary: Colors.blue,
    minimumSize: Size(150, 40),
    shape: RoundedRectangleBorder( //to set border radius to button
    borderRadius: BorderRadius.circular(10)
    ),// NEW
    ),
    ),
    Column(

    mainAxisAlignment: MainAxisAlignment.end,
    children: [
    SizedBox(height: 20,),
    Container(
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    TextButton(
    onPressed: (){
    Navigator.pushNamed(context, "/policy");
    },
    child:Text("Privacy Policy" ,
    textAlign: TextAlign.start,
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: Colors.blue,
    decoration: TextDecoration.underline

    ),
    )                          ),
    ],
    ),
    )

    ],
    ),
    ],
    ),
    )
    ),
    ),
    );


    }else if(Helper.type=="4"){
    return  Scaffold(
    resizeToAvoidBottomInset: false,
    body:  SingleChildScrollView(
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    child: Form(
    key:_formkey_4,
    child:Column(
    children: <Widget>[
    SizedBox(
    height: 50,
    ),
    Container(
    // margin: EdgeInsets.fromLTRB(0, 0, 5,5),
    child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    //FlutterLogo(size: 100,),
    SvgPicture.asset(
    "assets/images/newlogo.svg",
    width: 50,
    height: 50,
    ),
    IconButton(
    onPressed: (){
    Navigator.pushNamed(context, "/scanner");
    },
    icon: Icon(
    Icons.home, size: 30,color: Colors.orange,
    )
    ),
    ]
    ),
    ) ,

    //Image(image: AssetImage('assets/images/UA_170_Logo.png'),width: 200,),
    Text('Event Entry',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _fullnamecontroller,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter name';
    }
    return null;
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.account_circle_rounded,color:Colors.orange),
    //labelText: "Full Name",
    hintText: "Full Name",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    fullname=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _emailcontroller,
    validator:(value)=>FieldValidator.validateEmail(value!),
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.email,color:Colors.orange),
    //labelText: "Full Name",
    hintText: "Email",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    keyboardType: TextInputType.emailAddress,
    onChanged: (value){
    setState((){
    email=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ), TextFormField(
    controller: _phonecontroller,
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.phone, color: Colors.orange,
    ),
    //labelText: "Email",
    hintText: "Enter Phone",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    validator: (value) {
    if (value == null || value.isEmpty || value.length!=10) {
    return 'Please enter valid phone number';
    }
    return null;
    },
    keyboardType: TextInputType.phone,
    onChanged: (value){
    setState((){
    phone=value;
    });
    }
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _occupationcontroller,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter Occupation';
    }
    return null;
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.laptop, color: Colors.orange,),
    //labelText: "Email",
    hintText: "Enter Occupation",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    occupation=value;
    });
    }
    ),
    SizedBox(
    height: 15,
    ),
    (errtxt!="")?Text(errtxt,
    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
    ):(successtxt!="")?Text(successtxt,
    style: TextStyle(color: Colors.purple.shade900, fontWeight: FontWeight.bold, fontSize: 12),
    ):Text("",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    SizedBox(
    height: 25,
    ),
    ElevatedButton(
    onPressed: () async{
    if (_formkey_4.currentState!.validate()) {

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('M/d/y');
    String formatted = formatter.format(now);
    DateFormat formatter1 = DateFormat('jm');
    String formatted1 = formatter1.format(now);
    //print(formatted);
    var url = 'https://churchinapp.com/api/eventregister';
    final Map<String,String> data = {"entry_date":formatted,"entry_time":formatted1,
    'qrcode':eventid["value"],"member_type":Helper.type.toString(),"name":fullname,"email":email,"phone_no":phone,"occupation":occupation};
    print("testing data"+data.toString());
    print("testing data"+json.encode({"data":encryption(json.encode(data))}));
    /* setState(()
          {
            vaue.text=json.encode({"data":encryption(json.encode(data))}).toString();
          });*/try{
    final response = await http.post(Uri.parse(url),
    body: json.encode({"data":encryption(json.encode(data))}),
    encoding: Encoding.getByName('utf-8'),
    headers:{
    "CONTENT-TYPE":"application/json"
    }).timeout(Duration(seconds:20));/*setState(() {
      vaue.text=response.statusCode.toString();
    });*/
    if (response.statusCode == 200) {
    Map<String,dynamic> result=jsonDecode(decryption(response.body.toString().trim()).split("}")[0]+"}") as Map<String,dynamic>;

    /*   final Map<String,dynamic> result = {
            "message":"success","user_id":"1"};*/
    if(result["status"]=="1"){
    setState((){
    successtxt=result["message"];
    errtxt="";
    _fullnamecontroller.clear();
    _emailcontroller.clear();
    _phonecontroller.clear();
    _occupationcontroller.clear();

    });
    } else{
    setState((){
    errtxt=result["message"];
    successtxt="";
    });
    }
    }else{
    setState((){
    successtxt="";
    errtxt="Please Check your Internet Connection And data"/*+response.statusCode.toString()+response.body*/;
    });
    }/*
    setState((){
    vaue.text="Please Check your Internet Connection And data";
    });*/
    }on TimeoutException catch (_) {
    setState((){
    successtxt="";
    errtxt="Please Check your Internet Connection And data";
    });
    //return false;
    }on Exception catch(e){
    setState((){
    errtxt=e.toString();
    successtxt="";

    });

    }
    }
    }, child: Text("Register",),
    style: ElevatedButton.styleFrom(
    primary: Colors.orange,
    minimumSize: Size(150, 40),
    shape: RoundedRectangleBorder( //to set border radius to button
    borderRadius: BorderRadius.circular(10)
    ),// NEW
    ),
    ),
    ElevatedButton(onPressed: (){
    /*final Map<String,String> data = {"entry_date":formatted,"entry_time":formatted1,
    'qrcode':eventid["value"],"member_type":Helper.type.toString(),"name":fullname,"gender":dropdownvalue1,"dob":dateInput.text,"address":address,"city":city,"state":state_1,"pincode":postalcode,"country":country,"marital_status":marital,"wed_anniversary":anniversaryInput.text,"no_of_child":children,"email":email,"phone_no":phone,"occupation":occupation};
    print("testing data"+data.toString());*/
    setState(()
    {
    _fullnamecontroller.clear();
    _emailcontroller.clear();
    _phonecontroller.clear();
    _occupationcontroller.clear();
    });
    }, child: Text(
    "Reset",
    ),
    style: ElevatedButton.styleFrom(
    primary: Colors.blue,
    minimumSize: Size(150, 40),
    shape: RoundedRectangleBorder( //to set border radius to button
    borderRadius: BorderRadius.circular(10)
    ),// NEW
    ),
    ),
    Column(

    mainAxisAlignment: MainAxisAlignment.end,
    children: [
    SizedBox(height: 20,),
    Container(
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    TextButton(
    onPressed: (){
    Navigator.pushNamed(context, "/policy");
    },
    child:Text("Privacy Policy" ,
    textAlign: TextAlign.start,
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: Colors.blue,
    decoration: TextDecoration.underline

    ),
    )                          ),
    ],
    ),
    )

    ],
    ),
    ],

    ),
    ),
    )
    ),
    );

    }
    return  Scaffold(
    resizeToAvoidBottomInset: false,
    body:  SingleChildScrollView(
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    child: Form(
    key:_formkey_2,
    child:Column(
    children: <Widget>[
    SizedBox(
    height: 50,
    ),
    Container(
    // margin: EdgeInsets.fromLTRB(0, 0, 5,5),
    child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    //FlutterLogo(size: 100,),
    SvgPicture.asset(
    "assets/images/newlogo.svg",
    width: 50,
    height: 50,
    ),
    //SizedBox(width: 100,),
    IconButton(
    onPressed: (){
    Navigator.pushNamed(context, "/scanner");
    },
    icon: Icon(
    Icons.home, size: 30,color: Colors.orange,
    )
    ),
    ]
    ),
    ) ,

    //Image(image: AssetImage('assets/images/UA_170_Logo.png'),width: 200,),
    Text('Current Member Entry',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _fullnamecontroller,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter name';
    }
    return null;
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.account_circle_rounded,color:Colors.orange),
    //labelText: "Full Name",
    hintText: "Full Name",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    onChanged: (value){
    setState((){
    fullname=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: _emailcontroller,
    validator:(value)=>FieldValidator.validateEmail(value!),
    decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    prefixIcon: Icon(Icons.email,color:Colors.orange),
    //labelText: "Full Name",
    hintText: "Email",
    fillColor: Colors.orange.shade50,
    filled: true,
    //labelStyle: TextStyle(fontSize: 15,color: Colors.blue),
    hintStyle: TextStyle(fontSize: 16.0, color: Colors.orange, fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.orange,
    ),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.deepOrange.shade200,
    width: 1.0,
    ),
    ),
    errorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    ),
    focusedErrorBorder: new OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
    color: Colors.red.shade200,
    width: 1.0,
    ),
    )
    ),
    keyboardType: TextInputType.emailAddress,
    onChanged: (value){
    setState((){
    email=value;
    });
    },
    ),
    SizedBox(
    height: 15,
    ),
    (errtxt!="")?Text(errtxt,
    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
    ):(successtxt!="")?Text(successtxt,
    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
    ):Text("",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    SizedBox(
    height: 25,
    ),
    ElevatedButton(
    onPressed: () async{
    if (_formkey_2.currentState!.validate()) {

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('M/d/y');
    String formatted = formatter.format(now);
    DateFormat formatter1 = DateFormat('jm');
    String formatted1 = formatter1.format(now);
    //print(formatted);
    var url = 'https://churchinapp.com/api/currentmember';
    final Map<String,String> data = {"entry_date":formatted,"entry_time":formatted1,
    'qrcode':eventid["value"],"member_type":Helper.type.toString(),"name":fullname,"email":email};
    print("testing data"+data.toString());
    /* setState(()
          {
            vaue.text=json.encode({"data":encryption(json.encode(data))}).toString();
          });*/try{
    final response = await http.post(Uri.parse(url),
    body: json.encode({"data":encryption(json.encode(data))}),
    encoding: Encoding.getByName('utf-8'),
    headers:{
    "CONTENT-TYPE":"application/json"
    }).timeout(Duration(seconds:20));/*setState(() {
      vaue.text=response.statusCode.toString();
    });*/
    if (response.statusCode == 200) {
    Map<String,dynamic> result=jsonDecode(decryption(response.body.toString().trim()).split("}")[0]+"}") as Map<String,dynamic>;

    /*   final Map<String,dynamic> result = {
            "message":"success","user_id":"1"};*/
    if(result["status"]=="1"){
    setState((){
    successtxt=result["message"];
    errtxt="";
    _fullnamecontroller.clear();
    _emailcontroller.clear();

    });
    } else{
    setState((){
    errtxt=result["message"];
    successtxt="";
    });
    }
    }else{
    setState((){
    successtxt="";
    errtxt="Please Check your Internet Connection And data";
    });
    }/*
    setState((){
    vaue.text="Please Check your Internet Connection And data";
    });*/
    }on TimeoutException catch (_) {
    setState((){
    successtxt="";
    errtxt="Please Check your Internet Connection And data";
    });
    //return false;
    }on Exception catch(e){
    setState((){
    errtxt=e.toString();
    successtxt="";

    });

    }
    }
    }, child: Text("Register",),
    style: ElevatedButton.styleFrom(
    primary: Colors.orange,
    minimumSize: Size(150, 40),
    shape: RoundedRectangleBorder( //to set border radius to button
    borderRadius: BorderRadius.circular(10)
    ),// NEW
    ),
    ),
    ElevatedButton(onPressed: (){
    /*final Map<String,String> data = {"entry_date":formatted,"entry_time":formatted1,
    'qrcode':eventid["value"],"member_type":Helper.type.toString(),"name":fullname,"gender":dropdownvalue1,"dob":dateInput.text,"address":address,"city":city,"state":state_1,"pincode":postalcode,"country":country,"marital_status":marital,"wed_anniversary":anniversaryInput.text,"no_of_child":children,"email":email,"phone_no":phone,"occupation":occupation};
    print("testing data"+data.toString());*/
    setState(()
    {
    _fullnamecontroller.clear();
    _emailcontroller.clear();
    });
    }, child: Text(
    "Reset",
    ),
    style: ElevatedButton.styleFrom(
    primary: Colors.blue,
    minimumSize: Size(150, 40),
    shape: RoundedRectangleBorder( //to set border radius to button
    borderRadius: BorderRadius.circular(10)
    ),// NEW
    ),
    ),
    Column(

    mainAxisAlignment: MainAxisAlignment.end,
    children: [
    SizedBox(height: 20,),
    Container(
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    TextButton(
    onPressed: (){
    Navigator.pushNamed(context, "/policy");
    },
    child:Text("Privacy Policy" ,
    textAlign: TextAlign.start,
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: Colors.blue,
    decoration: TextDecoration.underline

    ),
    )                          ),
    ],
    ),
    )

    ],
    ),
    ],
    ),
    ),
    )
    ),
    );
  }
}
