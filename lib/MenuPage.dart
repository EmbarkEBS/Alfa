
import 'dart:convert';
import 'dart:io';

import 'package:churchIn/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'helpers/encrypter.dart';
import 'helpers/helper.dart';

class MenuPage extends StatefulWidget {
  const MenuPage() ;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {



  @override
  Widget build(BuildContext context) {
    final eventid = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return
      SingleChildScrollView(
          child:Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            /*Container(
          color: lightening_yellow,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/peep_standing_left.svg",
                width: 370,
                height: 590,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/peep_standing_right.svg",
                width: 370,
                height: 590,
              ),
            ],
          ),
        ),
        Positioned(
          left: 24,
          top: 56,
          child: ButtonRoundWithShadow(
            size: 48,
            iconPath: "assets/icons/close.svg",
            borderColor: black,
            shadowColor: black,
            color: white,
            callback: () {
              Navigator.of(context).pop();
            },
          ),
        ),*/

            Container(
              height: 780,
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              // margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(24),
              /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: white),*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  /*Column(
                children: [

                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                       /* SvgPicture.asset(
                          "assets/images/logo.svg",
                          width: 370,
                          height: 590,
                        ),*/

                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Alfa For Everyone",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Start now by selecting a status .",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: trout,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //FlutterLogo(size: 100,),
                      SvgPicture.asset(
                        "assets/images/alfanewlogo.svg",
                        width: 200,
                        height: 250,
                      ),
                     // SizedBox(),
                     /* Flexible(

                          child: Text("Alpha For \nEveryone",
                            style: TextStyle(
                              letterSpacing: 0,
                              fontWeight:FontWeight.bold,
                              fontSize: 24,
                              decoration: TextDecoration.none,
                              color: Colors.blue.shade900,

                            ),
                          )
                      ),*/
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        // color: wood_smoke,
                        // textColor: white,
                        // borderColor: wood_smoke,
                        //text: "FirstTimer",
                        /*onTap: () async {
                      SharedPreferences prefs = await SharedPreferences
                          .getInstance();
                      prefs.setString("user_type", "0");
                      Helper.type="0";
                      Navigator.pushNamed(context, "/scanner");
                    }, */
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen,
                          minimumSize: Size(250, 50),
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(10)
                          ),// NEW
                        ),
                        onPressed: () {
                          Helper.type="1";
                          Navigator.pushNamed(context, "/register",arguments: eventid);
                        }, child: Text(
                        "First Timer",
                      ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        //color: persian_blue,
                        //textColor: white,
                        //borderColor: persian_blue,
                        // text: "Current Member",
                        /*onTap: () async {
                      SharedPreferences prefs = await SharedPreferences
                          .getInstance();
                      prefs.setString("user_type", "1");
                      Helper.type="1";
                      Navigator.pushNamed(context, "/scanner");
                    },*/ onPressed: () {
                        Helper.type="3";
                        Navigator.pushNamed(context, "/register",arguments: eventid);
                      }, child: Text("Current member",style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          minimumSize: Size(250, 50),
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(10)
                          ),// NEW
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        //color: carribean_green,
                        //textColor: white,
                        //borderColor: carribean_green,
                        //text: "Signin For Children",
                        /*onTap: () async {
                      SharedPreferences prefs = await SharedPreferences
                          .getInstance();
                      prefs.setString("user_type", "2");
                      Helper.type="2";
                      Navigator.pushNamed(context, "/scanner");
                    }, */
                        onPressed: ()  {

                          Helper.type="2";
                          Navigator.pushNamed(context, "/register",arguments: eventid);
                        },
                        child: Text(
                            "Sign-in for Children"
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff7E56C8),
                          minimumSize: Size(250, 50),
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(10)
                          ),// NEW
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        //color: carribean_green,
                        //textColor: white,
                        //borderColor: carribean_green,
                        //text: "Signin For Children",
                        /*onTap: () async {
                      SharedPreferences prefs = await SharedPreferences
                          .getInstance();
                      prefs.setString("user_type", "2");
                      Helper.type="2";
                      Navigator.pushNamed(context, "/scanner");
                    }, */
                        onPressed: ()  {

                          Helper.type="4";
                          Navigator.pushNamed(context, "/register",arguments: eventid);
                        },
                        child: Text(
                            "Event Entry"
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange.shade500,
                          minimumSize: Size(250, 50),
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(10)
                          ),// NEW
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            )
          ]) );
  }
}