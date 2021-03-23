import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {

  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN6";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY6";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY6";
  static String sharedPreferenceUserIdKey = "USERIDKEY6";

  static Future<bool> removeInfoSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.clear();
  }

  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool val = await preferences.getBool(sharedPreferenceUserLoggedInKey);
    if (val == null) return false;
    else return val;
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool> saveUserIdSharedPreference(String userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserIdKey, userEmail);
  }

  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserNameKey);
  }
  
  static Future<String> getUserIdSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserIdKey);
  }

  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }

}