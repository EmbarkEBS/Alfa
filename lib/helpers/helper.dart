import 'package:shared_preferences/shared_preferences.dart';

class Helper{
  Future<bool> getAuth() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("user_type");
  }
}