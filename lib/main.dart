import 'package:alfa/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ScannerPage.dart';
import 'helpers/helper.dart';

void main() {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp( AlfaApp());
}

class AlfaApp extends StatelessWidget {
   AlfaApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alfa',
      theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
          primaryColor: persian_blue),
      home:  MyHomePage(title: 'Start Now'),
      routes: {
        '/scanner': (context) => ScannerPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    Helper helper=Helper();
    return FutureBuilder(future:helper.getAuth(),builder: (context, authResultSnapshot)=>
      (authResultSnapshot.connectionState !=
          ConnectionState.waiting && authResultSnapshot.data==false)?
       Material(
        child: Container(
          color: white,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          "assets/images/onboarding_image_one.svg",
                          height: 320,
                          width: 320,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 12.0, bottom: 12.0),
                      child: Text(
                        "Alfa",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 36,
                            color: wood_smoke,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 12.0, bottom: 12.0),
                      child: Text(
                        "Start Now by selecting the status",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 21,
                            color: trout,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),

              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: RaisedButton(
                              padding: EdgeInsets.all(16),
                              color: white,
                              textColor: black,
                              onPressed: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("user_type", "1");

                          Navigator.pushNamed(context, "/scanner");
                              },
                              child: Text(
                                "Current Member",
                                style: TextStyle(
                                    fontSize: 21.0, fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(16.0),
                                  side: BorderSide(color: black, width: 2.0)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: RaisedButton(
                              padding: EdgeInsets.all(16),
                              color: white,
                              textColor: black,
                              onPressed: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("user_type", "2");

                          Navigator.pushNamed(context, "/scanner");
                              },
                              child: Text(
                                "Signing For Children",
                                style: TextStyle(
                                    fontSize: 21.0, fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(16.0),
                                  side: BorderSide(color: black, width: 2.0)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: RaisedButton(
                              padding: EdgeInsets.all(16),
                              color: wood_smoke,
                              textColor: white,
                              onPressed:() async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("user_type", "0");

                              },
                              child: Text(
                                "First Timer",
                                style: TextStyle(
                                    fontSize: 21.0, fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(16.0)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ):ScannerPage()
    );
  }
}
