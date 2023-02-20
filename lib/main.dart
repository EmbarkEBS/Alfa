import 'package:churchIn/utils/colors.dart';
import 'package:churchIn/widgets/button_plain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_splash/your_splash.dart';
import 'MenuPage.dart';
import 'RegisterPage.dart';
import 'ScannerPage.dart';
import 'helpers/helper.dart';

void main() {
  
    //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
                  home: SplashScreen.timed(
                            seconds: 5,
                    
                            route: MaterialPageRoute(builder: (_)=>MyHomePage(title: 'start now')),
                            body: Scaffold(
                                        body: Container(
                                                      child: Column(
                                                                      children: <Widget>[
                                                                                        SizedBox(height: 180,),
                                                                                        Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                            children: <Widget>[
                                                                                                                                  //FlutterLogo(size: 100,),
                                                                                                                                  SvgPicture.asset(
                                                                                                                                                          "assets/images/alfanewlogo.svg",
                                                                                                                                                          width: 300,
                                                                                                                                                          height: 300,
                                                                                                                                                        ),
                                                                                                                                ],
                                                                                                          ),
                                                                                        /*    Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                              children: [
                                                                                                                                                                  SizedBox(height: 80,),
                                                                                                                                                                                      SvgPicture.asset(
                                                                                                                                                                                                            "assets/images/splash-persons.svg",
                                                                                                                                                                                                                                  width: 300,
                                                                                                                                                                                                                                                        height: 215,
                                                                                                                                                                                                                                                                    fit: BoxFit.fitWidth,
                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                          ],
                                                                                                                                                                                                                                                                                                                          )*/
                                                                                        Container(
                                                                                                            width: 300,
                                                                                                            height: 200,
                                                                                                            child: OverflowBox(
                                                                                                                                  alignment: Alignment.center,
                                                                                                                                  maxWidth: 435,
                                                                                                                                  maxHeight: 438,
                                                                                                                                  child: Container(
                                                                                                                                                          // padding: EdgeInsets.all(12.0),
                                                                                                                                                          child: SvgPicture.asset(
                                                                                                                                                                                  'assets/images/alfasplashperson.svg',
                                                                                                                                                                                                          alignment: Alignment.bottomCenter,
                                                                                                                                                                                                                                  //allowDrawingOutsideViewBox: true,
                                                                                                                                                                                                                                                        ),
                                                                                                                                                        ),
                                                                                                                                ),
                                                                                                          ),
                                                                                      ],
                                                                    ),
                                                    ),
                                      ),
                          ),
                  //MyHomePage(title: 'Start Now'),
                  routes: {
                            '/scanner': (context) => ScannerPage(),
                            '/register': (context) => RegisterPage(),
                            '/menu': (context) => MenuPage(),
                  },
                );
    }
}

class MyHomePage extends StatefulWidget {
    const MyHomePage({Key? key,required this.title}) : super(key: key);
  
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
    void initState() {
          // Initialize notifications
          // PushNotificationsManager(context).init();
          super.initState();
      
    }
  
    @override
    Widget build(BuildContext context) {
          Helper helper=Helper();
        //  return FutureBuilder(future:helper.getAuth(),builder: (context, authResultSnapshot) {
            //FlutterNativeSplash.remove();
            return  ScannerPage();
        //  });
      
    }
}
